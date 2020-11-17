import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note_flutter/constants.dart';
import 'package:note_flutter/models/NoteCard.dart';
import 'package:note_flutter/screens/createList/components/body.dart';
//import 'package:note_flutter/screens/home/components/body.dart';

class CreateListScreen extends StatefulWidget {

  @override
  _CreateListScreenState createState() => _CreateListScreenState();
}

class _CreateListScreenState extends State<CreateListScreen> {
  final color = Colors.deepPurple;

  NoteCard cardCreated = NoteCard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(),
      backgroundColor: color,
    );
  }


  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      elevation: 0,
      textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        tooltip: 'Salvar nota',
        onPressed: () {

        },
      ),
    );
  }


  Widget buildBody(){

    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

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
                      cardCreated.title = titleController.text;
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
                      cardCreated.content = contentController.text;
                    });
                  },
                )),
          ]);
  }


}
