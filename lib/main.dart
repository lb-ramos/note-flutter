import 'package:flutter/material.dart';
import 'package:note_flutter/constants.dart';
import 'package:note_flutter/screens/home/home_screen.dart';
import 'package:note_flutter/screens/createList/create_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CreateListScreen(),
    );
  }
}

