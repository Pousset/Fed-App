import 'package:fedhubs_pro/models/section/entreprise_information_model.dart';
import 'package:fedhubs_pro/widgets/forms/custom_text_form_field.dart';
import 'package:fedhubs_pro/widgets/others/settings_page/entreprise_info_page/social_network_icon.dart';
import 'package:flutter/material.dart';

class SocialNetworkFormSection extends StatefulWidget {
  const SocialNetworkFormSection({
    super.key,
    required this.data,
    required this.model,
  });

  final EntrepriseInformationModel data;
  final EntrepriseInformationModel model;

  @override
  State<SocialNetworkFormSection> createState() =>
      _SocialNetworkFormSectionState();
}

class _SocialNetworkFormSectionState extends State<SocialNetworkFormSection> {
  late Map<String, bool> socialNetworkEnable;

  @override
  void initState() {
    socialNetworkEnable = {
      'facebook': widget.data.facebookUrlLink.isNotEmpty,
      'instagram': widget.data.instagramUrlLink.isNotEmpty,
      'linkedin': widget.data.linkedinUrlLink.isNotEmpty,
      'snapchat': widget.data.snapchatUrlLink.isNotEmpty,
      'twitter': widget.data.twitterUrlLink.isNotEmpty,
      'youtube': widget.data.youtubeUrlLink.isNotEmpty,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final separator = (MediaQuery.of(context).size.width - 48 - 40 * 6) / 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildSocialNetworkIcon(
                url: widget.data.facebookUrlLink, fileName: 'facebook'),
            SizedBox(width: separator),
            _buildSocialNetworkIcon(
                url: widget.data.instagramUrlLink, fileName: 'instagram'),
            SizedBox(width: separator),
            _buildSocialNetworkIcon(
                url: widget.data.linkedinUrlLink, fileName: 'linkedin'),
            SizedBox(width: separator),
            _buildSocialNetworkIcon(
                url: widget.data.snapchatUrlLink, fileName: 'snapchat'),
            SizedBox(width: separator),
            _buildSocialNetworkIcon(
                url: widget.data.twitterUrlLink, fileName: 'twitter'),
            SizedBox(width: separator),
            _buildSocialNetworkIcon(
                url: widget.data.youtubeUrlLink, fileName: 'youtube'),
          ],
        ),
        const SizedBox(height: 8),
        if (socialNetworkEnable['facebook']!) _buildFacebook(),
        if (socialNetworkEnable['instagram']!) _buildInstagram(),
        if (socialNetworkEnable['linkedin']!) _buildLinkedin(),
        if (socialNetworkEnable['snapchat']!) _buildSnapchat(),
        if (socialNetworkEnable['twitter']!) _buildTwitter(),
        if (socialNetworkEnable['youtube']!) _buildYoutube(),
      ],
    );
  }

  Widget _buildFacebook() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CustomTextFormField(
        initialValue: widget.data.facebookUrlLink,
        label: "Facebook",
        keyboardType: TextInputType.url,
        onSaved: (String? value) => widget.model.facebookUrlLink = value ?? '',
      ),
    );
  }

  Widget _buildInstagram() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CustomTextFormField(
        initialValue: widget.data.instagramUrlLink,
        label: "Instagram",
        keyboardType: TextInputType.url,
        onSaved: (String? value) => widget.model.instagramUrlLink = value ?? '',
      ),
    );
  }

  Widget _buildLinkedin() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CustomTextFormField(
        initialValue: widget.data.linkedinUrlLink,
        label: "Linkedin",
        keyboardType: TextInputType.url,
        onSaved: (String? value) => widget.model.linkedinUrlLink = value ?? '',
      ),
    );
  }

  Widget _buildSnapchat() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CustomTextFormField(
        initialValue: widget.data.snapchatUrlLink,
        label: "Snapchat",
        keyboardType: TextInputType.url,
        onSaved: (String? value) => widget.model.snapchatUrlLink = value ?? '',
      ),
    );
  }

  Widget _buildTwitter() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CustomTextFormField(
        initialValue: widget.data.twitterUrlLink,
        label: "Twitter",
        keyboardType: TextInputType.url,
        onSaved: (String? value) => widget.model.twitterUrlLink = value ?? '',
      ),
    );
  }

  Widget _buildYoutube() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CustomTextFormField(
        initialValue: widget.data.youtubeUrlLink,
        label: "Youtube",
        keyboardType: TextInputType.url,
        onSaved: (String? value) => widget.model.youtubeUrlLink = value ?? '',
      ),
    );
  }

  Widget _buildSocialNetworkIcon(
      {required String url, required String fileName}) {
    return SocialNetworkIcon(
      url: url,
      fileName: fileName,
      enable: socialNetworkEnable[fileName]!,
      setEnable: (v) => setState(() => socialNetworkEnable[fileName] = v),
    );
  }
}
