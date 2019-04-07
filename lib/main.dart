import 'package:flutter/material.dart';
import 'ui/home.dart'; // ui-1
import 'ui/screen.dart'; //  ui-2

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
      initialRoute: "/",
      routes: {
        "/": (context) => home(),
        "/screen": (context) => screen(),
        },
    );
  }
}
