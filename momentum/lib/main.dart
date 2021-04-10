import 'package:flutter/material.dart';

import 'homePage.dart';

void main() {
  runApp(MomentumApp());
}

class MomentumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Momentum',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(title: 'Momentum'),
    );
  }
}
