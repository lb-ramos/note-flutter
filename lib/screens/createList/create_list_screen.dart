import 'package:flutter/material.dart';
import 'package:note_flutter/Utils/Util.dart';
import 'package:note_flutter/Utils/constants.dart';
import 'package:note_flutter/database/database_helpers.dart';
import 'package:note_flutter/models/NoteCard.dart';
import 'package:note_flutter/screens/home/home_screen.dart';

class CreateListScreen extends StatefulWidget {

  final Note note;
  CreateListScreen(this.note);

  @override
  _CreateListScreenState createState() => _CreateListScreenState();
}

class _CreateListScreenState extends State<CreateListScreen> {
  final color = Util.cardColor;
  final DatabaseHelper helper = DatabaseHelper.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  NoteCard cardCreated = NoteCard();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

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
        icon: Icon(Icons.arrow_back, color: Colors.black),
        tooltip: 'Salvar nota',
        onPressed: () {
          if (cardCreated.title != null && cardCreated.content != null) {
            if (widget.note != null) {
              updateOnDB();
            } else {
              saveOnDB();
            }
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.black,
          ),
          onPressed: () {
            if (widget.note != null) {
              deleteOnDB();
            }
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
          },
        ),
      ],
    );
  }


  updateOnDB() async {
    Note note = Note(widget.note.id, cardCreated.title, cardCreated.content);
    int id = await helper.update(note);
    print('update row: $id');
  }


  saveOnDB() async {
    Note note = Note(null,cardCreated.title, cardCreated.content);
    int id = await helper.insert(note);
    print('inserted row: $id');
  }

  deleteOnDB() async {
    int id = await helper.deleteNote(widget.note.id);
    print('inserted row: $id');
  }

  Widget buildBody() {

    String title = "";
    String content = "";

    if(widget.note !=null){
      title = widget.note.title;
      content = widget.note.content;
    }

    return Column(children: <Widget>[
      Container(
          margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
          child: TextFormField(
            initialValue: title,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            decoration: InputDecoration(border: InputBorder.none, hintText: 'Digite o título',),
            onChanged: (text) {
              setState(() {
                cardCreated.title = text;
              });
            },
          )),
      Container(
          margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
          child: TextFormField(
            initialValue: content ,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(fontSize: fontContent, color: Colors.black),
            decoration: InputDecoration(border: InputBorder.none, hintText: 'Digite o conteúdo',),
            onChanged: (text) {
              setState(() {
                cardCreated.content = text;
              });
            },
          )),
    ]);
  }
}
