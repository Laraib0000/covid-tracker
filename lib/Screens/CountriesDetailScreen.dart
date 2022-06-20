import 'package:flutter/material.dart';

import 'HomePage.dart';

class CountriesDetailScreen extends StatefulWidget {
  String name, image;
  int totalCases,
      totalRecovered,
      totalDeaths,
      active,
      test,
      todayRecovered,
      critical;
  CountriesDetailScreen(
      {Key? key,
      required this.name,
      required this.image,
      required this.totalCases,
      required this.todayRecovered,
      required this.totalDeaths,
      required this.active,
      required this.test,
      required this.totalRecovered,
      required this.critical})
      : super(key: key);

  @override
  State<CountriesDetailScreen> createState() => _CountriesDetailScreenState();
}

class _CountriesDetailScreenState extends State<CountriesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(alignment: Alignment.topCenter, children: [
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Card(
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ReusableRow(
                              cases: 'Total Cases', number: widget.totalCases),
                          ReusableRow(
                              cases: 'Death', number: widget.totalDeaths),
                          ReusableRow(
                              cases: 'Critical', number: widget.critical),
                          ReusableRow(cases: 'Active', number: widget.active),
                          ReusableRow(
                              cases: 'Test', number: widget.totalRecovered),
                          ReusableRow(cases: 'Recovered', number: widget.test),
                        ],
                      ),
                    )),
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.image),
              ),
            ]),
          ),
        ],
      )),
    );
  }
}
