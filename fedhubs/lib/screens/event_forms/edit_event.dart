// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io' as io;

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:fedhubs_pro/services/events/api_update_user_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:fedhubs_pro/models/event/single_event/single_user_event.dart';
import 'package:fedhubs_pro/screens/event_forms/web_pick_event_img.dart';
import 'package:fedhubs_pro/services/events/api_read_user_events.dart';

// ignore: must_be_immutable
class FormSubmitEventPage extends StatefulWidget {
  final String idClient;
  final String idEvent;
  const FormSubmitEventPage(this.idClient, this.idEvent, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormSubmitEventState();
  }
}

class FormSubmitEventState extends State<FormSubmitEventPage> {
  late Future<UserEvent> _userEventModel;

  final picker = ImagePicker();
  late Uint8List _bytesImageEvent;
  late String urlIMAGEdest;
  late String urlImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserEvent _modelUserEvent = UserEvent();
  dynamic base64Event;

  @override
  void initState() {
    _userEventModel = ApiReadEvent().fetchSingleUserEvent(
        widget.idEvent); //widget.idClient à récupérer en amont
    _modelUserEvent.idClient = widget.idClient;
    _modelUserEvent.idEvent = widget.idEvent;
    _userEventModel.then((value) {
      setState(() {
        _modelUserEvent.eventImage = value.eventImage;
        _modelUserEvent.startDateTimeEvent = value.startDateTimeEvent;
        _modelUserEvent.endDateTimeEvent = value.endDateTimeEvent;
      });
    });
    super.initState();
  }

  Widget _buildEventName(UserEvent data) {
    return TextFormField(
      initialValue: data.eventName,
      decoration: const InputDecoration(labelText: "Nom de l'événement"),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Le nom de l'événement est nécessaire";
        }

        return null;
      },
      onSaved: (String? value) {
        _modelUserEvent.eventName = value;
      },
    );
  }

  Widget _buildEventDescription(UserEvent data) {
    return TextFormField(
      initialValue: data.description,
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
        _modelUserEvent.description = value;
      },
    );
  }

  Widget _buildDateTimeStart(UserEvent data) {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return DateTimeField(
      initialValue: data.startDateTimeEvent,
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
          _modelUserEvent.startDateTimeEvent = newValue;
          if (kDebugMode) {
            print(_modelUserEvent.startDateTimeEvent);
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

  Widget _buildDateTimeEnd(UserEvent data) {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return DateTimeField(
      initialValue: data.endDateTimeEvent,
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
          _modelUserEvent.endDateTimeEvent = newValue;
          if (kDebugMode) {
            print(_modelUserEvent.endDateTimeEvent);
          }
        });
      },
      validator: (DateTime? value) {
        if (value!.hour < data.startDateTimeEvent!.hour) {
          return 'Indiquer une heure de fin cohérent';
        }
        if (_modelUserEvent.startDateTimeEvent != null) {
          if (value.hour < _modelUserEvent.startDateTimeEvent!.hour ||
              value.hour < data.startDateTimeEvent!.hour) {
            return 'Indiquer une heure de fin cohérent';
          }
        }
        if (_modelUserEvent.startDateTimeEvent != null) {
          if (DateFormat.d().format(value) !=
              DateFormat.d().format(_modelUserEvent.startDateTimeEvent!)) {
            return 'Indiquer une date et une heure dans la même journée';
          }
        }

        return null;
      },
    );
  }

  Widget _imagePickerEvent(UserEvent data) {
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
                if (data.eventImage != null && _bytesImageEvent == null)
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      // UrlImage,
                      data.eventImage!,
                    ),
                  )
                else
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
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WebViewPictureGraber("https://www.flaticon.com/fr/")),
                      );*/
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

  // ignore: unused_element
  Future _imgFromCameraEvent() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        // _image = File(pickedFile.path);
        urlImage;
        _bytesImageEvent = io.File(pickedFile.path).readAsBytesSync();
        base64Event = base64Encode(_bytesImageEvent);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  // ignore: unused_element
  Future _imgFromGalleryEvent() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        // _image = File(pickedFile.path);
        urlImage;
        _bytesImageEvent = io.File(pickedFile.path).readAsBytesSync();
        base64Event = base64Encode(_bytesImageEvent);
        if (kDebugMode) {
          print(base64Event.substring(0, 100));
        }
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  Future _imgFromWebGalleryEvent() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WebViewPictureGrabber("https://www.flaticon.com/fr/"),
        ));

    setState(() {
      urlImage = result;
      _modelUserEvent.eventImage = urlImage;
    });
  }

  /*Future<void> networkFlatIconToBase64() async {
      _modelUserEvent.bytesImageEvent = (await NetworkAssetBundle(Uri.parse(widget.urlSvg)).load(widget.urlSvg)).buffer.asUint8List();
    setState(() {
      _modelUserEvent.urlImg=widget.urlSvg;
      */ /*print(_modelUserEvent.urlImg);
      print(_modelUserEvent.bytesImageEvent);*/ /*
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
                  ApiUpdateEvent().putEvent(_modelUserEvent);
                  Navigator.pop(context);
                }
              }),
        ],
      ),
      body: FutureBuilder<UserEvent>(
        future: _userEventModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Container(
              margin: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    _imagePickerEvent(data!),
                    const SizedBox(height: 5),
                    _buildEventName(data),
                    _buildEventDescription(data),
                    const SizedBox(height: 24),
                    _buildDateTimeStart(data),
                    if (_modelUserEvent.startDateTimeEvent != null ||
                        data.endDateTimeEvent != null)
                      _buildDateTimeEnd(data),
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

    /*SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                _imagePickerEvent(),
                SizedBox(height: 5),
                _buildEventName(),
                _buildEventDescription(),
                SizedBox(height: 24),
                _buildDateTimeStart(),
                if(_modelUserEvent.startEventDateTime !=null)
                _buildDateTimeEnd(),

              ],
            ),
          ),
        ),
      ),
    );*/
  }
}
