import 'package:covidapp/Model/WorldStatesModel.dart';
import 'package:covidapp/Services/states_services.dart';
import 'package:covidapp/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  final colorList = <Color>[Colors.blue, Colors.red, Colors.green];
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              FutureBuilder(
                future: stateServices.fetchWorldStates(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          colorList: colorList,
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString())
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                rowText(
                                    title: "Total",
                                    value: snapshot.data!.cases.toString()),
                                rowText(
                                    title: "Deaths",
                                    value: snapshot.data!.deaths.toString()),
                                rowText(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                rowText(
                                    title: "Active",
                                    value: snapshot.data!.active.toString()),
                                rowText(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString()),
                                rowText(
                                    title: "Today Deaths",
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                                rowText(
                                    title: "Today Recovered",
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ActionChip(
                            label: const Text("Track Countries"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CountriesListScreen(),
                                ),
                              );
                            },
                            padding: const EdgeInsets.all(12),
                            backgroundColor: Colors.green),
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

  Widget rowText({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
