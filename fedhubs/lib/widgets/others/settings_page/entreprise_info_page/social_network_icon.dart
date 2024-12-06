import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialNetworkIcon extends StatelessWidget {
  const SocialNetworkIcon({
    Key? key,
    required this.url,
    required this.fileName,
    required this.enable,
    required this.setEnable,
  }) : super(key: key);
  final String url;
  final String fileName;
  final bool enable;
  final void Function(bool) setEnable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setEnable(!enable),
      child: SizedBox(
        height: 40,
        width: 40,
        child: SvgPicture.asset(
          'assets/social_network_images/$fileName.svg',
          color: Theme.of(context)
              .secondaryHeaderColor
              .withOpacity(enable ? 1 : 0.6),
        ),
      ),
    );
  }
}
