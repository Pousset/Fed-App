import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateFormField extends StatefulWidget {
  const CustomDateFormField({
    super.key,
    this.initialValue,
    required this.label,
    this.errorText,
    required this.onChanged,
    this.textStyle,
    this.width = double.infinity,
    this.controller,
  }) : assert((initialValue != null) ^ (controller != null));

  final DateTime? initialValue;
  final TextEditingController? controller;
  final String label;
  final String? errorText;
  final TextStyle? textStyle;
  final double width;
  final void Function(DateTime?) onChanged;

  @override
  State<CustomDateFormField> createState() => _CustomDateFormFieldState();
}

class _CustomDateFormFieldState extends State<CustomDateFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          constraints: BoxConstraints(maxWidth: widget.width),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DateTimeField(
            initialValue: widget.initialValue,
            style: widget.textStyle ??
                TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  fontWeight: Theme.of(context).textTheme.bodyLarge!.fontWeight,
                ),
            resetIcon: null,
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: Theme.of(context).textTheme.labelMedium,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              errorStyle: const TextStyle(height: 0),
            ),
            cursorColor: const Color(0x99000000),
            format: DateFormat("HH:mm"),
            onChanged: widget.onChanged,
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
        ),
      ],
    );
  }
}
