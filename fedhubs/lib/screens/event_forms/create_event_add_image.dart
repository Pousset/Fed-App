import 'dart:math';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:fedhubs_pro/models/event/single_event/single_user_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../widgets/buttons/custom_flat_button.dart';

class CreateEventAddImage extends StatefulWidget {
  const CreateEventAddImage({Key? key}) : super(key: key);

  @override
  State<CreateEventAddImage> createState() => _CreateEventAddImageState();
}

class _CreateEventAddImageState extends State<CreateEventAddImage> {
  final UserEvent _modelEvent = UserEvent();

  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: max(screenSize.height, 668),
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, screenSize.height * 0.09, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Stack(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Theme.of(context).primaryColorDark,
                            size: 40,
                          ),
                          const Positioned(
                            left: 14,
                            bottom: 10,
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      // onTap: isLoading ? null : () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                _buildInfoEntreprise(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Création d'évenement",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: const [
                      Text("Selectionner une photo dans la galerie"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.event_available,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  hintText: "Titre de l'évenement",
                                  hintStyle:
                                      Theme.of(context).textTheme.labelMedium),
                              keyboardType: TextInputType.multiline,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(Icons.apps),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  hintText: 'Icône',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                  )),
                              keyboardType: TextInputType.multiline,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.send_outlined,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText:
                                "Information complémentaire lié à l'événement, dress code, offre spéciale . .",
                            hintStyle: TextStyle(
                              fontSize: 14,
                            )),
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(child: _buildDateTimeStart()),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: _buildDateTimeEnd(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(Icons.history_outlined),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  hintText: "De",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                  )),
                              keyboardType: TextInputType.multiline,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: "À",
                            hintStyle: TextStyle(
                              fontSize: 14,
                            )),
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                CustomFlatButton(
                    width: screenSize.width - 48,
                    text: "Suivant",
                    color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoEntreprise() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('Vegan-Burger',
              style: TextStyle(
              fontWeight: FontWeight.bold, // Met en gras
              fontSize: 24, // Taille personnalisée (modifier la valeur si nécessaire)
            ),),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Vegan-Burger',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Met en gras
            fontSize: 24, // Taille personnalisée (modifier la valeur si nécessaire)
          ),),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildDateTimeStart() {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return DateTimeField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: "Début"),
      format: format,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null && mounted) {
          // final time = await showTimePicker(
          //   context: context,
          //   initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          // );
          // return DateTimeField.combine(date, time);
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
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: "Fin"),
      format: format,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null && mounted) {
          // final time = await showTimePicker(
          //   context: context,
          //   initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          // );
          // return DateTimeField.combine(date, time);
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
}
