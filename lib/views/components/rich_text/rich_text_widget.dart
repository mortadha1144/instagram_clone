import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'base_text.dart';
import 'link_text.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> texts;
  final TextStyle? styleForAll;

  const RichTextWidget({
    super.key,
    required this.texts,
    this.styleForAll,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map(
          (text) {
            if (text is LinkText) {
              return TextSpan(
                text: text.text,
                style: styleForAll?.merge(text.style),
                recognizer: TapGestureRecognizer()..onTap = text.onTap,
              );
            }
            return TextSpan(
              text: text.text,
              style: styleForAll?.merge(text.style),
            );
          },
        ).toList(),
      ),
    );
  }
}
