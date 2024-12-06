import 'dart:convert';

import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';

Filters filtersFromJson(String str) => Filters.fromJson(json.decode(str));

String filtersToJson(Filters data) => json.encode(data.toJson());

Future<Filters> createFilters(ApiReadEnterprise api) async =>
    Filters(filters: await api.fetchFilters());

class Filters {
  Filters({
    required this.filters,
  });

  List<FilterSection> filters;

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        filters: List<FilterSection>.from(
            json["body"].map((x) => FilterSection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "body": List<Map<String, dynamic>>.from(filters.map((x) => x.toJson())),
      };
}

class FilterSection {
  FilterSection({
    required this.categoryName,
    required this.filters,
  });

  String categoryName;
  List<Filter> filters;

  factory FilterSection.fromJson(Map<String, dynamic> json) {
    return FilterSection(
      categoryName: json["category_name"],
      filters: (json["filters"] as Map<String, dynamic>)
          .entries
          .map((x) => Filter.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "category_name": categoryName,
        "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
      };

  @override
  String toString() => toJson().toString();
}

class Filter {
  Filter({required this.id, required this.name, required this.isSelected});
  final String id;
  final String name;
  bool isSelected;

  factory Filter.fromJson(MapEntry<String, dynamic> json) {
    return Filter(
      id: json.key,
      name: json.value,
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() => {id: name};

  @override
  String toString() => toJson().toString();
}
