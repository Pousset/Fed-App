import 'dart:convert';

PaymentMethods filtersFromJson(String str) =>
    PaymentMethods.fromJson(json.decode(str));

String filtersToJson(PaymentMethods data) => json.encode(data.toJson());

class PaymentMethods {
  PaymentMethods({
    required this.paymentMethods,
  });

  List<PaymentSection> paymentMethods;

  factory PaymentMethods.fromJson(Map<String, dynamic> json) => PaymentMethods(
        paymentMethods: List<PaymentSection>.from(
            json["body"].map((x) => PaymentSection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "body": List<Map<String, dynamic>>.from(
            paymentMethods.map((x) => x.toJson())),
      };
}

class PaymentSection {
  PaymentSection({
    required this.categoryName,
    required this.methods,
  });

  String categoryName;
  List<PaymentMethod> methods;

  factory PaymentSection.fromJson(Map<String, dynamic> json) {
    return PaymentSection(
      categoryName: json["category_name"],
      methods: (json["methods"] as Map<String, dynamic>)
          .entries
          .map((x) => PaymentMethod.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "category_name": categoryName,
        "filters": List<dynamic>.from(methods.map((x) => x.toJson())),
      };
}

class PaymentMethod {
  PaymentMethod({required this.id, required this.name});
  final String id;
  final String name;

  factory PaymentMethod.fromJson(MapEntry<String, dynamic> json) {
    return PaymentMethod(
      id: json.key,
      name: json.value,
    );
  }

  Map<String, dynamic> toJson() => {id: name};
}
