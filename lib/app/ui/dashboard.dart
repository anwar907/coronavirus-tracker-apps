import 'dart:io';

import 'package:corona_apps/app/repositories/data_repositories.dart';
import 'package:corona_apps/app/repositories/endpoints_data.dart';
import 'package:corona_apps/app/services/api.dart';
import 'package:corona_apps/app/ui/card.dart';
import 'package:corona_apps/app/ui/show_alert.dart';
import 'package:corona_apps/app/ui/status_update.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEndpointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointData = await dataRepository.getAllEndpointsData();
      setState(() => _endpointsData = endpointData);
    } on SocketException catch (_) {
      showAlertDialog(
          context: context,
          title: 'Network Error',
          content: 'Could not received data, Please Try Again',
          defaultActionText: 'OK');
    } catch (_) {
      showAlertDialog(
          context: context,
          title: 'Unknow Error',
          content: 'Please conntact support and Try Again',
          defaultActionText: 'OK');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdateDateTime(
      lastUpdate: _endpointsData != null
          ? _endpointsData.values[Endpoint.cases]?.date
          : null,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            LastUpdate(text: formatter.lastUpdateStatus()),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint]?.value
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
