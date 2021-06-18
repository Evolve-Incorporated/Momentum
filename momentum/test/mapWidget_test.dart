// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:momentum/main.dart';
import 'package:momentum/mapWidget.dart';

void main() {
  testWidgets('Home Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MapWidget(title: 'Momentum'));
  });
}
