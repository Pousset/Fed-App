// To parse this JSON data, do
//
//     final socialLinksSect5 = socialLinksSect5FromJson(jsonString);

import 'dart:convert';

import 'package:fedhubs_pro/services/functions.dart';

SocialLinksSect5 socialLinksSect5FromJson(String str) =>
    SocialLinksSect5.fromJson(json.decode(str));

String socialLinksSect5ToJson(SocialLinksSect5 data) =>
    json.encode(data.toJson());

class SocialLinksSect5 {
  SocialLinksSect5({
    this.idClient,
    this.facebookUrlLink,
    this.instagramUrlLink,
    this.linkedinUrlLink,
    this.twitterUrlLink,
    this.youtubeUrlLink,
    this.pinterestUrlLink,
    this.snapchatUrlLink,
    this.tiktokUrlLink,
  });

  String? idClient;
  String? facebookUrlLink;
  dynamic instagramUrlLink;
  dynamic linkedinUrlLink;
  dynamic twitterUrlLink;
  dynamic youtubeUrlLink;
  dynamic pinterestUrlLink;
  dynamic snapchatUrlLink;
  dynamic tiktokUrlLink;

  factory SocialLinksSect5.fromJson(Map<String, dynamic> json) =>
      SocialLinksSect5(
        facebookUrlLink: clean(json["facebook_url_link"]),
        instagramUrlLink: clean(json["instagram_url_link"]),
        linkedinUrlLink: clean(json["linkedin_url_link"]),
        twitterUrlLink: clean(json["twitter_url_link"]),
        youtubeUrlLink: clean(json["youtube_url_link"]),
        pinterestUrlLink: clean(json["pinterest_url_link"]),
        snapchatUrlLink: clean(json["snapchat_url_link"]),
        tiktokUrlLink: clean(json["tiktok_url_link"]),
      );

  Map<String, dynamic> toJson() => {
        "id_client": idClient,
        "facebook_url_link": facebookUrlLink,
        "instagram_url_link": instagramUrlLink,
        "linkedin_url_link": linkedinUrlLink,
        "twitter_url_link": twitterUrlLink,
        "youtube_url_link": youtubeUrlLink,
        "pinterest_url_link": pinterestUrlLink,
        "snapchat_url_link": snapchatUrlLink,
        "tiktok_url_link": tiktokUrlLink,
      };
}
