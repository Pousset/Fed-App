import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.initialValue,
    required this.label,
    this.errorText,
    required this.onSaved,
    this.keyboardType,
    this.maxLines = 1,
    this.textStyle,
    this.width = double.infinity,
    this.onEditingComplete,
    this.controller,
    this.validator,
  }) : assert((initialValue != null) ^ (controller != null));

  final String? initialValue;
  final TextEditingController? controller;
  final String label;
  final String? errorText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextStyle? textStyle;
  final double width;
  final String Function(String?)? validator;
  final void Function(String?) onSaved;
  final VoidCallback? onEditingComplete;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController controller;
  bool error = false;

  @override
  void initState() {
    controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    super.initState();
  }

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
              color: error
                  ? Theme.of(context).colorScheme.error
                  : Colors.black.withOpacity(0.2),
              width: error ? 1.2 : 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: TextFormField(
            controller: controller,
            style: widget.textStyle ??
                TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  fontWeight: Theme.of(context).textTheme.bodyLarge!.fontWeight,
                ),
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
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            //maxLength: 10,
            validator: (String? value) {
              if (value!.isEmpty && widget.errorText != null) {
                setState(() => error = true);
                return '';
              }
              if (widget.validator != null) {
                if (widget.validator!(value).isNotEmpty) {
                  setState(() => error = true);
                  return '';
                }
              }

              setState(() => error = false);
              return null;
            },
            onChanged: (value) => setState(() => error = false),
            onSaved: widget.onSaved,
            onEditingComplete: widget.onEditingComplete,
          ),
        ),
        if (error && widget.errorText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                  fontSize: 12, color: Theme.of(context).colorScheme.error),
            ),
          ),
      ],
    );
  }
}
