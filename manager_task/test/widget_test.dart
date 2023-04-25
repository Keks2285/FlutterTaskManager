// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manager_task/data/repositories/auth_repo.dart';

import 'package:manager_task/main.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

 test("Тестирование авторизации", () async {
    var result = await AuthRepo().signIn("example@gmail.com", "Pass1!", false);
    int uID=0;
    result.fold(
      (l) => {},
      (r) => uID=r.id,
    );
    expect(uID, 1);

     result = await AuthRepo().signIn("example2@gmail.com", "Pass1!", false);
     uID=0;
    result.fold(
      (l) => {},
      (r) => uID=r.id,
    );
    expect(uID, 3);


     result = await AuthRepo().signIn("example444@gmail.com", "Pass1!", false);
     String errorMessage="";
    result.fold(
      (l) => {errorMessage=l},
      (r) => {},
    );
    expect(errorMessage, "Пользователь не найден");

    result = await AuthRepo().signIn("example@gmail.com", "gfretgfret", false);
    errorMessage="";
    result.fold(
      (l) => {errorMessage=l},
      (r) => {},
    );
    expect(errorMessage, "Не верный пароль");
  });



  
}
