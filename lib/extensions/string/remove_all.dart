extension RemoveAll on String {
  /// Removes all occurrences of the specified values from this string.
  ///
  /// Example:
  /// ```dart
  /// 'Hello World'.removeAll(['H', 'W']); // 'ello orld'
  /// ```
  String removeAll(Iterable<String> values) => values.fold(
        this,
        (result, value) => result.replaceAll(
          value,
          '',
        ),
      );
}
