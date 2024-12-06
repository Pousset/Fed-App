import 'package:flutter/material.dart';

class IconTextDialog extends StatefulWidget {
  const IconTextDialog({Key? key, required this.icon, required this.text})
      : super(key: key);

  final Icon icon;
  final String text;
  @override
  State<IconTextDialog> createState() => _IconTextDialogState();
}

class _IconTextDialogState extends State<IconTextDialog> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.icon,
        const SizedBox(
          width: 30,
        ),
        Text(
          widget.text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
