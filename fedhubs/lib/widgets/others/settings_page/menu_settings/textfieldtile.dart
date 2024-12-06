import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
              isDense: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: title,
              hintStyle: const TextStyle(
                fontSize: 14,
              )),
          keyboardType: TextInputType.multiline,
          maxLines: 1,
        ),
      ],
    );
  }
}
