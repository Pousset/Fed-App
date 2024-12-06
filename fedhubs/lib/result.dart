import 'dart:convert';

import 'package:fedhubs_pro/models/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


// ignore: must_be_immutable
class Result extends StatelessWidget {
  /*InfoFacadeWeb model;
  Result({this.model});*/

  /*InfoAffluence model1;
  Result({this.model1});*/

  /*InfoEssentialWebsite model;
  Result({this.model});*/

  /*InfoTimeOpening model;
  Result({this.model});*/

 /* InfoSocialNetwork model;
  Result({this.model});*/

 /* InfoComfortAvailability model;
  Result({this.model});*/

/*  InfoPayments model;
  Result({this.model});*/

 /* InfoServicesExt model;
  Result({this.model});*/

  /*InfoMenu model;
  Result({this.model}); */

  Events? model;
  Result({Key? key, this.model}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: const Text('Successful')),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             /* Text(model.company, style: TextStyle(fontSize: 22)),
              if(model.bytesImageBackground!=null)
              Image.memory(
                model.bytesImageBackground,
                // base64Decode(model.base64String)
                width: 300,
                height: 300,
                fit: BoxFit.fitHeight,
              ),
              Text(model.typeActivity, style: TextStyle(fontSize: 22)),
              if(model.bytesImageProfile!=null)
              Image.memory(
                model.bytesImageProfile,
                // base64Decode(model.base64String)
                width: 300,
                height: 300,
                fit: BoxFit.fitHeight,
              ),
              Text(model.speciality, style: TextStyle(fontSize: 22)),
              Text(model.description, style: TextStyle(fontSize: 22)),*/

              /*Text(model1.infoFeuRouge, style: TextStyle(fontSize: 22)),
              Text(model1.infoFeuOrange, style: TextStyle(fontSize: 22)),
              Text(model1.infoFeuVert, style: TextStyle(fontSize: 22)),
              Text(model1.infoSup, style: TextStyle(fontSize: 22)),*/

              /*if(model.telephoneNumber!=null)
              Text(model.telephoneNumber, style: TextStyle(fontSize: 22)),
              if(model.email!=null)
              Text(model.email, style: TextStyle(fontSize: 22)),
              if(model.websiteLink!=null)
              Text(model.websiteLink, style: TextStyle(fontSize: 22)),
              if(model.postalAdress!=null)
                Text(model.postalAdress, style: TextStyle(fontSize: 22)),
              if(model.reservationUrl!=null)
              Text(model.reservationUrl, style: TextStyle(fontSize: 22)),*/

              /*if(model.mondayHours!=null)
                Text(model.mondayHours, style: TextStyle(fontSize: 22)),
              if(model.tuesdayHours!=null)
                Text(model.tuesdayHours, style: TextStyle(fontSize: 22)),
              if(model.wednesdayHours!=null)
                Text(model.wednesdayHours, style: TextStyle(fontSize: 22)),
              if(model.thursdayHours!=null)
                Text(model.thursdayHours, style: TextStyle(fontSize: 22)),
              if(model.fridayHours!=null)
                Text(model.fridayHours, style: TextStyle(fontSize: 22)),
              if(model.saturdayHours!=null)
                Text(model.saturdayHours, style: TextStyle(fontSize: 22)),
              if(model.sundayHours!=null)
                Text(model.sundayHours, style: TextStyle(fontSize: 22)),*/

              /*if(model.facebookLink!=null)
                Text(model.facebookLink, style: TextStyle(fontSize: 22)),
              if(model.instagramLink!=null)
                Text(model.instagramLink, style: TextStyle(fontSize: 22)),
              if(model.linkedinLink!=null)
                Text(model.linkedinLink, style: TextStyle(fontSize: 22)),
              if(model.twitterLink!=null)
                Text(model.twitterLink, style: TextStyle(fontSize: 22)),
              if(model.youtubeLink!=null)
                Text(model.youtubeLink, style: TextStyle(fontSize: 22)),
              if(model.pinterestLink!=null)
                Text(model.pinterestLink, style: TextStyle(fontSize: 22)),
              if(model.snapchatLink!=null)
                Text(model.snapchatLink, style: TextStyle(fontSize: 22)),
              if(model.tikTokLink!=null)
                Text(model.tikTokLink, style: TextStyle(fontSize: 22)),*/

              /*if(model.toilet!=null)
                Text("Toilettte ="+model.toilet.toString(), style: TextStyle(fontSize: 22)),
              if(model.wifi!=null)
                Text("Wifi ="+model.wifi.toString(), style: TextStyle(fontSize: 22)),
              if(model.tv!=null)
                Text("TV ="+model.tv.toString(), style: TextStyle(fontSize: 22)),
              if(model.music!=null)
                Text("Musique ="+model.music.toString(), style: TextStyle(fontSize: 22)),
              if(model.handicap!=null)
                Text("Handicap ="+model.handicap.toString(), style: TextStyle(fontSize: 22)),*/

              /*if(model.cash !=null)
                Text("Espèce ="+model.cash.toString(), style: TextStyle(fontSize: 22)),
              if(model.card !=null)
                Text(" Carte ="+model.card.toString(), style: TextStyle(fontSize: 22)),
              if(model.paymentNoContact !=null)
                Text(" Paiement sans contact ="+model.paymentNoContact.toString(), style: TextStyle(fontSize: 22)),
              if(model.qrCode !=null)
                Text("QR code ="+model.qrCode.toString(), style: TextStyle(fontSize: 22)),
              if(model.virement !=null)
                Text("Virement ="+model.virement.toString(), style: TextStyle(fontSize: 22)),
              if(model.chequeBank !=null)
                Text("Cheque ="+model.chequeBank.toString(), style: TextStyle(fontSize: 22)),
              if(model.restaurantTicket !=null)
                Text("Ticket Restaurant ="+model.restaurantTicket.toString(), style: TextStyle(fontSize: 22)),
              if(model.chequeHoliday !=null)
                Text("Cheque vancance ="+model.chequeHoliday.toString(), style: TextStyle(fontSize: 22)),
              if(model.coupon !=null)
                Text("Coupon ="+model.coupon.toString(), style: TextStyle(fontSize: 22)),*/

              /*if(model.sellInPlace !=null)
                Text("Consommation sur place ="+model.sellInPlace.toString(), style: TextStyle(fontSize: 22)),
              if(model.takeAway !=null)
                Text(" Vente à emporter ="+model.takeAway.toString(), style: TextStyle(fontSize: 22)),
              if(model.deliver !=null)
                Text(" Livraison ="+model.deliver.toString(), style: TextStyle(fontSize: 22)),
              if(model.urlUberEats!=null)
                Text(model.urlUberEats, style: TextStyle(fontSize: 22)),
              if(model.urlDeliveroo!=null)
                Text(model.urlDeliveroo, style: TextStyle(fontSize: 22)),
              if(model.urlJustEat!=null)
                Text(model.urlJustEat, style: TextStyle(fontSize: 22)),
              if(model.ownDeliver !=null)
                Text(" Livraison Propre ="+model.ownDeliver.toString(), style: TextStyle(fontSize: 22)),*/

              /*if(model.urlMenu!=null)
                Text(model.urlMenu, style: TextStyle(fontSize: 22)),
              if(model.urlDrinks!=null)
                Text(model.urlDrinks, style: TextStyle(fontSize: 22)),
              if(model.catalogName!=null)
                Text(model.catalogName, style: TextStyle(fontSize: 22)),

              if(model.urlCatalogue!=null)
                Text(model.urlCatalogue, style: TextStyle(fontSize: 22)),*/

              if(model!.eventName!=null)
                Text(model!.eventName!, style: const TextStyle(fontSize: 22)),
              if(model!.descriptionEvent!=null)
                Text(model!.descriptionEvent!, style: const TextStyle(fontSize: 22)),
              // ignore: unnecessary_null_comparison
              if(model!.startEventDateTime.toString()!=null)
                Text(model!.startEventDateTime.toString(), style: const TextStyle(fontSize: 22)),
              // ignore: unnecessary_null_comparison
              if(model!.endEventDateTime.toString()!=null)
                Text(model!.endEventDateTime.toString(), style: const TextStyle(fontSize: 22)),
              /*if(model.bytesImageEvent!=null)
                SizedBox(
                  child:SvgPicture.memory(
                      model.bytesImageEvent,
                      fit: BoxFit.fitHeight,
                    ),
                  width:100,
                  height: 100,
                ),*/
              if(model!.urlImg==null)
                Image.memory(
                  base64Decode(model!.base64Event),
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,
                )
              else
                SvgPicture.network(
                  model!.urlImg!,
                  width: 300,
                  height: 300,
                  fit: BoxFit.fitHeight,
                ),
            ],
          ),
        ),
      ),
    ));
  }
}