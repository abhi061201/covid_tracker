import 'dart:ui';
import 'package:covid_tracker/view/CountryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/Stats_services.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  @override
  TextEditingController search_controller = TextEditingController();
  StatesServices statesServices = StatesServices();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              controller: search_controller,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: '   Search with country name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: statesServices.fetchCountrienRecord(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Container(
                                  height: 10, width: 80, color: Colors.white),
                              subtitle: Container(
                                  height: 10, width: 80, color: Colors.white),
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'].toString();

                      if (name.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      death: snapshot.data![index]['cases'],
                                      totalRecovered: snapshot.data![index]
                                          ['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                      test: snapshot.data![index]['text'],
                                      totalDeaths: snapshot.data![index]
                                          ['deaths'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  snapshot.data![index]['country'].toString(),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                ),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(
                                    snapshot.data![index]['countryInfo']['flag']
                                        .toString(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (name.toLowerCase().contains(
                            search_controller.text.toLowerCase().toString(),
                          )) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                      name: snapshot.data![index]['country']
                                          .toString(),
                                      death: snapshot.data![index]['cases'],
                                      totalRecovered: snapshot.data![index]
                                          ['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                      test: snapshot.data![index]['tests'],
                                      totalDeaths: snapshot.data![index]
                                          ['deaths'],
                                      todayRecovered: snapshot.data![index]
                                          ['todayRecovered'],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  snapshot.data![index]['country'].toString(),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                ),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(
                                    snapshot.data![index]['countryInfo']['flag']
                                        .toString(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
