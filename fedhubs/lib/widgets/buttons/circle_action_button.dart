import 'package:flutter/material.dart';

class CircleActionButton extends StatelessWidget {
  const CircleActionButton({
    Key? key,
    this.height = 40,
    this.left,
    this.top,
    this.right,
    this.bottom,
    required this.onPressed,
    required this.icon,
    required this.color,
    this.subColor = Colors.white,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final Color subColor;
  final VoidCallback onPressed;
  final double height;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: GestureDetector(
        onTap: onPressed,
        child: Stack(
          children: [
            Icon(
              Icons.circle,
              color: color,
              size: height,
            ),
            SizedBox(
              height: height,
              width: height,
              child: Icon(
                icon,
                color: subColor,
                size: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}
