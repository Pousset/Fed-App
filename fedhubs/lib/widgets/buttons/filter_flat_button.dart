import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterFlatButton extends StatelessWidget {
  const FilterFlatButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.onPressed,
      this.textColor = Colors.black87,
      this.icon,
      this.isSelected = false,
      this.width,
      this.svgIcon,
      this.fontSize = 14.0,
      this.verticalPadding = 12.0,
      this.trailing})
      : super(key: key);

  final String text;
  final Icon? icon;
  final SvgPicture? svgIcon;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final bool isSelected;
  final double? width;
  final double fontSize;
  final double verticalPadding;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? this.color : Colors.white;
    final textColor = isSelected ? Colors.white : this.textColor;

    return MaterialButton(
      minWidth: width,
      onPressed: onPressed,
      color: color,
      elevation: 0,
      splashColor: Colors.grey.withOpacity(0.2),
      highlightColor: color.withAlpha(127),
      highlightElevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(120.0),
          side: BorderSide(color: this.color, width: 2)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // if (icon != null && isSelected) ...[
            //   icon!,
            //   const SizedBox(width: 16.0)
            // ],
            if (svgIcon != null) ...[svgIcon!, const SizedBox(width: 16.0)],
            Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
