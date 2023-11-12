import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/image_upload/exceptions/could_not_build_thumbnail_exeption.dart';
import 'package:instagram_clone/state/image_upload/extensions/get_collection_name_from_file_type.dart';
import 'package:instagram_clone/state/image_upload/extensions/get_image_data_aspect_ratio.dart';
import 'package:instagram_clone/state/image_upload/models/file_type.dart';
import 'package:instagram_clone/state/image_upload/typedefs/is_loading.dart';
import 'package:instagram_clone/state/post_settings/models/post_setting.dart';
import 'package:instagram_clone/state/posts/models/post_payload.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../constants/constants.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> uploadImage({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSetting, bool> postSettings,
    required UserId userId,
  }) async {
    isLoading = true;
    late Uint8List thumbnailUint8List;
    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailExeption();
        }
        // create thumbnail
        final thumbnail = img.copyResize(
          fileAsImage,
          width: Constants.immageThumbnailWidth,
        );
        thumbnailUint8List = img.encodeJpg(thumbnail);

        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: Constants.videoThumbnailMaxHeight,
          quality: Constants.videoThumbnailQuality,
        );
        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailExeption();
        } else {
          thumbnailUint8List = thumb;
        }

        break;
    }
    // calculate the aspect ratio
    final thumbnailAspectRatio = await thumbnailUint8List.getAspectRatio();

    // calculate references

    final fileName = const Uuid().v4();

    // create references to the thumbnail and the image itself

    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);

    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);

    try {
      // upload the thumbnail
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.fullPath;
      // upload the original file
      final originalFileUploadTask = await originalFileRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.fullPath;

      // upload the post
      final postPayLoad = PostPayload(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalFileRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbnailAspectRatio,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalFileStorageId,
        postsettings: postSettings,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayLoad);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
