import 'dart:math';
import 'package:fedhubs_pro/widgets/others/settings_page/expansion_tile_text.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final String title;
  final Map<String, dynamic> children;

  Size _textSize(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double rightPadding =
        max(0, screenWidth - _textSize(title).width - 138);

    final color = Theme.of(context).secondaryHeaderColor;

    final childrens = children.entries.toList();

    return ExpansionTile(
      textColor: Colors.black,
      iconColor: color,
      collapsedIconColor: color,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      childrenPadding: const EdgeInsets.only(left: 32, top: 8),
      tilePadding: EdgeInsets.only(right: rightPadding),
      title: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: color, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
      ),
      children: List.generate(childrens.length, (index) {
        final children = childrens[index];

        bool isWidget = true;

        try {
          children.value as Widget;
        } catch (e) {
          isWidget = false;
        }

        return ExpansionTileText(
          text: children.key,
          page: isWidget ? children.value : null,
          action: !isWidget ? children.value : null,
        );
      }),
    );
  }
}
