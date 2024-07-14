import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/Domain/usecases/deleteNote.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/data/models/NoteModel.dart';
import 'package:note_app/data/repos/notesRepoImplement.dart';
import 'package:note_app/data/source/local/LocalDataSource.dart';

class Noteinnerscreen extends StatefulWidget {
  final NoteModel note;
  const Noteinnerscreen({super.key, required this.note});

  @override
  State<Noteinnerscreen> createState() => _NoteinnerscreenState();
}

class _NoteinnerscreenState extends State<Noteinnerscreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content.content;
  }

  @override
  Widget build(BuildContext context) {
    final _mybox = Hive.box<NoteModel>('notes');

    Future<void> handleDelete() async {
      await Deletenote(
              noteRepository: Notesrepoimplement(
                  localdatasource: Localdatasource(notesBox: _mybox)))
          .call(widget.note);
      Navigator.of(context).pushNamed("home");
    }

    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      appBar: AppBar(
          backgroundColor: Appcolors.backgroundColor,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('home');
              },
              child: const Icon(
                Icons.arrow_back,
                color: Appcolors.lightgrey,
              )),
          elevation: 0,
          actions: [
            PopupMenuButton(
                color: Appcolors.lightgrey,
                onSelected: (String val) {
                  handleDelete();
                },
                itemBuilder: (BuildContext context) {
                  return {"Delete"}.map((String choice) {
                    return PopupMenuItem(value: choice, child: Text(choice));
                  }).toList();
                })
          ]),
      body: Column(
        children: [
          Text(
            widget.note.title,
            style: TextStyle(color: Appcolors.blue),
          )
        ],
      ),
    );
  }
}
