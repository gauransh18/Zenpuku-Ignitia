import 'dart:math';

import 'package:flutter/material.dart';


class MotionGraphicsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motion Graphics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MotionGraphicsScreen(),
    );
  }
}

class MotionGraphicsScreen extends StatefulWidget {
  @override
  _MotionGraphicsScreenState createState() => _MotionGraphicsScreenState();
}

class _MotionGraphicsScreenState extends State<MotionGraphicsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _rotation = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller)
      ..addListener(() {
        setState(() {
          _rotation = _animation.value;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motion Graphics'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotation,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
