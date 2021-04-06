import 'package:corona_apps/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCardData {
  EndpointCardData(this.title, this.images, this.color);
  final String title;
  final String images;
  final Color color;
}

class EndpointCard extends StatelessWidget {
  const EndpointCard({Key key, this.endpoint, this.value}) : super(key: key);
  final Endpoint endpoint;
  final int value;
  static Map<Endpoint, EndpointCardData> _cardTitiles = {
    Endpoint.cases:
        EndpointCardData('Cases', 'assets/count.png', Color(0xFFFFF492)),
    Endpoint.casesSuspected: EndpointCardData(
        'Suspected Cases', 'assets/suspect.png', Color(0xFFFFDA28)),
    Endpoint.casesConfirmed: EndpointCardData(
        'Confirmed Cases', 'assets/fever.png', Color(0xFFE99600)),
    Endpoint.deaths:
        EndpointCardData('Deaths', 'assets/death.png', Color(0xFFE40000)),
    Endpoint.recovered:
        EndpointCardData('Recovered', 'assets/patient.png', Color(0xFF70A901)),
  };

  @override
  Widget build(BuildContext context) {
    final cardData = _cardTitiles[endpoint];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData.title,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: cardData.color),
              ),
              SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      cardData.images,
                      color: cardData.color,
                    ),
                    Text(
                      value != null ? value.toString() : '',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: cardData.color, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
