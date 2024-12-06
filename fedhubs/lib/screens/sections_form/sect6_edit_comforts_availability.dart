import 'dart:convert';

import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:fedhubs_pro/models/section/sect6_comforts_availability.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormEditComfortAvailabilityPage extends StatefulWidget {
  final String idClient;
  const FormEditComfortAvailabilityPage(this.idClient, {Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FormEditComfortAvailabilityInfoState();
  }
}

class FormEditComfortAvailabilityInfoState
    extends State<FormEditComfortAvailabilityPage> {
  late Future<ComfortAvailabilitySect6> _comfortAvailabilityModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ComfortAvailabilitySect6 _modelInfoComfort = ComfortAvailabilitySect6();
  late final ApiUpdateEnterprise apiUpdate;

  @override
  void initState() {
    apiUpdate = Provider.of<ApiUpdateEnterprise>(context, listen: false);
    final apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    _comfortAvailabilityModel =
        apiRead.fetchComfortAvailabilitySect6(widget.idClient);
    _modelInfoComfort.idClient = widget.idClient;
    super.initState();
  }

  Widget _buildToiletAvailability(ComfortAvailabilitySect6 data) {
    return CheckboxListTileFormField(
      initialValue: data.toiletEnable!,
      secondary: const Icon(Icons.wc_sharp),
      title: const Text('Toilette'),
      onSaved: (bool? value) {
        _modelInfoComfort.toiletEnable = value;
      },
    );
  }

  Widget _buildWifiAvailability(ComfortAvailabilitySect6 data) {
    return CheckboxListTileFormField(
      initialValue: data.wifiEnable!,
      secondary: const Icon(Icons.wifi),
      title: const Text('Wifi'),
      onSaved: (bool? value) {
        _modelInfoComfort.wifiEnable = value;
      },
    );
  }

  Widget _buildTVAvailability(ComfortAvailabilitySect6 data) {
    return CheckboxListTileFormField(
      initialValue: data.tvEnable!,
      secondary: const Icon(Icons.tv_outlined),
      title: const Text('TV'),
      onSaved: (bool? value) {
        _modelInfoComfort.tvEnable = value;
      },
    );
  }

  Widget _buildMusicAvailability(ComfortAvailabilitySect6 data) {
    return CheckboxListTileFormField(
      initialValue: data.musicEnable!,
      secondary: const Icon(Icons.library_music),
      title: const Text('Musique'),
      onSaved: (bool? value) {
        _modelInfoComfort.musicEnable = value;
      },
    );
  }

  Widget _buildHandicapAvailability(ComfortAvailabilitySect6 data) {
    return CheckboxListTileFormField(
      initialValue: data.handicapEnable!,
      secondary: const Icon(Icons.accessible_outlined),
      title: const Text('Accessibilité handicapé (toilette comprise)'),
      onSaved: (bool? value) {
        _modelInfoComfort.handicapEnable = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Confort Accès"),
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
                  apiUpdate.putComfortAvailabilitySect6(_modelInfoComfort);
                  if (kDebugMode) {
                    print(json.encode(_modelInfoComfort.toJson()));
                  }
                  Navigator.pop(context);
                }
              }),
        ],
      ),
      body: FutureBuilder<ComfortAvailabilitySect6>(
        future: _comfortAvailabilityModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Container(
              margin: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    _buildToiletAvailability(data!),
                    _buildWifiAvailability(data),
                    _buildTVAvailability(data),
                    _buildMusicAvailability(data),
                    _buildHandicapAvailability(data),
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
