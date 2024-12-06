import 'package:flutter/material.dart';

class TextFormTile extends StatelessWidget {
  const TextFormTile({
    Key? key,
    required this.subject,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String subject;
  final String title;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        icon,
        const SizedBox(
          width: 15,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.withOpacity(0.9),
                ),
              ),
              Text(
                subject,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
