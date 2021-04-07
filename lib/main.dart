import 'package:corona_apps/app/services/api.dart';
import 'package:corona_apps/app/services/api_service.dart';
import 'package:corona_apps/app/services/data_catch_services.dart';
import 'package:corona_apps/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/repositories/data_repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'en_ID';
  await initializeDateFormatting();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, @required this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
          dataCacheService:
              DataCacheService(sharedPreferences: sharedPreferences),
          apiService: APIService(API.sandbox())),
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
