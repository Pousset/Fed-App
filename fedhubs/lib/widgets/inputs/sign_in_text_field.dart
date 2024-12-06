import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInTextField extends StatefulWidget {
  const SignInTextField({
    Key? key,
    required this.label,
    this.hintText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction,
    this.onEditingComplete,
    this.isWrong = false,
    this.errorText,
    this.onChange,
    this.passwordStrength,
  }) : super(key: key);

  final String label;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onChange;
  final int? passwordStrength;
  final bool isWrong;
  final String? errorText;

  @override
  State<SignInTextField> createState() => _SignInTextFieldState();
}

class _SignInTextFieldState extends State<SignInTextField> {
  bool _showText = false;
  Color color = Colors.red.shade700;

  @override
  Widget build(BuildContext context) {
    if (widget.passwordStrength != null) {
      if (widget.passwordStrength! < 4) {
        color = Colors.red.shade700;
      }
      if (widget.passwordStrength! == 4) {
        color = Colors.orange.shade700;
      }
      if (widget.passwordStrength! == 5) {
        color = Colors.yellow.shade700;
      }
    }
    return SizedBox(
      height: 114,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 16),
            child: Text(
              widget.label,
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText && !_showText,
            obscuringCharacter: '\u2217',
            onTap: () => setState(() {}),
            onChanged: (_) =>
                widget.onChange != null ? widget.onChange!() : setState(() {}),
            cursorColor: const Color.fromRGBO(0, 0, 0, 0.6),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              errorMaxLines: 2,
              errorText: widget.isWrong ? widget.errorText : null,
              errorStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(0, 0, 0, 0.2),
              ),
              fillColor: Colors.white,
              prefixIconConstraints: const BoxConstraints(minWidth: 56),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                    width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                    width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                    width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(width: 2, color: color),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(width: 2, color: color),
              ),
              filled: true,
              suffixIconConstraints: const BoxConstraints(
                minHeight: 32,
                minWidth: 38,
                maxHeight: 32,
                maxWidth: 38,
              ),
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                      onTap: () => setState(() => _showText = !_showText),
                      onLongPress: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: SvgPicture.asset(
                          _showText
                              ? 'assets/show_password.svg'
                              : 'assets/hide_password.svg',
                          color: const Color.fromRGBO(0, 0, 0, 0.8),
                        ),
                      ),
                    )
                  : null,
            ),
            textInputAction: widget.textInputAction,
            onEditingComplete: widget.onEditingComplete,
          ),
        ],
      ),
    );
  }
}
