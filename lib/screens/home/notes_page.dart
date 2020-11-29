import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_flutter/database/database_helpers.dart';
import 'package:note_flutter/screens/home/cards_home.dart';

class NotesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  List<Note> allNotes = [];

  @override
  Widget build(BuildContext context) {
    GlobalKey _stagKey = GlobalKey();

    return Container(
        child: FutureBuilder(
            future: getNotesFromDb(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                allNotes = snapshot.data;
                return Container(
                    child: Padding(
                      padding: paddingForView(context),
                      child: new StaggeredGridView.count(
                        key: _stagKey,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        crossAxisCount: 1,
                        children: getListOfCardsWithHandlers(),
                        staggeredTiles: tiles(),
                      ),
                    ));
              } else {
                return Center(
                  child: Container(),
                );
              }
            }));

  }

  List<CardsHome> getListOfCardsWithHandlers() {
    List<CardsHome> list = [];
    allNotes.forEach((note) {
      list.add(CardsHome(Note(
        note.id,
        note.title == null ? "" : note.title,
        note.content == null ? "" : note.content,
      )));
      });
      return list;
  }

  List<StaggeredTile> tiles() {
    return List.generate(allNotes.length, (index) {
      return StaggeredTile.fit(1);
    });
  }

  EdgeInsets paddingForView(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    double padding ;
    double topBottom = 8;
    if (width > 500) {
      padding = ( width ) * 0.05 ; // 5% padding of width on both side
    } else {
      padding = 8;
    }
    return EdgeInsets.only(left: padding, right: padding, top: topBottom, bottom: topBottom);
  }

  Future<List<Note>> getNotesFromDb() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    return await helper.queryAllNotes();
  }
}
