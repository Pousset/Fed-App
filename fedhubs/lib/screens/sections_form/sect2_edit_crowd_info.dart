import 'package:fedhubs_pro/models/section/sect2_crowd_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormEditAfflluenceInfoPage extends StatefulWidget {
  final String idClient;
  const FormEditAfflluenceInfoPage(this.idClient, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FormEditAfflluenceInfoState();
  }
}

class FormEditAfflluenceInfoState extends State<FormEditAfflluenceInfoPage> {
  Future<CrowdInfoSect2>? _crowdInfoSectModel;
  CrowdInfoSect2 modelInfoAffluence = CrowdInfoSect2();
  late final ApiUpdateEnterprise apiUpdate;

  @override
  void initState() {
    apiUpdate = Provider.of<ApiUpdateEnterprise>(context, listen: false);
    final apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    _crowdInfoSectModel = apiRead.fetchCrowdInfoSect2(widget.idClient);
    modelInfoAffluence.idClient = widget.idClient;
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildInfoFeuRouge(CrowdInfoSect2 data) {
    return TextFormField(
      initialValue: data.redCrowdIndicatorInfo,
      decoration: const InputDecoration(
        labelText: "Message au feu rouge",
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Un message est nécessaire';
        }

        return null;
      },
      onSaved: (String? value) {
        modelInfoAffluence.redCrowdIndicatorInfo = value;
      },
    );
  }

  Widget _buildInfoFeuOrange(CrowdInfoSect2 data) {
    return TextFormField(
      initialValue: data.orangeCrowdIndicatorInfo,
      decoration: const InputDecoration(
        labelText: "Message au feu orange",
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Un message est nécessaire';
        }

        return null;
      },
      onSaved: (String? value) {
        modelInfoAffluence.orangeCrowdIndicatorInfo = value;
      },
    );
  }

  Widget _buildInfoFeuVert(CrowdInfoSect2 data) {
    return TextFormField(
      initialValue: data.greenCrowdIndicatorInfo,
      decoration: const InputDecoration(
        labelText: "Message au feu vert",
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Un message est nécessaire';
        }

        return null;
      },
      onSaved: (String? value) {
        modelInfoAffluence.greenCrowdIndicatorInfo = value;
      },
    );
  }

  Widget _buildInfoSup(CrowdInfoSect2 data) {
    return TextFormField(
      initialValue: data.crowdInfoPlus,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        labelText: "Indication supplémentaire à l'affluence",
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          modelInfoAffluence.crowdInfoPlus = null;
        }

        return null;
      },
      onSaved: (String? value) {
        modelInfoAffluence.crowdInfoPlus = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Info Affluence"),
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
                  apiUpdate.putCrowdInfoSect2(modelInfoAffluence);
                  Navigator.pop(context);
                  if (kDebugMode) {
                    print(modelInfoAffluence);
                  }
                }
              }),
        ],
      ),
      body: FutureBuilder<CrowdInfoSect2>(
        future: _crowdInfoSectModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Container(
              margin: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    const Text(
                        "Temps d'attente approximative ou temps de traitement des clients :",
                        style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    _buildInfoFeuRouge(data!),
                    const SizedBox(height: 10),
                    _buildInfoFeuOrange(data),
                    const SizedBox(height: 10),
                    _buildInfoFeuVert(data),
                    const SizedBox(height: 10),
                    _buildInfoSup(data),
                  ],
                ),
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
