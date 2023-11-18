import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/enums/sort_dating.dart';
import 'package:instagram_clone/state/posts/typedefs/post_id.dart';

@immutable
class RequestForPostComments {
  final PostId postId;
  final bool sortByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;

  const RequestForPostComments({
    required this.postId,
     this.sortByCreatedAt = true,
     this.dateSorting = DateSorting.newestOnTop,
     this.limit,
  });

  @override
  bool operator ==(covariant RequestForPostComments other) =>
      postId == other.postId &&
      sortByCreatedAt == other.sortByCreatedAt &&
      dateSorting == other.dateSorting &&
      limit == other.limit;
  
  @override
  int get hashCode => Object.hashAll(
    [
      postId,
      sortByCreatedAt,
      dateSorting,
      limit,
    ],
  );
}
