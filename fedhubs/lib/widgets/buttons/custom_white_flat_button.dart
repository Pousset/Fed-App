import 'package:flutter/material.dart';

class CustomWhiteFlatButton extends StatelessWidget {
  const CustomWhiteFlatButton({
    Key? key,
    required this.width,
    required this.text,
    required this.color,
    this.fontSize = 20.0,
    this.onPressed,
  }) : super(key: key);
  final double width;
  final String text;
  final Color color;
  final double fontSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        // backgroundColor: onPressed != null
        //     ? Theme.of(context).secondaryHeaderColor
        //     : Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
        backgroundColor: Colors.white,
        // foregroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(120.0))),
      ),
      onPressed: () {},
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
