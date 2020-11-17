import 'package:flutter/material.dart';
import 'package:note_flutter/constants.dart';

class Body extends StatefulWidget {

  final MaterialColor color;

  String title;
  String content;

  Body(this.color, this.title, this.content);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery
        .of(context)
        .size;
    return
    Column(
        children: <Widget>[
      Container(
          margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
          child: TextField(
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            controller: titleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Digite o título',
            ),
            onChanged: (text) {
              setState(() {
                widget.title = titleController.text;
              });
            },
          )),
          Container(
              margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
              child: TextField(
                style: TextStyle(fontSize: 18,color: Colors.white),
                controller: contentController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Digite o conteúdo',
                ),
                onChanged: (text) {
                  setState(() {
                    widget.content = contentController.text;
                  });
                },
              )),
    ]);
  }

}

