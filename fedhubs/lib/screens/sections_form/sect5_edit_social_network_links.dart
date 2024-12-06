import 'package:fedhubs_pro/models/section/sect5_social_network_links.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormEditSocialNetworksLinkInfoPage extends StatefulWidget {
  final String idClient;
  const FormEditSocialNetworksLinkInfoPage(this.idClient, {Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FormEditSocialNetworksLinkInfoState();
  }
}

class FormEditSocialNetworksLinkInfoState
    extends State<FormEditSocialNetworksLinkInfoPage> {
  late Future<SocialLinksSect5> _socialLinkModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SocialLinksSect5 _modelInfoSocialNetwork = SocialLinksSect5();
  late final ApiUpdateEnterprise apiUpdate;

  @override
  void initState() {
    apiUpdate = Provider.of<ApiUpdateEnterprise>(context, listen: false);
    final apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    _socialLinkModel = apiRead.fetchSocialLinksSect5(widget.idClient);
    _modelInfoSocialNetwork.idClient = widget.idClient;
    super.initState();
  }

  Widget _buildFacebookLink(SocialLinksSect5 data) {
    return TextFormField(
      initialValue: data.facebookUrlLink,
      decoration: const InputDecoration(
        labelText: "Lien Facebook",
        border: OutlineInputBorder(),
      ),
      /*validator: (String? value) {
        if (value!.isEmpty) {
          return "Horaire d'ouverture indispensable, merci de l'indiqué";
        }

        return null;
      },*/
      onSaved: (String? value) {
        _modelInfoSocialNetwork.facebookUrlLink = value;
      },
    );
  }

  Widget _buildInstagramLink(SocialLinksSect5 data) {
    return TextFormField(
      initialValue: data.instagramUrlLink,
      decoration: const InputDecoration(
        labelText: "Lien Instagram",
        border: OutlineInputBorder(),
      ),
      /*validator: (String? value) {
        if (value!.isEmpty) {
          return "Horaire d'ouverture indispensable, merci de l'indiqué";
        }

        return null;
      },*/
      onSaved: (String? value) {
        _modelInfoSocialNetwork.instagramUrlLink = value;
      },
    );
  }

  Widget _buildLinkedInLink(SocialLinksSect5 data) {
    return TextFormField(
      initialValue: data.linkedinUrlLink,
      decoration: const InputDecoration(
        labelText: "Lien Linkedin",
        border: OutlineInputBorder(),
      ),
      /*validator: (String? value) {
        if (value!.isEmpty) {
          return "Horaire d'ouverture indispensable, merci de l'indiqué";
        }

        return null;
      },*/
      onSaved: (String? value) {
        _modelInfoSocialNetwork.linkedinUrlLink = value;
      },
    );
  }

  Widget _buildTwitterLink(SocialLinksSect5 data) {
    return TextFormField(
      initialValue: data.twitterUrlLink,
      decoration: const InputDecoration(
        labelText: "Lien Twitter",
        border: OutlineInputBorder(),
      ),
      /*validator: (String? value) {
        if (value!.isEmpty) {
          return "Horaire d'ouverture indispensable, merci de l'indiqué";
        }

        return null;
      },*/
      onSaved: (String? value) {
        _modelInfoSocialNetwork.twitterUrlLink = value;
      },
    );
  }

  Widget _buildYoutubeLink(SocialLinksSect5 data) {
    return TextFormField(
      initialValue: data.youtubeUrlLink,
      decoration: const InputDecoration(
        labelText: "Lien Youtube",
        border: OutlineInputBorder(),
      ),
      /*validator: (String? value) {
        if (value!.isEmpty) {
          return "Horaire indispensable, merci de l'indiqué";
        }

        return null;
      },*/
      onSaved: (String? value) {
        _modelInfoSocialNetwork.youtubeUrlLink = value;
      },
    );
  }

  Widget _buildPinterestLink(SocialLinksSect5 data) {
    return TextFormField(
      initialValue: data.pinterestUrlLink,
      decoration: const InputDecoration(
        labelText: "Lien Pinterest",
        border: OutlineInputBorder(),
      ),
      /*validator: (String? value) {
        if (value!.isEmpty) {
          return "Horaire d'ouverture indispensable, merci de l'indiqué";
        }

        return null;
      },*/
      onSaved: (String? value) {
        _modelInfoSocialNetwork.pinterestUrlLink = value;
      },
    );
  }

  Widget _buildSnapchatLink(SocialLinksSect5 data) {
    return TextFormField(
      initialValue: data.snapchatUrlLink,
      decoration: const InputDecoration(
        labelText: "Lien Snapchat",
        border: OutlineInputBorder(),
      ),
      /*validator: (String? value) {
        if (value!.isEmpty) {
          return "Horaire d'ouverture indispensable, merci de l'indiqué";
        }

        return null;
      },*/
      onSaved: (String? value) {
        _modelInfoSocialNetwork.snapchatUrlLink = value;
      },
    );
  }

  Widget _buildTikTokLink(SocialLinksSect5 data) {
    return TextFormField(
      initialValue: data.tiktokUrlLink,
      decoration: const InputDecoration(
        labelText: "Lien Tiktok",
        border: OutlineInputBorder(),
      ),
      /*validator: (String? value) {
        if (value!.isEmpty) {
          return "Horraire d'ouverture indispensable, merci de l'indiqué";
        }

        return null;
      },*/
      onSaved: (String? value) {
        _modelInfoSocialNetwork.tiktokUrlLink = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Réseaux sociaux"),
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
                  apiUpdate.putSocialLinksSect5(_modelInfoSocialNetwork);
                  //print(json.encode(_modelInfoSocialNetwork.toJson()));
                  Navigator.pop(context);
                }
              }),
        ],
      ),
      body: FutureBuilder<SocialLinksSect5>(
        future: _socialLinkModel,
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
                    _buildFacebookLink(data!),
                    const SizedBox(height: 10),
                    _buildInstagramLink(data),
                    const SizedBox(height: 10),
                    _buildLinkedInLink(data),
                    const SizedBox(height: 10),
                    _buildTwitterLink(data),
                    const SizedBox(height: 10),
                    _buildYoutubeLink(data),
                    const SizedBox(height: 10),
                    _buildPinterestLink(data),
                    const SizedBox(height: 10),
                    _buildSnapchatLink(data),
                    const SizedBox(height: 10),
                    _buildTikTokLink(data),
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
