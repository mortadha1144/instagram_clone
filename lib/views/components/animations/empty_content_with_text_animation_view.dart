import 'package:flutter/material.dart';

import 'empty_content_animation_view.dart';

class EmptyContentWithTextAnimationView extends StatelessWidget {
  final String text;
  const EmptyContentWithTextAnimationView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white54),
          ),
        ),
        const EmptyContetnAnimationView(),
      ],
    );
  }
}
