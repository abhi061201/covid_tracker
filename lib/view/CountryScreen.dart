import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image, name;
  int death, totalDeaths, totalRecovered, active, critical, test, todayRecovered;

  DetailScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.death,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.test,
    required this.totalDeaths,
    required this.todayRecovered,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        ReusableRow(
                            title: 'Cases', value: widget.death.toString()),
                        ReusableRow(
                            title: 'Recovered',
                            value: widget.totalRecovered.toString()),
                        ReusableRow(
                            title: 'Death', value: widget.totalDeaths.toString()),
                        ReusableRow(
                            title: 'Critical',
                            value: widget.critical.toString()),
                        ReusableRow(
                            title: 'Today Recovered',
                            value: widget.todayRecovered.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ReusableRow extends StatefulWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  State<ReusableRow> createState() => _ReusableRowState();
}

class _ReusableRowState extends State<ReusableRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title.toString()),
              Text(widget.value.toString()),
            ],
            
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(),
        ],
      ),
    );
  }
}
