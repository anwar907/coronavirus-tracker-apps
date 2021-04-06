import 'package:corona_apps/app/repositories/data_repositories.dart';
import 'package:corona_apps/app/repositories/endpoints_data.dart';
import 'package:corona_apps/app/services/api.dart';
import 'package:corona_apps/app/ui/card.dart';
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
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointData = await dataRepository.getAllEndpointsData();
    setState(() => _endpointsData = endpointData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint]
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}