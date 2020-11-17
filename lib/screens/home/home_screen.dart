import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note_flutter/constants.dart';
//import 'package:note_flutter/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      //body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
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
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
