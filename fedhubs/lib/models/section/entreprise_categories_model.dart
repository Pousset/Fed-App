import 'dart:convert';
import 'package:flutter/material.dart';

EntrepriseCategoriesModel entrepriseCategoriesModelFromJson(String str) =>
    EntrepriseCategoriesModel.fromJson(json.decode(str));

String entrepriseCategoriesModelToJson(EntrepriseCategoriesModel data) =>
    json.encode(data.toJson());

class EntrepriseCategoriesModel with ChangeNotifier {
  List<String>? filters;
  List<String>? paymentMethods;
  List<String>? tags;
  int price;

  notify() => notifyListeners();

  EntrepriseCategoriesModel({
    this.price = 0,
    this.paymentMethods,
    this.filters,
    this.tags,
  });

  factory EntrepriseCategoriesModel.fromJson(Map<String, dynamic> json) {
    json["category"] ??= [];
    json["paymentmethod"] ??= [];
    json["tags"] ??= [];

    return EntrepriseCategoriesModel(
      price: json["price_range"] ?? 0,
      filters: List<String>.from(json["category"]
          .map((cat) => cat['methods'].keys.toList())
          .expand((i) => i as List)),
      paymentMethods: List<String>.from(json["paymentmethod"]
          .map((cat) => cat['methods'].keys.toList())
          .expand((i) => i as List)),
      tags: List<String>.from(json["tags"].map((e) => e['company_tag_label'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "filters": filters?.join(',') ?? [],
      "payment_methods": paymentMethods?.join(',') ?? [],
      "price": price,
      "tags": tags?.join(',') ?? []
    };
  }

  @override
  String toString() => toJson().toString();
}
