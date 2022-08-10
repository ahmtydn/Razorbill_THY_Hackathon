import 'package:flutter/material.dart';
import '../gamification/GamificationHome.dart';

class GamificationPage extends StatefulWidget {
  const GamificationPage({Key? key}) : super(key: key);

  @override
  State<GamificationPage> createState() => _GamificationPageState();
}

class _GamificationPageState extends State<GamificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GamificationHome(),
    );
  }
}
