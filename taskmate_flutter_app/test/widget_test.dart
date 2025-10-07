import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskmate_flutter_app/main.dart';

void main() {
  testWidgets('App boots and shows SignIn or Main Tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const TaskMateApp());
    await tester.pump(const Duration(milliseconds: 100));

    final signInButton = find.byIcon(Icons.login);
    final bottomBar = find.byType(BottomNavigationBar);

    final hasSignIn = signInButton.evaluate().isNotEmpty;
    final hasBottomBar = bottomBar.evaluate().isNotEmpty;

    expect(hasSignIn || hasBottomBar, isTrue);
  });

  testWidgets('Has router-driven navigation (Navigator present)', (WidgetTester tester) async {
    await tester.pumpWidget(const TaskMateApp());
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.byType(Navigator), findsWidgets);
  });
}
