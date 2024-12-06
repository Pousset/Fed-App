import 'package:flutter/material.dart';

class SendClientNotificationSwitch extends StatefulWidget {
  SendClientNotificationSwitch({Key? key}) : super(key: key);

  @override
  State<SendClientNotificationSwitch> createState() =>
      _SendClientNotificationSwitchState();
}

class _SendClientNotificationSwitchState
    extends State<SendClientNotificationSwitch> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    return Column(children: [
      Row(
        children: const [
          Text(
            'Envoyer une notfication au client',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(
                Icons.check,
                color: Color.fromRGBO(246, 136, 93, 1),
              ),
              Text(
                'Sms',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.check,
                color: Color.fromRGBO(246, 136, 93, 1),
              ),
              Text(
                'Email',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });
            },
            activeTrackColor: Colors.grey,
            activeColor: Colors.grey,
          ),
        ],
      ),
    ]);
  }
}
