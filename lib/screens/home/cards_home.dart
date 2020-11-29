import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_flutter/Utils/Util.dart';
import 'package:note_flutter/database/database_helpers.dart';
import 'package:note_flutter/screens/createList/create_list_screen.dart';

import '../../Utils/constants.dart';

class CardsHome extends StatefulWidget {
  final Note note;
  CardsHome(this.note);

  @override
  _CardsHomeState createState() => _CardsHomeState();

}

class _CardsHomeState extends State<CardsHome> {

  String content ;
  String title;

  @override
  Widget build(BuildContext context) {
    content = widget.note.content;
    title = widget.note.title;

    return GestureDetector(
      onTap: () => clickNote(context),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: Util.cardColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: EdgeInsets.all(8),
        child: constructChild(),
      ),
    );
  }

  void clickNote(BuildContext ctx) {
    Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => CreateListScreen(widget.note)));
  }


  Widget constructChild() {

    List<Widget> cardsOnScreen = [];

    if(widget.note.title.length != 0) {
      cardsOnScreen.add(
        AutoSizeText(
          title,
          style: TextStyle(fontSize: fontTitle, fontWeight: FontWeight.bold),
          maxLines: widget.note.title.length == 0 ? 1 : 3,
          textScaleFactor: 1.5,
        ),
      );
      cardsOnScreen.add(Divider(color: Colors.transparent,height: 6,),);
    }

    cardsOnScreen.add(
        AutoSizeText(
          content,
          style: TextStyle(fontSize: fontContent),
          maxLines: 10,
          textScaleFactor: 1.5,
        )
    );

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children:     cardsOnScreen
    );
  }

}