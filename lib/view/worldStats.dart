import 'package:covid_tracker/Models/WorldStatsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'splash_screen.dart';
import 'AllCountriesList.dart';
import '../services/Stats_services.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

final _colorList=[
  Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246),

];
class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  @override
  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 3,
      ))
    ..repeat();

  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecord(),
                  builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            colorList: _colorList,
                            chartType: ChartType.ring,
                            chartRadius: MediaQuery.of(context).size.width/2.5,
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            dataMap: {
                              'Total':
                                  double.parse(snapshot.data!.cases.toString()),
                              'Recovered': double.parse(
                                  snapshot.data!.recovered.toString()),
                              'Death': double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.03),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: 'Total Cases',
                                      value: snapshot.data!.cases.toString()),
                                  ReusableRow(
                                      title: 'Death',
                                      value: snapshot.data!.deaths.toString()),
                                  ReusableRow(
                                      title: 'Recovered Cases',
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ReusableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString()),
                                  ReusableRow(
                                      title: 'Critical',
                                      value: snapshot.data!.critical.toString()),
                                  ReusableRow(
                                      title: 'Today Death',
                                      value:
                                          snapshot.data!.todayDeaths.toString()),
                                  ReusableRow(
                                      title: 'Today Recovered',
                                      value: snapshot.data!.todayRecovered.toString()),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 35,),
                          GestureDetector(
                            onTap:() {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>CountriesList()));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.07,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                              ),
                              child: const Center(
                                  child: Text(
                                'Track Countries',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 15,
        
        // bottom: 10,
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
          const SizedBox(
            height: 5,),
          Divider(
            
          ),
        ],
      ),
    );
  }
}
