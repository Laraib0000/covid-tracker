import 'package:covid_tracker/Models/Services/stats_services.dart';
import 'package:covid_tracker/Models/world_stats_model.dart';
import 'package:covid_tracker/Screens/SearchCountries.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final colorList = [
  const Color(0xff4285F4),
  const Color(0xff1aa260),
  const Color(0xffde5246),
];

class _HomePageState extends State<HomePage> {
  StatsServices statsServices = StatsServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Covid Stats'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              FutureBuilder(
                future: statsServices.statsServices(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return LoadingAnimationWidget.prograssiveDots(
                      color: Colors.red,
                      size: 100,
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "cases": double.parse(
                              snapshot.data!.cases!.toString(),
                            ),
                            "Death":
                                double.parse(snapshot.data!.deaths.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString())
                          },
                          animationDuration: const Duration(milliseconds: 800),
                          chartLegendSpacing: 50,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          colorList: colorList,
                          chartType: ChartType.ring,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                            legendShape: BoxShape.circle,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                        ),
                        Container(
                          height: 230,
                          // width: 300,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReusableRow(
                                    cases: 'Today Cases',
                                    number: snapshot.data!.todayCases!),
                                ReusableRow(
                                    cases: 'Death',
                                    number: snapshot.data!.deaths!),
                                ReusableRow(
                                    cases: 'Recovered',
                                    number: snapshot.data!.recovered!),
                                ReusableRow(
                                    cases: 'Tests',
                                    number: snapshot.data!.tests!),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Container(
                              height: 50,
                              // width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green),
                              child: Center(
                                child: Text(
                                  'Search Countries',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchCountries()));
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String cases;
  int number;
  ReusableRow({Key? key, required this.cases, required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            cases,
            style: TextStyle(fontSize: 22),
          ),
          Text(number.toString(), style: TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}
