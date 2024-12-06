import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key, this.popValue}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final popValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.of(context).pop(popValue)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
        child: Stack(
          children: [
            Icon(
              Icons.circle,
              color: Theme.of(context).secondaryHeaderColor,
              size: 40,
            ),
            const Positioned(
              left: 10,
              top: 11,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
