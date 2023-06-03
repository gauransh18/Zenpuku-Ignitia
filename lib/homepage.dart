// import 'package:flutter/material.dart';
// import 'breathing.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               // Greeting section
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.95,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.white,
//                       width: 2,
//                     ),
//                     //  color: Color(0xFFB799FF),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Row(
//                         children: [
//                           Text(
//                             _getGreeting(),
//                             style: TextStyle(
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           Icon(
//                             Icons.mood,
//                             color: Colors.white,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // Books section

//               // Activities section
//               //   SizedBox(height: 20),
//               //     Text(
//               //       "Activities",
//               //       style: GoogleFonts.mukta(
//               //         fontSize: 30,
//               //         fontWeight: FontWeight.bold,
//               //         color: Colors.white,
//               //       ),
//               //     ),
//               //     SizedBox(height: 10),
//               //     Row(
//               //       children: [
//               //         ElevatedButton(
//               //           onPressed: () {
//               //             Navigator.of(context).pushNamed(
//               //               breatheRoute,
//               //             );
//               //           },
//               //           child: Text(
//               //             "Breathing",
//               //             style: GoogleFonts.mukta(
//               //               fontSize: 20,
//               //               fontWeight: FontWeight.bold,
//               //             ),
//               //           ),
//               //         ),
//               //         SizedBox(width: 10),
//               //         ElevatedButton(
//               //           onPressed: () {
//               //             Navigator.of(context).pushNamed(
//               //               matchingRoute,
//               //             );
//               //           },
//               //           child: Text(
//               //             "Memory Match",
//               //             style: GoogleFonts.mukta(
//               //               fontSize: 20,
//               //               fontWeight: FontWeight.bold,
//               //             ),
//               //           ),
//               //         ),
//               //       ],
//               //     ),

//               //     // Calendar section
//               //     SizedBox(height: 20),
//               //     ElevatedButton(
//               //       onPressed: () {
//               //         Navigator.of(context).pushNamed(
//               //           heatmapRoute,
//               //         );
//               //       },
//               //       child: Text(
//               //         "Meditation",
//               //         style: GoogleFonts.mukta(
//               //           fontSize: 20,
//               //           fontWeight: FontWeight.bold,
//               //         ),
//               //       ),
//               //     ),
//               //   ],
//               // ),
//             ]),
//           ),
//         );
//   }
// }

// String _getGreeting() {
//   var hour = DateTime.now().hour;
//   if (hour < 12) {
//     return 'Good morning!';
//   } else if (hour < 17) {
//     return 'Good afternoon!';
//   } else {
//     return 'Good evening!';
//   }
// }

import 'dart:math';

import 'package:flutter/material.dart';
//import 'breathing.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting section
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Text(
                          _getGreeting(),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.mood,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Breathing Carousel

            Padding(
              padding: const EdgeInsets.only(right: 600.0),
              child: Center(
                //     alignment: Alignment.centerLeft,
                child: SizedBox(
                    height: 300, width: 300, child: BreathingCarouselScreen()),
              ),
            ),

            // Text below the carousel
            // SizedBox(height: 10),
            // Text(
            //   "Breathe in, Breathe out",
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //   ),
            // ),

            // Books section
          ],
        ),
      ),
    );
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning!';
    } else if (hour < 17) {
      return 'Good afternoon!';
    } else {
      return 'Good evening!';
    }
  }
}

class BreathingCarouselScreen extends StatefulWidget {
  @override
  _BreathingCarouselScreenState createState() =>
      _BreathingCarouselScreenState();
}

class _BreathingCarouselScreenState extends State<BreathingCarouselScreen>
    with SingleTickerProviderStateMixin {
  double carouselRadius = 100;
  Offset carouselCenter = Offset.zero;
  double carouselSpeed = 1;

  double breathRadius = 50;
  Color breathColor = Colors.white; // Change the breath color to white
  double breathSpeed = 0.6;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    carouselCenter = Offset(
      MediaQuery.of(context).size.width / 2,
      MediaQuery.of(context).size.height / 2,
    );

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final carouselX =
            carouselCenter.dx + carouselRadius * cos(carouselSpeed);
        final carouselY =
            carouselCenter.dy + carouselRadius * sin(carouselSpeed);

        final breathX = carouselX + breathRadius * cos(breathSpeed);
        final breathY = carouselY + breathRadius * sin(breathSpeed);

        carouselSpeed += 0.015;
        breathSpeed += 0.03;

        return CustomPaint(
          painter: BreathingCarouselPainter(
            carouselCenter: carouselCenter,
            carouselRadius: carouselRadius,
            breathColor: breathColor,
            breathPosition: Offset(breathX, breathY),
          ),
        );
      },
    );
  }
}

class BreathingCarouselPainter extends CustomPainter {
  final Offset carouselCenter;
  final double carouselRadius;
  final Color breathColor;
  final Offset breathPosition;

  BreathingCarouselPainter({
    required this.carouselCenter,
    required this.carouselRadius,
    required this.breathColor,
    required this.breathPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw the carousel
    paint.color = Colors.white; // Set carousel color to white
    canvas.drawCircle(carouselCenter, carouselRadius, paint);

    // Draw the breathing circle
    paint.color = breathColor;
    canvas.drawCircle(breathPosition, 10, paint);
  }

  @override
  bool shouldRepaint(BreathingCarouselPainter oldDelegate) {
    return true;
  }
}
