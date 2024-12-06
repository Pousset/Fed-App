// ignore_for_file: depend_on_referenced_packages

import 'package:fedhubs_pro/models/event/single_event/single_user_event.dart';
import 'package:fedhubs_pro/screens/event_forms/web_pick_event_img.dart';
import 'package:fedhubs_pro/services/api_create.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class FormCreateEventPage extends StatefulWidget {
  final String idClient;
  const FormCreateEventPage(this.idClient, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FormSubmitEventState();
  }
}

class FormSubmitEventState extends State<FormCreateEventPage> {
  final picker = ImagePicker();
  late Uint8List _bytesImageEvent;
  late String urlImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UserEvent _modelEvent = UserEvent();

  @override
  void initState() {
    _modelEvent.idClient = widget.idClient;
    urlImage = 'https://picsum.photos/200';
    super.initState();
  }

  Widget _buildEventName() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nom de l'événement"),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Le nom de l'événement est nécessaire";
        }

        return null;
      },
      onSaved: (String? value) {
        _modelEvent.eventName = value;
      },
    );
  }

  Widget _buildEventDescription() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: const InputDecoration(labelText: "Description"),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "La description est fortement conseillé";
        }

        return null;
      },
      onSaved: (String? value) {
        _modelEvent.description = value;
      },
    );
  }

  Widget _buildDateTimeStart() {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return DateTimeField(
      decoration: const InputDecoration(
          labelText: "Date et Heure de début de l'événement"),
      format: format,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null && mounted) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
      onChanged: (newValue) {
        setState(() {
          _modelEvent.startDateTimeEvent = newValue;
          if (kDebugMode) {
            print(_modelEvent.startDateTimeEvent);
          }
        });
      },
      validator: (DateTime? value) {
        if (value!.isBefore(DateTime.now())) {
          return 'Indiquer une date et une heure postérieur';
        }
        return null;
      },
    );
  }

  Widget _buildDateTimeEnd() {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return DateTimeField(
      decoration: const InputDecoration(
          labelText: "Date et Heure de fin de l'événement"),
      format: format,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null && mounted) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
      onChanged: (newValue) {
        setState(() {
          _modelEvent.endDateTimeEvent = newValue;
          if (kDebugMode) {
            print(_modelEvent.endDateTimeEvent);
          }
        });
      },
      validator: (DateTime? value) {
        if (value!.hour < _modelEvent.startDateTimeEvent!.hour) {
          return 'Indiquer une heure de fin cohérent';
        }
        if (DateFormat.d().format(value) !=
            DateFormat.d().format(_modelEvent.startDateTimeEvent!)) {
          return 'Indiquer une date et une heure dans la même journée';
        }

        return null;
      },
    );
  }

  void _showPickerEvent(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: SizedBox(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset(
                        "assets/flaticon_logo.svg",
                      ),
                    ),
                    title: const Text("Galerie d'icône du web"),
                    onTap: () {
                      _imgFromWebGalleryEvent();
                    }),
                /*ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Galerie Photo'),
                    onTap: () {
                      _imgFromGalleryEvent();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Caméra Photo'),
                  onTap: () {
                    _imgFromCameraEvent();
                    Navigator.of(context).pop();
                  },
                ),*/
              ],
            ),
          );
        });
  }

  Widget _imagePickerEvent() {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Center(
          child: GestureDetector(
            onTap: () {
              _showPickerEvent(context);
            },
            child: Column(
              children: [
                const Text(
                  "Icône marquante de l'évènement",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                const SizedBox(height: 10),
                // ignore: unnecessary_null_comparison
                if (urlImage != null)
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      // UrlImage,
                      urlImage,
                    ),
                  )
                else
                  // ignore: unnecessary_null_comparison
                  _bytesImageEvent != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            _bytesImageEvent,
                            width: screenSize.width,
                            height: screenSize.width / 2,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)),
                          width: screenSize.width,
                          height: screenSize.width / 2,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future _imgFromWebGalleryEvent() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WebViewPictureGrabber("https://www.flaticon.com/fr/"),
        ));

    setState(() {
      _modelEvent.eventImage = urlImage = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Event"),
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
                  ApiCreate().postDataEvent(_modelEvent);
                  Navigator.pop(context);
                }

                /*if(urlImage!=null)
                _modelEvent.bytesImageEvent=widget.bytesImageEventWeb;*/

                /*Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => Result(model: this._modelEvent)));*/
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _imagePickerEvent(),
                const SizedBox(height: 5),
                _buildEventName(),
                _buildEventDescription(),
                const SizedBox(height: 24),
                _buildDateTimeStart(),
                if (_modelEvent.startDateTimeEvent != null) _buildDateTimeEnd(),
                /*RaisedButton(
                     onPressed: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => WebViewPictureGraber("https://www.flaticon.com/fr/")),
                       );
                       },
                ),*/

                /*if(urlIMAGEdest!=null)
                  Text(
                    urlIMAGEdest,
                    //widget.urlSvg,
                  ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

/*  Future _imgFromCameraEvent() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        // _image = File(pickedFile.path);
        urlImage=null;
        _bytesImageEvent = io.File(pickedFile.path).readAsBytesSync();
        _modelEvent.base64Event = base64Encode(_bytesImageEvent);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGalleryEvent() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        // _image = File(pickedFile.path);
        urlImage=null;
        _bytesImageEvent = io.File(pickedFile.path).readAsBytesSync();
        _modelEvent.base64Event = base64Encode(_bytesImageEvent);
        print(_modelEvent.base64Event.substring(0, 100));
      } else {
        print('No image selected.');
      }
    });
  }*/

/*Future<void> networkFlatIconToBase64() async {
      _modelEvent.bytesImageEvent = (await NetworkAssetBundle(Uri.parse(widget.urlSvg)).load(widget.urlSvg)).buffer.asUint8List();
    setState(() {
      _modelEvent.urlImg=widget.urlSvg;
      */ /*print(_modelEvent.urlImg);
      print(_modelEvent.bytesImageEvent);*/ /*
    });
  }*/

/*void initChaptersTitleScrap() async {

    final webScraper = WebScraper('https://www.flaticon.com');
    if (await webScraper.loadWebPage("/fr/icone-gratuite/magasin-dalimentation_2934069?term=restaurant&page=1&position=5&related_item_id=2934069")) {
      final urlElements = webScraper.getElement(
          'div  > div > div > img ',
          ['src']);


      setState(() {
        String urlElement=urlElements[0].toString().substring(28);
        UrlImage=urlElement.substring(0,urlElement.indexOf('}}'));
        //urlIMAGEdest=UrlImage.substring(24);
      });

    }
  }*/
}
