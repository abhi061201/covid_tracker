import 'dart:async';

import 'package:covid_tracker/view/worldStats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with TickerProviderStateMixin {
  @override
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration:
        Duration(seconds: 3), // because splash screen 3 sec k liye appear hogi
  )..repeat();

  
  
  @override
  // dispose function is use to just clear the memory of object
  // here we clear the controller memory
  void dispose() {
    // same as delete function in c++
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorldStats(),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // it gives animation to our child
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image(
                    image: AssetImage(
                      'images/virus.png',
                    ),
                  ),
                ),
                builder: (BuildContext context, Widget? mychild) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: mychild,
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Covid 19 \n Tracking App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
