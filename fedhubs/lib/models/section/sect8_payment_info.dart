// To parse this JSON data, do
//
//     final paymentInfoSect8 = paymentInfoSect8FromJson(jsonString);

import 'dart:convert';

PaymentInfoSect8 paymentInfoSect8FromJson(String str) => PaymentInfoSect8.fromJson(json.decode(str));

String paymentInfoSect8ToJson(PaymentInfoSect8 data) => json.encode(data.toJson());

class PaymentInfoSect8 {
  PaymentInfoSect8({
    this.idClient,
    this.cashEnable,
    this.cardEnable,
    this.chequeEnable,
    this.bankTransferEnable,
    this.noContactEnable,
    this.qrCodeEnable,
    this.restaurantTicketEnable,
    this.couponEnable,
  });

  String? idClient;
  bool? cashEnable;
  bool? cardEnable;
  bool? chequeEnable;
  bool? bankTransferEnable;
  bool? noContactEnable;
  bool? qrCodeEnable;
  bool? restaurantTicketEnable;
  bool? couponEnable;

  factory PaymentInfoSect8.fromJson(Map<String, dynamic> json) => PaymentInfoSect8(
    cashEnable: int.parse(json["cash_enable"]) == 0 ? false : true,
    cardEnable: int.parse(json["card_enable"]) == 0 ? false : true,
    chequeEnable: int.parse(json["cheque_enable"]) == 0 ? false : true,
    bankTransferEnable: int.parse(json["bank_transfer_enable"]) == 0 ? false : true,
    noContactEnable: int.parse(json["nocontact_enable"]) == 0 ? false : true,
    qrCodeEnable: int.parse(json["qr_code_enable"]) == 0 ? false : true,
    restaurantTicketEnable: int.parse(json["restaurant_ticket_enable"]) == 0 ? false : true,
    couponEnable: int.parse(json["coupon_enable"]) == 0 ? false : true,
  );

  Map<String, dynamic> toJson() => {
    "id_client": idClient,
    "cash_enable": cashEnable== true ? 1 : 0,
    "card_enable": cardEnable== true ? 1 : 0,
    "cheque_enable": chequeEnable== true ? 1 : 0,
    "bank_transfer_enable": bankTransferEnable== true ? 1 : 0,
    "nocontact_enable": noContactEnable== true ? 1 : 0,
    "qr_code_enable": qrCodeEnable== true ? 1 : 0,
    "restaurant_ticket_enable": restaurantTicketEnable== true ? 1 : 0,
    "coupon_enable": couponEnable== true ? 1 : 0,
  };
}
