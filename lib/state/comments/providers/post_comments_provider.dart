import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comments/extention/comment_sorting_by_request.dart';
import 'package:instagram_clone/state/comments/models/comment.dart';
import 'package:instagram_clone/state/comments/models/post_comment_request.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';

final postCommentsProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, RequestForPostComments>(
  (
    ref,
    RequestForPostComments request,
  ) {
    final controller = StreamController<Iterable<Comment>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .where(
          FirebaseFieldName.postId,
          isEqualTo: request.postId,
        )
        .snapshots()
        .listen(
      (snapshot) {
        final document = snapshot.docs;
        final limitedDocument =
            request.limit != null ? document.take(request.limit!) : document;
        final comments = limitedDocument
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map((document) => Comment(document.data(), id: document.id));

        final result = comments.applySorting(request);
        controller.add(result);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
