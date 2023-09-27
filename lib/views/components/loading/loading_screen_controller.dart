import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingScreenCallback = bool Function();
typedef UpdateLoadingScreenCallback = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreenCallback close;
  final UpdateLoadingScreenCallback update;

  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}