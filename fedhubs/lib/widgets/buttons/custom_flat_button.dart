import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({
    Key? key,
    required this.width,
    required this.text,
    required this.color,
    this.fontSize = 20.0,
    this.onPressed,
    this.icon,
  }) : super(key: key);
  final double width;
  final String text;
  final IconData? icon;
  final Color color;
  final double fontSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        // backgroundColor: onPressed != null
        //     ? Theme.of(context).secondaryHeaderColor
        //     : Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
        backgroundColor: const Color.fromRGBO(42, 45, 54, 1),
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(120.0))),
      ),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon!, color: Colors.white, size: 24),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              if (icon != null) const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
