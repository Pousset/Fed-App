import 'package:fedhubs_pro/models/section/sect4_general_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormEditEssentialInfoPage extends StatefulWidget {
  final String idClient;
  const FormEditEssentialInfoPage(this.idClient, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FormEditEssentialInfoState();
  }
}

class FormEditEssentialInfoState extends State<FormEditEssentialInfoPage> {
  late Future<GeneralInfoSect4> _generalInfoModel;
  late final ApiUpdateEnterprise apiUpdate;

  @override
  void initState() {
    apiUpdate = Provider.of<ApiUpdateEnterprise>(context, listen: false);
    final apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    _generalInfoModel = apiRead.fetchGeneralInfoSect4(widget.idClient);
    _modelInfo.idClient = widget.idClient;
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GeneralInfoSect4 _modelInfo = GeneralInfoSect4();

  Widget _buildPhoneNumber(GeneralInfoSect4 data) {
    return TextFormField(
      initialValue: data.phoneNumber,
      decoration: const InputDecoration(
        labelText: "Numéro de téléphone",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Votre numéro de téléphone est nécessaire';
        }
        if (!RegExp(r"^(0|\+33)[1-9]([-. ]?[0-9]{2}){4}$").hasMatch(value)) {
          return 'Veuillez entrer une nuémro de téléphone valide français';
        }

        return null;
      },
      onSaved: (String? value) {
        _modelInfo.phoneNumber = value;
      },
    );
  }

  Widget _buildEmail(GeneralInfoSect4 data) {
    return TextFormField(
      initialValue: data.email,
      decoration: const InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "L'adresse email est nécessaire";
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Veuillez entrer une addresse valide ';
        }

        return null;
      },
      onSaved: (String? value) {
        // ignore: unnecessary_statements
        _modelInfo.email = value;
      },
    );
  }

  Widget _buildWebsiteLink(GeneralInfoSect4 data) {
    return TextFormField(
      initialValue: data.websiteLink,
      decoration: const InputDecoration(
        labelText: "Lien du site Web",
        border: OutlineInputBorder(),
      ),
      /*validator: (String? value) {
        if (!RegExp(
            r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)")
            .hasMatch(value)) {
          return 'Veuillez entrer une addresse valide ';
        }

        return null;
      },*/
      onSaved: (String? value) {
        _modelInfo.websiteLink = value;
      },
    );
  }

  Widget _buildStreetAddress(GeneralInfoSect4 data) {
    return TextFormField(
      initialValue: data.address,
      decoration: const InputDecoration(
        labelText: "Adresse physique",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.streetAddress,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "L'adresse ext nécessaire";
        }

        return null;
      },
      onSaved: (String? value) {
        // ignore: unnecessary_statements
        _modelInfo.address = value;
      },
    );
  }

/*  Widget _builUrlReservation() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Url'),
      keyboardType: TextInputType.url,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'URL de la réservation';
        }

        return null;
      },
      onSaved: (String? value) {
        // ignore: unnecessary_statements
        _modelInfo.reservationUrl=value;
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Info Essentiel"),
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
                  apiUpdate.putGeneralInfoSect4(_modelInfo);
                  Navigator.pop(context);
                }
              }),
        ],
      ),
      body: FutureBuilder<GeneralInfoSect4>(
        future: _generalInfoModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Container(
              margin: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    _buildPhoneNumber(data!),
                    const SizedBox(height: 10),
                    _buildEmail(data),
                    const SizedBox(height: 10),
                    _buildWebsiteLink(data),
                    const SizedBox(height: 10),
                    _buildStreetAddress(data),
                    //_builUrlReservation(data),
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
