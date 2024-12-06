import 'package:flutter/material.dart';

class ExpansionTileText extends StatelessWidget {
  const ExpansionTileText({
    Key? key,
    required this.text,
    this.page,
    this.action,
    this.bottom = 24,
  })  : assert(page != null || action != null),
        super(key: key);

  final String text;
  final Widget? page;
  final VoidCallback? action;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (page != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page!));
        } else {
          action!();
        }
      },
      onLongPress: () {},
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
