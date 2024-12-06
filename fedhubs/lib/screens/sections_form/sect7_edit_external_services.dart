// ignore_for_file: unnecessary_const

import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:fedhubs_pro/models/section/sect7_external_services.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormEditServicesExtInfoPage extends StatefulWidget {
  final String idClient;
  const FormEditServicesExtInfoPage(this.idClient, {Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FormEditServicesExtInfoState();
  }
}

class FormEditServicesExtInfoState extends State<FormEditServicesExtInfoPage> {
  late Future<ExternalServicesSect7> _externalServicesModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ExternalServicesSect7 _modelInfoServicesExt = ExternalServicesSect7();
  late final ApiUpdateEnterprise apiUpdate;

  @override
  void initState() {
    apiUpdate = Provider.of<ApiUpdateEnterprise>(context, listen: false);
    final apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    _externalServicesModel =
        apiRead.fetchExternalServicesSect7(widget.idClient);
    _modelInfoServicesExt.idClient = widget.idClient;
    super.initState();
  }

  Widget _buildConsommationSurPlaceAvailability(ExternalServicesSect7 data) {
    return CheckboxListTileFormField(
      initialValue: data.buyInPlaceEnable!,
      title: const Text('Consommation sur place'),
      onSaved: (bool? value) {
        _modelInfoServicesExt.buyInPlaceEnable = value;
      },
    );
  }

  Widget _buildTakeAwayAvailability(ExternalServicesSect7 data) {
    return CheckboxListTileFormField(
      initialValue: data.takeAwayEnable!,
      title: const Text('Vente à emporté'),
      onSaved: (bool? value) {
        _modelInfoServicesExt.takeAwayEnable = value;
      },
    );
  }

  Widget _buildLivraisonsAvailability(ExternalServicesSect7 data) {
    return CheckboxListTileFormField(
      initialValue: data.deliverEnable!,
      title: const Text('Livraison'),
      onSaved: (bool? value) {
        _modelInfoServicesExt.deliverEnable = value;
      },
    );
  }

  Widget _buildUberEatsLink(ExternalServicesSect7 data) {
    return TextFormField(
      initialValue: data.ubereatsUrlLink,
      decoration: const InputDecoration(
        labelText: "Lien UberEats (URL)",
        border: OutlineInputBorder(),
      ),
      /*validator: (String? value) {
        if (value!.isEmpty) {
          return "   ";
        }
        return null;
      },*/
      onSaved: (String? value) {
        _modelInfoServicesExt.ubereatsUrlLink = value;
      },
    );
  }

  Widget _buildDeliverooLink(ExternalServicesSect7 data) {
    return TextFormField(
      initialValue: data.delivrooUrlLink,
      decoration: const InputDecoration(
        labelText: "Lien Deliveroo (URL)",
        border: OutlineInputBorder(),
      ),
      /*validator: (String? value) {
        if (value!.isEmpty) {
          return "   ";
        }

        return null;
      },*/
      onSaved: (String? value) {
        _modelInfoServicesExt.delivrooUrlLink = value;
      },
    );
  }

  Widget _buildJustEatLink(ExternalServicesSect7 data) {
    return TextFormField(
      initialValue: data.justeatUrlLink,
      decoration: const InputDecoration(
        labelText: "Lien JustEat (URL)",
        border: OutlineInputBorder(),
      ),
      /*validator: (String? value) {
        if (value!.isEmpty) {
          return "   ";
        }
        return null;
      },*/
      onSaved: (String? value) {
        _modelInfoServicesExt.justeatUrlLink = value;
      },
    );
  }

  Widget _buildOwnLivraisonAvailability(ExternalServicesSect7 data) {
    return CheckboxListTileFormField(
      initialValue: data.ownDeliverEnable!,
      title: const Text('Service de livraison interne'),
      onSaved: (bool? value) {
        _modelInfoServicesExt.ownDeliverEnable = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Services rendu"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          TextButton(
              child: const Text('Enregistrer', style: TextStyle(fontSize: 15)),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                final isValid = _formKey.currentState!.validate();
                if (isValid) {
                  _formKey.currentState!.save();
                  apiUpdate.putExternalServicesSect7(_modelInfoServicesExt);
                  Navigator.pop(context);
                }
              }),
        ],
      ),
      body: FutureBuilder<ExternalServicesSect7>(
        future: _externalServicesModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Container(
              margin: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    const Text(
                      "Type de vente",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    _buildConsommationSurPlaceAvailability(data!),
                    _buildTakeAwayAvailability(data),
                    _buildLivraisonsAvailability(data),
                    const SizedBox(height: 20),
                    const Text(
                      "Service de livraison via un tier de confiance",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    _buildUberEatsLink(data),
                    const SizedBox(height: 10),
                    _buildDeliverooLink(data),
                    const SizedBox(height: 10),
                    _buildJustEatLink(data),
                    const SizedBox(height: 20),
                    const Text(
                      "Service de livraison propre",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    _buildOwnLivraisonAvailability(data),
                  ],
                ),
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: const Center(child: const CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
