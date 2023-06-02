import 'dart:math';

import 'package:flutter/material.dart';



void main() {
  runApp(BreathingCarouselApp());
}

class BreathingCarouselApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Just Breathe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BreathingCarouselScreen(),
    );
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
  Color breathColor = Colors.green;
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

    // fetchHello().then((value) => textt = value);

    //final texttt = fetchHello();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Carousel'),
      ),
      body: Stack(children: [
       

        AnimatedBuilder(
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
        ),
      ]),
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
