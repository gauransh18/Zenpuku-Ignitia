// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

// class Meditaion extends StatefulWidget {
//   const Meditaion({super.key});

//   @override
//   State<Meditaion> createState() => _MeditaionState();
// }

// class _MeditaionState extends State<Meditaion> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
//               child: Align(
//                 alignment: Alignment.center,
//                 child: HeatMap(
//                   datasets: {
//                     DateTime(2023, 5, 6): 3,
//                     DateTime(2023, 5, 7): 7,
//                     DateTime(2023, 5, 8): 10,
//                     DateTime(2023, 5, 9): 13,
//                     DateTime(2023, 5, 13): 6,
//                   },
//                   startDate: DateTime.now(),
//                   endDate: DateTime.now().add(Duration(days: 75)),
//                   colorMode: ColorMode.opacity,
//                   showText: false,
//                   scrollable: true,
//                   size: 30,
//                   colorsets: {
//                     1: Color.fromARGB(20, 2, 179, 8),
//                     2: Color.fromARGB(40, 2, 179, 8),
//                     3: Color.fromARGB(60, 2, 179, 8),
//                     4: Color.fromARGB(80, 2, 179, 8),
//                     5: Color.fromARGB(100, 2, 179, 8),
//                     6: Color.fromARGB(120, 2, 179, 8),
//                     7: Color.fromARGB(140, 2, 179, 8),
//                     8: Color.fromARGB(160, 2, 179, 8),
//                     9: Color.fromARGB(180, 2, 179, 8),
//                     10: Color.fromARGB(200, 2, 179, 8),
//                   },
//                   onClick: (value) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text(value.toString())));

//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class Meditaion extends StatefulWidget {
  const Meditaion({Key? key}) : super(key: key);

  @override
  State<Meditaion> createState() => _MeditaionState();
}

class _MeditaionState extends State<Meditaion> {
  Map<DateTime, int> datasets = {
    DateTime(2023, 5, 6): 3,
    DateTime(2023, 5, 7): 7,
    DateTime(2023, 5, 8): 10,
    DateTime(2023, 5, 9): 13,
    DateTime(2023, 5, 13): 6,
  };

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();

  }

  void colorToday() {
    setState(() {
      datasets[DateTime.now()] = 5; // Change the value to the desired color set
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
              child: Align(
                alignment: Alignment.center,
                child: HeatMap(
                  datasets: datasets,

                  startDate: DateTime.now(),
                  endDate: DateTime.now().add(Duration(days: 75)),
                  colorMode: ColorMode.opacity,
                  showText: false,
                  scrollable: true,
                  size: 30,
                  colorsets: {
                    1: Color.fromARGB(20, 2, 179, 8),
                    2: Color.fromARGB(40, 2, 179, 8),
                    3: Color.fromARGB(60, 2, 179, 8),
                    4: Color.fromARGB(80, 2, 179, 8),
                    5: Color.fromARGB(100, 2, 179, 8),
                    6: Color.fromARGB(120, 2, 179, 8),
                    7: Color.fromARGB(140, 2, 179, 8),
                    8: Color.fromARGB(160, 2, 179, 8),
                    9: Color.fromARGB(180, 2, 179, 8),
                    10: Color.fromARGB(200, 2, 179, 8),
                  },
                  onClick: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(value.toString())),
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (() => colorToday()),
              child: Text('Color Today'),
            ),
          ],
        ),
      ),
    );
  }
}
