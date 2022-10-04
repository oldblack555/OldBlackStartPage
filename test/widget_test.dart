// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/order_register.dart';

import 'package:terminal/main.dart';

void main() {
  test("Audio test", () async {
    // await audioPlayer.setSourceUrl("http://olddm.ybteam.cn/download/cx.flac");
    // await audioPlayer.resume();
  });

  test("Search Order", () {
    BaseOrder searchOrder = OrderCore.orders["search"]!;
    searchOrder.execute("search  Hello World");
    // SystemController.defaultSearchEngine = "bing";
    BaseOrder configOrder = OrderCore.orders["config"]!;
    configOrder.execute("config -se baidu");
    searchOrder.execute("search  Hello World");
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
