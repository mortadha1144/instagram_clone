import 'package:flutter/foundation.dart' show immutable, VoidCallback;
import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/rich_text/base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTap;

  const LinkText({
    required super.text,
    required this.onTap,
    super.style,
  });
}
