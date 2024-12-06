import 'dart:convert';
import 'package:fedhubs_pro/services/functions.dart';

EntrepriseInformationModel entrepriseInformationModelFromJson(String str) =>
    EntrepriseInformationModel.fromJson(json.decode(str));

String entrepriseInformationModelToJson(EntrepriseInformationModel data) =>
    json.encode(data.toJson());

class EntrepriseInformationModel {
  EntrepriseInformationModel({
    this.idClient,
    this.companyName,
    this.typeActivity,
    this.description,
    this.phoneNumber,
    this.email,
    this.websiteLink,
    this.facebookUrlLink = '',
    this.instagramUrlLink = '',
    this.linkedinUrlLink = '',
    this.twitterUrlLink = '',
    this.snapchatUrlLink = '',
    this.youtubeUrlLink = '',
    this.address,
  });

  String? idClient;
  String? backgroundImage;
  String? logo;
  String? companyName;
  String? typeActivity;
  String? description;
  String? phoneNumber;
  String? email;
  String? websiteLink;
  String facebookUrlLink;
  String instagramUrlLink;
  String linkedinUrlLink;
  String snapchatUrlLink;
  String twitterUrlLink;
  String youtubeUrlLink;
  String? address;

  factory EntrepriseInformationModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> socialNetworks =
        json["socialNetwork"].map<Map<String, dynamic>>((e) {
      return {
        'id': e['social_network_id'] as int? ?? 0,
        'name': e['social_network_name'] as String? ?? '',
        'url': e['social_network_url'] as String? ?? ''
      };
    }).toList();

    String getLinkUrl(String name) {
      final links = socialNetworks
          .where((e) => e['social_network_name'] == name)
          .toList();
      if (links.isEmpty) {
        return '';
      } else {
        return clean(links[0]["social_network_url"]) ?? '';
      }
    }

    return EntrepriseInformationModel(
      companyName: clean(json["company_name"]),
      description: clean(json["description"]),
      typeActivity: clean(json["type_activity"]),
      phoneNumber: clean(json["phone_number"]),
      email: clean(json["email"]),
      websiteLink: clean(json["website_link"]),
      facebookUrlLink: getLinkUrl('facebook'),
      instagramUrlLink: getLinkUrl('instagram'),
      linkedinUrlLink: getLinkUrl('linkedin'),
      twitterUrlLink: getLinkUrl('twitter'),
      snapchatUrlLink: getLinkUrl('snapchat'),
      youtubeUrlLink: getLinkUrl('youtube'),
      address: clean(json["address"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id_client": idClient,
        "company_name": companyName,
        "description": description,
        "type_activity": typeActivity,
        "phone_number": phoneNumber,
        "email": email,
        "website_link": websiteLink,
        "facebook_url_link": facebookUrlLink,
        "instagram_url_link": instagramUrlLink,
        "linkedin_url_link": linkedinUrlLink,
        "twitter_url_link": twitterUrlLink,
        "snapchat_url_link": snapchatUrlLink,
        "youtube_url_link": youtubeUrlLink,
        "address": address,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
