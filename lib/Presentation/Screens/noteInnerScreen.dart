import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:note_app/Domain/usecases/addNote.dart';
import 'package:note_app/Domain/usecases/deleteNote.dart';
import 'package:note_app/Domain/usecases/updateNote.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/data/models/NoteModel.dart';
import 'package:note_app/data/repos/notesRepoImplement.dart';
import 'package:note_app/data/source/local/LocalDataSource.dart';

class Noteinnerscreen extends StatefulWidget {
  final NoteModel note;
  const Noteinnerscreen({
    super.key,
    required this.note,
  });

  @override
  State<Noteinnerscreen> createState() => _NoteinnerscreenState();
}

class _NoteinnerscreenState extends State<Noteinnerscreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  late NoteModel _note;
  @override
  void initState() {
    super.initState();
    _note = widget.note;
    _titleController.text = _note.title;
    _contentController.text = _note.content.content;
  }

  @override
  Widget build(BuildContext context) {
    final _mybox = Hive.box<NoteModel>('notes');
    final Notesrepoimplement noteRepoImpl =
        Notesrepoimplement(localdatasource: Localdatasource(notesBox: _mybox));
    Future<void> handletitleEdit() async {
      //!bad code change it when you can!!!!!
      NoteModel dummyNote = NoteModel(
          id: widget.note.id,
          title: _titleController.text,
          content: widget.note.content,
          creationDate: widget.note.creationDate,
          isArchived: widget.note.isArchived);
      await Updatenote(noteRepoImpl).call(dummyNote);
    }
    Future<void> handleDelete() async {
      await Deletenote(noteRepository: noteRepoImpl).call(widget.note);
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
              child: SizedBox(
                width: 10,
                height: 10,
                child: SvgPicture.asset(
                  "assets/icons/backButton.svg",
                ),
              )),
          elevation: 0,
          actions: [
            PopupMenuButton(
                color: Appcolors.lightgrey,
                onSelected: (String val) async {
                  await handleDelete();
                },
                itemBuilder: (BuildContext context) {
                  return {"Delete"}.map((String choice) {
                    return PopupMenuItem(value: choice, child: Text(choice));
                  }).toList();
                })
          ]),
      body: Column(
        children: [
          TextField(
            onChanged: (String value) {
              handletitleEdit();
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none)),
            controller: _titleController,
            style: const TextStyle(
                color: Appcolors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
