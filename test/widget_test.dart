import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:disan/app/my_app.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:disan/app/my_app.dart';

void main() {
  testWidgets('App loads test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(isTest: true));

    await tester.pump();

    expect(find.text('Test Mode'), findsOneWidget);
  });
}
