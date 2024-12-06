import 'package:fedhubs_pro/models/account_handling/redirection_account_to_enterprise.dart';
import 'package:fedhubs_pro/models/user.dart';
import 'package:fedhubs_pro/screens/companies/direct_control.dart';
import 'package:fedhubs_pro/screens/login_forms/login.dart';
import 'package:fedhubs_pro/services/auth.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/local_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompaniesAccountListPage extends StatefulWidget {
  const CompaniesAccountListPage({Key? key}) : super(key: key);

  @override
  CompaniesAccountListState createState() => CompaniesAccountListState();
}

class CompaniesAccountListState extends State<CompaniesAccountListPage> {
  Future<RedirectionAccountToEnterprise?>? _listEnterpriseModel;
  late ApiReadEnterprise apiRead;
  late User user;
  late String jwt;
  String appBarTitle = 'Liste des entreprises';
  late int _idClient;

  @override
  void initState() {
    apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    redirection();
    super.initState();
  }

  void redirection() async {
    user = Provider.of<Auth>(context, listen: false).currentUser!;
    setState(() {
      jwt = user.token;
    });
    setState(() {
      if (!Provider.of<Auth>(context).loginState.checkLoggedIn()) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SimpleLoginScreen()));
      }
    });

    // ignore: unnecessary_null_comparison
    if (jwt == null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SimpleLoginScreen()));
    }

    _listEnterpriseModel = apiRead.redirectionEnterprise();
    await _listEnterpriseModel!.then((result) {
      if (result == null) return;
      if (kDebugMode) {
        print(result.countCompany);
      }
      setState(() {
        if (result.countCompany == 1) {
          _idClient = result.enterpriseBody![0].id;
          //print(_idClient);
          LocalDatabase().setCompany('$_idClient', result.idAccount!);

          //print(_idClient);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Colors.black,
      ),
      body: GestureDetector(child: _listEnterprises(_listEnterpriseModel)),
    );
  }

  Widget _listEnterprises(
      Future<RedirectionAccountToEnterprise?>? enterprisesList) {
    // ignore: unnecessary_null_comparison
    if (enterprisesList == null) {
      return const SizedBox(height: 0);
    } else {
      return FutureBuilder<RedirectionAccountToEnterprise?>(
        future: enterprisesList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.enterpriseBody!.length,
              itemBuilder: (BuildContext context, int index) {
                dynamic displayEnterprises =
                    snapshot.data?.enterpriseBody![index];

                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DirectControl(displayEnterprises?.idClient)));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                if (displayEnterprises?.backgroundImage != null)
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      child: Image.network(
                                          displayEnterprises.backgroundImage,
                                          width: 70,
                                          height: 70),
                                    ),
                                  ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(displayEnterprises.companyName,
                                            style: DefaultTextStyle.of(context)
                                                .style
                                                .apply(
                                                    fontSizeFactor: 1.2,
                                                    fontWeightDelta: 3)),
                                        const SizedBox(height: 5),
                                        const SizedBox(height: 5),
                                        Text(displayEnterprises.address,
                                            overflow: TextOverflow.fade,
                                            style: const TextStyle(
                                                fontStyle: FontStyle.italic),
                                            textAlign: TextAlign.justify),
                                      ]),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ));
              },
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      );
    }
  }
}
