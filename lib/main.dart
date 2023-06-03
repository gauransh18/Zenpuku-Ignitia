// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:zenpuku/home.dart';
import 'home.dart';
import 'books_gita.dart';
import 'bookView.dart';
import 'routes.dart';
import 'breathing.dart';
import 'matching.dart';
import 'heatmap.dart';
import 'graphics.dart';


Map<int, Color> color = {
50: Color.fromRGBO(255, 92, 87, .1),
100: Color.fromRGBO(255, 92, 87, .2),
200: Color.fromRGBO(255, 92, 87, .3),
300: Color.fromRGBO(255, 92, 87, .4),
400: Color.fromRGBO(255, 92, 87, .5),
500: Color.fromRGBO(255, 92, 87, .6),
600: Color.fromRGBO(255, 92, 87, .7),
700: Color.fromRGBO(255, 92, 87, .8),
800: Color.fromRGBO(255, 92, 87, .9),
900: Color.fromRGBO(255, 92, 87, 1),
};

MaterialColor colorCustom = MaterialColor(0xFFFEA3DA, color);


//constants
//app accent color : blue bright? #4eace9
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        homeRoute: (context) =>  Books(),
        breatheRoute: (context) =>  BreathingCarouselScreen(),
        matchingRoute: (context) => MemoryMatchGame(),
        heatmapRoute: (context) => Meditaion(),
       
      },
      debugShowCheckedModeBanner: false,
      title: 'Zenpuku',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: AppStart(),
    );
  }
}

class AppStart extends StatefulWidget {
  @override
  _AppStartState createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  Future<bool> hasVisited() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasVisited = prefs.getBool('notVisited') ?? true;
    return hasVisited;
  }

  void notVisited() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notVisited', false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: hasVisited(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return IntroPages(
            visited: () {
              notVisited();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          );
        } else {
          return Home();
        }
      },
    );
  }
}

class IntroPages extends StatelessWidget {
  final VoidCallback visited;

  const IntroPages({key, required this.visited}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Image.asset(
                      "assets/zenpuku.png",
                      fit: BoxFit.contain,
                    ),
                  )),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF4eace9)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFffffff),
                    ),
                  ),
                  onPressed: visited,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
