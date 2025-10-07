import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:taskmate_flutter_app/app.dart';

void main() {
  testWidgets('Renders TaskMate app shell', (tester) async {
    await tester.pumpWidget(const TaskMateApp(firebaseConfigured: false));
    expect(find.text('TaskMate'), findsWidgets);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
