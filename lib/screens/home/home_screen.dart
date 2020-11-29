import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note_flutter/screens/createList/create_list_screen.dart';
import 'package:note_flutter/Utils/constants.dart';
import 'package:note_flutter/screens/home/notes_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: NotesPage(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text("FlutterNote"),
      textTheme: Theme.of(context).textTheme.apply(
          bodyColor: kTextColor
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/ic_add.svg",
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) => CreateListScreen(null)));
          },
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
