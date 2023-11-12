import 'package:instagram_clone/enums/sort_dating.dart';
import 'package:instagram_clone/state/comments/models/comment.dart';
import 'package:instagram_clone/state/comments/models/post_comment_request.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> applySorting(RequestForPostComments request) {
    if (request.sortByCreatedAt) {
      final sortedDocuments = toList()
        ..sort(
          (a, b) {
            switch (request.dateSorting) {
              case DateSorting.newestOnTop:
                return b.createdAt.compareTo(a.createdAt);
              case DateSorting.oldestOnTop:
                return a.createdAt.compareTo(b.createdAt);
            }
          },
        );
      return sortedDocuments;
    } else {
      return this;
    }
  }
}
