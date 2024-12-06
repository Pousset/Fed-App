// ignore_for_file: depend_on_referenced_packages

import 'package:fedhubs_pro/models/event/single_event/single_suggest_event.dart';
import 'package:fedhubs_pro/screens/event_displays/event_list.dart';
import 'package:fedhubs_pro/screens/event_forms/web_pick_event_img.dart';
import 'package:fedhubs_pro/services/api_create.dart';
import 'package:fedhubs_pro/services/events/api_read_suggest_events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class FormSubmitSuggestEventPage extends StatefulWidget {
  final String idClient;
  final String idEventSuggest;
  const FormSubmitSuggestEventPage(this.idEventSuggest, this.idClient,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormSubmitSuggestEventState();
  }
}

class FormSubmitSuggestEventState extends State<FormSubmitSuggestEventPage> {
  late Future<SuggestEvent>? suggestEventModel;

  //String urlIMAGEdest;
  //String _base64Event;
  final picker = ImagePicker();
  Uint8List? _bytesImageEvent;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SuggestEvent _modelSuggestEvent = SuggestEvent();

  @override
  void initState() {
    suggestEventModel =
        ApiReadSuggestEvent().fetchSingleSuggestEvent(widget.idEventSuggest);
    suggestEventModel!.then((value) {
      setState(() {
        _modelSuggestEvent.idEventSuggest = widget.idClient;
        _modelSuggestEvent.eventName = value.eventName;
        _modelSuggestEvent.eventType = value.eventType;
        _modelSuggestEvent.eventImage = value.eventImage;
        _modelSuggestEvent.startDateTimeEvent = value.startDateTimeEvent;
        _modelSuggestEvent.endDateTimeEvent = value.endDateTimeEvent;
      });
    });
    super.initState();
  }

  Widget _buildEventName(SuggestEvent data) {
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
        _modelSuggestEvent.eventName = value;
      },
    );
  }

  Widget _buildEventDescription(SuggestEvent data) {
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
        _modelSuggestEvent.description = value;
      },
    );
  }

  Widget _buildDateTimeStart(SuggestEvent data) {
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
          _modelSuggestEvent.startDateTimeEvent = newValue;
          if (kDebugMode) {
            print(_modelSuggestEvent.startDateTimeEvent);
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

  Widget _buildDateTimeEnd(SuggestEvent data) {
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
          _modelSuggestEvent.endDateTimeEvent = newValue;
          if (kDebugMode) {
            print(_modelSuggestEvent.endDateTimeEvent);
          }
        });
      },
      validator: (DateTime? value) {
        if (value!.hour < data.startDateTimeEvent!.hour) {
          return 'Indiquer une heure de fin cohérent';
        }
        if (_modelSuggestEvent.startDateTimeEvent != null) {
          if (value.hour < _modelSuggestEvent.startDateTimeEvent!.hour ||
              value.hour < data.startDateTimeEvent!.hour) {
            return 'Indiquer une heure de fin cohérent';
          }
        }
        if (_modelSuggestEvent.startDateTimeEvent != null) {
          if (DateFormat.d().format(value) !=
              DateFormat.d().format(_modelSuggestEvent.startDateTimeEvent!)) {
            return 'Indiquer une date et une heure dans la même journée';
          }
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

  Widget _imagePickerEvent(SuggestEvent data) {
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
                  // ignore: unnecessary_null_comparison
                  _bytesImageEvent != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            _bytesImageEvent!,
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
      _modelSuggestEvent.eventImage = result;
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
                  ApiCreate().postDataSuggestEvent(_modelSuggestEvent);
                  //print(json.encode(_modelSuggestEvent.toJson()));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EventListPage()));
                }
              }),
        ],
      ),
      body: FutureBuilder<SuggestEvent>(
        future: suggestEventModel,
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
                    if (_modelSuggestEvent.startDateTimeEvent != null ||
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
  }
}
