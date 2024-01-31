import 'package:flutter/material.dart';

class TProductTileText extends StatelessWidget {
  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign alignment;

  const TProductTileText(
      {super.key,
      required this.title,
      this.smallSize = false,
      this.maxLines = 2,
      this.alignment = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize
          ? Theme.of(context).textTheme.labelLarge
          : Theme.of(context).textTheme.labelSmall,
      maxLines: 2,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    );
  }
}
