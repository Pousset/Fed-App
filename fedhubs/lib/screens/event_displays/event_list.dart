// ignore_for_file: depend_on_referenced_packages

import 'dart:math';
import 'package:fedhubs_pro/models/event/event_display_on_card.dart';
import 'package:fedhubs_pro/models/event/event_list/event_list.dart';
import 'package:fedhubs_pro/models/event/event_list/event_suggest_list.dart';
import 'package:fedhubs_pro/models/event/single_event/delete_user_event.dart';
import 'package:fedhubs_pro/screens/event_forms/add_suggest_to_user_event.dart';
import 'package:fedhubs_pro/screens/event_forms/create_event.dart';
import 'package:fedhubs_pro/services/events/api_foward_display_event.dart';
import 'package:fedhubs_pro/services/events/api_read_suggest_events.dart';
import 'package:fedhubs_pro/services/events/api_read_user_events.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../event_forms/edit_event.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({Key? key}) : super(key: key);
  @override
  EventListState createState() => EventListState();
}

class EventListState extends State<EventListPage> {
  late String? idClient;

  late Future<EventListModel?> _laterEventListModel;
  //Future<EventListModel> _archiveEventListModel;

  late Future<SuggestEventListModel>? _suggestEventListModel;
  //Future<SuggestEventListModel> _archiveSuggestEventListModel;

  final DeleteUserEvent _modelEventForDelete = DeleteUserEvent();
  final EventDisplayOnCard _modelCardDisplayed = EventDisplayOnCard();

  @override
  void initState() {
    idClient = Provider.of<CompanyProvider>(context, listen: false).idClient;

    _laterEventListModel = ApiReadEvent().getLaterEventList(idClient!);
    //_archiveEventListModel = ApiReadEvent().getArchiveEventList(idClient!);

    _modelEventForDelete.idClient = idClient!;
    _modelCardDisplayed.idClient = idClient!;

    _suggestEventListModel = ApiReadSuggestEvent().getCasualEventSuggestList();

    super.initState();
  }

  int currentTapIndex = 0;
  String appBarTitle = 'Evénement en cours';

  onTapped(int index) {
    setState(() {
      currentTapIndex = index;
      if (currentTapIndex == 1) {
        appBarTitle = "Suggestions";
      } else {
        appBarTitle = "Evénement en cours";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                tooltip: 'Rafraichir',
                onPressed: () {
                  setState(() {
                    _laterEventListModel =
                        ApiReadEvent().getLaterEventList(idClient!);
                    //_archiveEventListModel = ApiReadEvent().getArchiveEventList(idClient!);
                  });
                },
              ),
              /* IconButton(
                icon: Icon(Icons.archive),
                tooltip: 'Archives',
                onPressed: () {},
              ),
              Text('Archives'),
              SizedBox(width: 10),*/
            ],
          )
        ],
        backgroundColor: Colors.black,
      ),
      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTapIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available_outlined),
            label: 'Evénement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outlined),
            label: 'Suggestion',
          ),
        ],
      ),

      body: GestureDetector(child: _buildControllerView()),
    );
  }

  Widget _buildControllerView() {
    if (currentTapIndex == 0) {
      return _listLaterEvents(_laterEventListModel);
    } else {
      return _listLaterSuggestEvents(_suggestEventListModel);
    }
  }

  Widget _listLaterEvents(Future<EventListModel?> laterEvents) {
    // ignore: unnecessary_null_comparison
    if (laterEvents == null) {
      return Center(
        child: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  width: MediaQuery.of(context).size.width),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FormCreateEventPage(idClient!))).then((_) {
                    setState(() {
                      _laterEventListModel =
                          ApiReadEvent().getLaterEventList(idClient!);
                    });
                  });
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),

                      //side: BorderSide(color: Colors.grey)
                    )),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 18)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFFFFFFF))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // ignore: unnecessary_const
                    const Icon(
                      Icons.event_available_outlined,
                      color: Colors.black,
                      size: 24.0,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Ajouter un événement",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width),
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FormCreateEventPage(idClient!))).then((_) {
                      setState(() {
                        _laterEventListModel =
                            ApiReadEvent().getLaterEventList(idClient!);
                      });
                    });
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),

                        //side: BorderSide(color: Colors.grey)
                      )),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10)),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 18)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFFFFFFF))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.event_available_outlined,
                        color: Colors.black,
                        size: 24.0,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Ajouter un événement",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: FutureBuilder<EventListModel?>(
            future: laterEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.event.length,
                  itemBuilder: (BuildContext context, int index) {
                    dynamic displayEvent = snapshot.data?.event[index];
                    var startTime = displayEvent.startDateTimeEvent.toString();
                    var endTime = displayEvent.endDateTimeEvent.toString();
                    String dateOfEvent =
                        '${DateFormat.d().format(displayEvent.startDateTimeEvent)}/${DateFormat.yM().format(displayEvent!.startDateTimeEvent)}';
                    String startTimeOfEvent =
                        DateFormat.Hm().format(DateTime.parse(startTime));
                    String endTimeOfEvent =
                        DateFormat.Hm().format(DateTime.parse(endTime));
                    var dateGape = DateTime.parse(endTime)
                        .difference(DateTime.parse(startTime))
                        .inDays;
                    var hoursGape = DateTime.parse(endTime)
                        .difference(DateTime.parse(startTime))
                        .inHours;
                    String eventTiming =
                        'De $startTimeOfEvent à $endTimeOfEvent';

                    return GestureDetector(
                        child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Text('Date : $dateOfEvent',
                                      textAlign: TextAlign.center,
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .apply(fontSizeFactor: 1.3)),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.grey,
                                    onPressed: () async {
                                      setState(() {
                                        _modelEventForDelete.idEvent =
                                            displayEvent.idEvent;
                                        _dialogDeleteConfirm();

                                        /*_deleteData = ApiDelete().deleteDataEvent(this._modelEventForDelete);
                                                //print(json.encode(_modelEventForDelete.toJson()));
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext context) => super.widget));*/
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                if (displayEvent.eventImage != null)
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      child: Image.network(
                                          displayEvent.eventImage,
                                          width: 70,
                                          height: 70),
                                    ),
                                  ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(displayEvent.eventName,
                                            style: DefaultTextStyle.of(context)
                                                .style
                                                .apply(
                                                    fontSizeFactor: 1.2,
                                                    fontWeightDelta: 3)),
                                        const SizedBox(height: 5),
                                        if (dateGape <= 1 && hoursGape <= 24)
                                          Text(eventTiming),
                                        const SizedBox(height: 5),
                                        Text(displayEvent.description,
                                            overflow: TextOverflow.fade,
                                            style: const TextStyle(
                                                fontStyle: FontStyle.italic),
                                            textAlign: TextAlign.justify),
                                      ]),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: !displayEvent.displayOnCard
                                        ? () async {
                                            setState(() {
                                              _modelCardDisplayed.idEvent =
                                                  displayEvent.idEvent;
                                              _modelCardDisplayed
                                                      .startDateTimeEvent =
                                                  displayEvent
                                                      .startDateTimeEvent;
                                              ApiUpdateFowardEvent().putEvent(
                                                  _modelCardDisplayed);
                                            });
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        super.widget));
                                          }
                                        : null,

                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),

                                        //side: BorderSide(color: Colors.grey)
                                      )),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(10)),
                                      textStyle: MaterialStateProperty.all(
                                          const TextStyle(fontSize: 18)),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return const Color(0xFFF6885D);
                                          } else if (states.contains(
                                              MaterialState.disabled)) {
                                            return const Color(0xFAFFDADA);
                                          }
                                          return const Color(
                                              0xFFF6885D); // Use the component's default.
                                        },
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Mettre en avant',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    //MaterialStateProperty.all<Color>(const Color(0xFFF6885D))),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FormSubmitEventPage(idClient!,
                                                      displayEvent.idEvent)));
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),

                                          //side: BorderSide(color: Colors.grey)
                                        )),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(10)),
                                        textStyle: MaterialStateProperty.all(
                                            const TextStyle(fontSize: 18)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xFDD9D9D9))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Mettre à jour',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                return const Padding(
                    padding: EdgeInsets.all(20), child: SizedBox(height: 0));
              }
            },
          )),
        ],
      );
    }
  }

  Widget _listLaterSuggestEvents(
      Future<SuggestEventListModel>? laterEventSuggest) {
    // ignore: unnecessary_null_comparison
    if (laterEventSuggest == null) {
      return const SizedBox(height: 0);
    } else {
      return FutureBuilder<SuggestEventListModel>(
        future: laterEventSuggest,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.eventSuggest!.length,
              itemBuilder: (BuildContext context, int index) {
                dynamic displayEventSuggest =
                    snapshot.data?.eventSuggest![index];

                var startTime =
                    displayEventSuggest.startDateTimeEvent.toString();
                var endTime = displayEventSuggest.endDateTimeEvent.toString();
                String dateOfEvent =
                    '${DateFormat.d().format(displayEventSuggest.startDateTimeEvent)}/${DateFormat.yM().format(displayEventSuggest.startDateTimeEvent)}';
                String startTimeOfEvent =
                    DateFormat.Hm().format(DateTime.parse(startTime));
                String endTimeOfEvent =
                    DateFormat.Hm().format(DateTime.parse(endTime));
                var dateGape = DateTime.parse(endTime)
                    .difference(DateTime.parse(startTime))
                    .inDays;
                var hoursGape = DateTime.parse(endTime)
                    .difference(DateTime.parse(startTime))
                    .inHours;
                String eventTiming = 'De $startTimeOfEvent à $endTimeOfEvent';

                return GestureDetector(
                    child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 9,
                              child: Text('Date : $dateOfEvent',
                                  textAlign: TextAlign.center,
                                  style: DefaultTextStyle.of(context)
                                      .style
                                      .apply(fontSizeFactor: 1.3)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            if (displayEventSuggest.eventImage != null)
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  child: Image.network(
                                      displayEventSuggest.eventImage,
                                      width: 70,
                                      height: 70),
                                ),
                              ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 6,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(displayEventSuggest.eventName,
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .apply(
                                                fontSizeFactor: 1.2,
                                                fontWeightDelta: 3)),
                                    const SizedBox(height: 5),
                                    if (dateGape <= 1 && hoursGape <= 12)
                                      Text(eventTiming),
                                    const SizedBox(height: 5),
                                    Text(displayEventSuggest.description,
                                        overflow: TextOverflow.fade,
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic),
                                        textAlign: TextAlign.justify),
                                  ]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Retourner un update dans la page événements
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FormSubmitSuggestEventPage(
                                                  displayEventSuggest
                                                      .idEventSuggest,
                                                  idClient!)));
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),

                                      //side: BorderSide(color: Colors.grey)
                                    )),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(10)),
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(fontSize: 18)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xFFF6885D))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Ajouter l'événement",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
              },
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      );
    }
  }

  Future _dialogDeleteConfirm() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: min(150.0, MediaQuery.of(context).size.height),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                          "Voulez vous supprimez de la liste des événements ?",
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFFF6885D))),
                              child: const Text(
                                "Oui",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFFD9D9D9))),
                              child: const Text(
                                "Non",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
          );
        });
  }
}
