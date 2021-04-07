import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdateDateTime {
  LastUpdateDateTime({@required this.lastUpdate});
  final DateTime lastUpdate;

  String lastUpdateStatus() {
    if (lastUpdate != null) {
      final formatter = DateFormat.yMd().add_Hms();
      final formatted = formatter.format(lastUpdate);
      return 'Last updated: $formatted';
    }
    return '';
  }
}

class LastUpdate extends StatelessWidget {
  LastUpdate({Key key, @required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
