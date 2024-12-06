
import 'dart:typed_data';

class InfoFacadeWeb {
 // File imageBackground;
 // String imageBackgroundPath;
  Uint8List? bytesImageBackground;
  Uint8List? bytesImageProfile;

 // File imageProfile;
 // String imageProfilePath;

  String? company;
  String? typeActivity;
  String? speciality;
  String? description;
  String? activityType;

  /*List<String> activityType = [
    "Restaurant",
    "Bar",
    "Tabac",
    "Supermarché",
  ];*/

  InfoFacadeWeb({this.company, this.bytesImageBackground, this.bytesImageProfile, this.typeActivity,this.speciality,this.description});
}

class InfoAffluence {

  String? infoFeuRouge;
  String? infoFeuOrange;
  String? infoFeuVert;
  String? infoSup;

  InfoAffluence({this.infoFeuRouge,this.infoFeuOrange,this.infoFeuVert,this.infoSup });
}

class InfoEssentialWebsite {

  String? telephoneNumber;
  String? email;
  String? websiteLink;
  String? postalAddress;
  String? reservationUrl;

  InfoEssentialWebsite({this.telephoneNumber,this.email,this.websiteLink,this.postalAddress, this.reservationUrl});
}

class InfoTimeOpening {
  String? mondayHours;
  String? tuesdayHours;
  String? wednesdayHours;
  String? thursdayHours;
  String? fridayHours;
  String? saturdayHours;
  String? sundayHours;

  InfoTimeOpening({this.mondayHours,this.tuesdayHours,this.wednesdayHours,this.thursdayHours,this.fridayHours,this.saturdayHours,this.sundayHours});
}

class InfoSocialNetwork {
  String? facebookLink;
  String? instagramLink;
  String? linkedinLink;
  String? twitterLink;
  String? pinterestLink;
  String? youtubeLink;
  String? snapchatLink;
  String? tikTokLink;

  InfoSocialNetwork({this.facebookLink,this.instagramLink,this.linkedinLink,this.pinterestLink,this.youtubeLink,this.snapchatLink,this.tikTokLink});
}

class InfoComfortAvailability {
  bool? toilet;
  bool? wifi;
  bool? tv;
  bool? music;
  bool? handicap;
  bool? terrasse;

  InfoComfortAvailability({this.toilet,this.wifi,this.tv, this.music, this.handicap, this.terrasse});
}

class InfoServicesExt {
  bool? sellInPlace;
  bool? takeAway;
  bool? deliver;
  bool? ownDeliver;
  String? urlUberEats;
  String? urlDeliveroo;
  String? urlJustEat;

  InfoServicesExt({this.sellInPlace,this.takeAway,this.deliver, this.ownDeliver,this.urlUberEats,this.urlDeliveroo,this.urlJustEat});
}


class InfoPayments {

  bool? cash;
  bool? card;
  bool? chequeBank;
  bool? virement;
  bool? paymentNoContact;
  bool? qrCode;
  bool? restaurantTicket;
  bool? chequeHoliday;
  bool? coupon;

  InfoPayments({this.cash,this.card,this.chequeBank,this.virement,this.paymentNoContact,this.qrCode,this.restaurantTicket,this.chequeHoliday,this.coupon});
}

class InfoMenu {

  String? urlMenu;
  String? urlDrinks;
  String? catalogName;
  String? urlCatalogue;


  InfoMenu({this.urlMenu,this.urlDrinks,this.catalogName, this.urlCatalogue});
}
