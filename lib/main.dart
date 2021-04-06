import 'package:corona_apps/app/services/api.dart';
import 'package:corona_apps/app/services/api_service.dart';
import 'package:corona_apps/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/repositories/data_repositories.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(apiService: APIService(API.sandbox())),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Color(0xFF101010),
              cardColor: Color(0xFF222222)),
          home: Dashboard()),
    );
  }
}
