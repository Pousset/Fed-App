
import 'package:fedhubs_pro/models/section/sect9bis_single_catalog.dart';
import 'package:fedhubs_pro/services/api_create.dart';
import 'package:flutter/material.dart';

class FormCreateCatalogPage extends StatefulWidget {
  final String idClient;
  const FormCreateCatalogPage(this.idClient, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormCreateCatalogState();
  }
}

class FormCreateCatalogState extends State<FormCreateCatalogPage> {
  final SingleCatalog _modelCatalog = SingleCatalog();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

/*  void postCatalog() async {
    _modelCatalog.catalogName=_titleController.text;
    _modelCatalog.catalogLink=_linkController.text;
  }*/

  @override
  void initState() {
    _modelCatalog.idClient = widget.idClient;
    super.initState();
  }

  Widget _buildCatalogName() {
    return TextFormField(
      controller: _titleController,
      decoration: const InputDecoration(
        labelText: 'Lien du titre ',
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Un titre est nécessaire';
        }
        return null;
      },
      onSaved: (String? value) {
        _modelCatalog.catalogName = value;
      },
    );
  }

  Widget _buildCatalogLink() {
    return TextFormField(
      controller: _linkController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: 'Lien du catalogue',
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Un lien est nécessaire';
        }
        return null;
      },
      onSaved: (String? value) {
        _modelCatalog.catalogLink = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crée un catalogue "),
        backgroundColor: Colors.black,
        actions: <Widget>[
          TextButton(
              child: const Text('Enregistrer', style: TextStyle(fontSize: 15)),
              onPressed: () async {
                final isValid = _formKey.currentState!.validate();
                if (isValid) {
                  _formKey.currentState!.save();
                  ApiCreate().postDataCatalog(_modelCatalog);
                  //_errorMessage(); // arrivé  à l'affiché !
                  Navigator.pop(context);
                }
              }),
        ],
      ),
      body: _createSimpleCatalog(),
    );
  }

  Widget _createSimpleCatalog() {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            const Text("Catalogue accessible sous forme d'un bouton :",
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            _buildCatalogName(),
            const SizedBox(height: 10),
            _buildCatalogLink(),
          ],
        ),
      ),
    );
  }

  // Widget _errorMessage() {
  //   return Dialog(
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20.0)), //this right here
  //     child: FutureBuilder<ErrorHandlingCreation>(
  //       future: _postData,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           var data = snapshot.data;
  //           return SizedBox(
  //             height: min(200.0, MediaQuery.of(context).size.height),
  //             width: min(30.0, MediaQuery.of(context).size.width),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Center(
  //                   child: Column(children: [
  //                     SizedBox(
  //                       height: 100,
  //                       width: 100,
  //                       child: Image.asset(
  //                         "assets/logo_black.png",
  //                       ),
  //                     ),
  //                     const SizedBox(height: 5),
  //                     Text(data!.message.toString()),
  //                   ]),
  //                 ),
  //               ],
  //             ),
  //           );
  //         } else {
  //           return const Padding(
  //             padding: EdgeInsets.all(20),
  //             child: Center(child: CircularProgressIndicator()),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }
}
