import 'package:flutter/material.dart';

class TextFormListTile extends StatelessWidget {
  const TextFormListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      isThreeLine: true,
      leading: Icon(
        Icons.calendar_month,
        color: Colors.black,
      ),
      horizontalTitleGap: -10.0,
      title: Text(
        'Date',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
      subtitle: Text(
        'Mercredi 27 juillet',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
