

import 'package:flutter/material.dart';

class MeditatePage extends StatefulWidget {
  const MeditatePage({super.key});

  @override
  State<MeditatePage> createState() => _MeditatePageState();
}

class _MeditatePageState extends State<MeditatePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Meditate Page"),)
    );
  }
}