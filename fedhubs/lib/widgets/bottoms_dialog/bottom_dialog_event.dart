import 'package:fedhubs_pro/widgets/bottoms_dialog/icon_text_widget.dart';
import 'package:flutter/material.dart';

class BottomDialogEventActions extends StatefulWidget {
  const BottomDialogEventActions({Key? key}) : super(key: key);

  @override
  State<BottomDialogEventActions> createState() =>
      _BottomDialogEventActionsState();
}

class _BottomDialogEventActionsState extends State<BottomDialogEventActions> {
  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;

    return GestureDetector(
      child: const Icon(Icons.add),
      onTap: () {
        showModalBottomSheet<dynamic>(
          isDismissible: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          context: context,
          builder: (context) {
            return Wrap(children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    width: realScreenSize.width,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(42, 45, 54, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 4,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const Text(
                            "Actions",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: const [
                        IconTextDialog(
                          icon: Icon(
                            Icons.event_available,
                            color: Color.fromRGBO(247, 136, 93, 100),
                          ),
                          text: "Créer un événement",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]);
          },
        );
      },
    );
  }
}
