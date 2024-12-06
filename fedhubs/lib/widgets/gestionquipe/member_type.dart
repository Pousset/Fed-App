import 'package:flutter/material.dart';

class MembreTypeWidget extends StatefulWidget {
  const MembreTypeWidget({
    Key? key,
    required this.membertype,
  }) : super(key: key);

  final String membertype;
  @override
  State<MembreTypeWidget> createState() => _MembreTypeWidgetState();
}

class _MembreTypeWidgetState extends State<MembreTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: false,
          shape: const CircleBorder(
              side: BorderSide(color: Color.fromRGBO(245, 136, 93, 100))),
          onChanged: (bool? value) {
            setState(() {
              // isChecked = value!;
            });
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.membertype,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Et ipsa similique eum voluptas aperiam est suscipit suscipit quo dignissimos adipisci.',
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
