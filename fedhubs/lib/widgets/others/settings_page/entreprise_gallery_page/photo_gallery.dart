import 'dart:io';

import 'package:flutter/material.dart';

class PhotoGallery extends StatelessWidget {
  const PhotoGallery({
    super.key,
    this.url,
    this.file,
    required this.size,
    this.text,
    this.subText,
    this.onTap,
  }) : assert(url != null || file != null);

  final double size;
  final String? url;
  final File? file;
  final String? text;
  final String? subText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool haveText = text != null || subText != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints.tightFor(
          height: size,
          width: size,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: const Color(0x31000000)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: haveText
                      ? const BorderRadius.vertical(top: Radius.circular(20))
                      : const BorderRadius.all(Radius.circular(20)),
                ),
                child: _buildImage(),
              ),
            ),
            if (haveText)
              Container(
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                  color: Colors.white,
                ),
                width: size,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (text != null)
                        Text(
                          text!,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontSize: 12),
                        ),
                      if (subText != null)
                        Text(
                          subText!,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 11),
                        ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (url != null) {
      if (url!.isNotEmpty) {
        return Image(
          fit: BoxFit.cover,
          image: Image.network(
            url!,
          ).image,
          errorBuilder: (_, __, ___) => const SizedBox(),
        );
      }
    } else if (file != null) {
      return Image(
        fit: BoxFit.cover,
        image: Image.file(
          file!,
        ).image,
        errorBuilder: (_, __, ___) => const SizedBox(),
      );
    }
    return const SizedBox();
  }
}
