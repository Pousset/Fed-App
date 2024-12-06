import 'package:fedhubs_pro/models/section/sect1_visit_card.dart';
import 'package:fedhubs_pro/services/local/local_database.dart';
import 'package:flutter/material.dart';

class CompanyProvider extends ChangeNotifier {
  final local = LocalDatabase();

  String? get idAccount => local.getAccountId;
  String? get idClient => local.getCompany;

  Future<void> setCompany(String companyId, String accountId) async {
    local.setCompany(companyId, accountId);
    notifyListeners();
  }

  VisitCardSect1? visitcard;
}
