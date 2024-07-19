// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:note_app/Domain/Entities/Text_entity.dart';
import 'package:note_app/Domain/Entities/note.dart';
import 'package:note_app/Domain/Entities/subEntities/taskEntity.dart';
import 'package:note_app/Domain/Entities/subEntities/tasksEntity.dart';
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
  Timer? _debounce;
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List<Taskentity> _tasksList = [];
  String getContent(NoteContent content) {
    if (content is TextEntity) {
      return content.content;
    } else {
      return "test2";
    }
  }

  List<Taskentity> getTasks(NoteContent note) {
    if (note is TasksEntity) {
      return note.tasks;
    }
    return [];
  }

  void _onTaskNameChanged(String value, int index) {
    setState(() {
      _tasksList[index].task = value;
    });

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final Notesrepoimplement noteRepoImpl = Notesrepoimplement(
        localdatasource:
            Localdatasource(notesBox: Hive.box<NoteModel>('notes')),
      );

      noteRepoImpl.updateNote(NoteModel(
        id: widget.note.id,
        title: widget.note.title,
        content: TasksEntity(tasks: _tasksList),
        creationDate: widget.note.creationDate,
        isArchived: widget.note.isArchived,
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.note.content.getType() == "TasksEntity") {
      _tasksList = getTasks(widget.note.content);
    }
    _titleController.text = widget.note.title;
    _contentController.text = getContent(widget.note.content);
  }

  NoteContent getDummyNotecontent(NoteContent content, String val) {
    if (content is TextEntity) {
      return TextEntity(
          content: val,
          isUnderlined: content.isUnderlined,
          isItalique: content.isItalique,
          isBold: content.isBold,
          fontSize: content.fontSize);
    } else {
      return TextEntity(
          content: "Test1",
          isUnderlined: false,
          isItalique: false,
          isBold: false,
          fontSize: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _mybox = Hive.box<NoteModel>('notes');
    final Notesrepoimplement noteRepoImpl =
        Notesrepoimplement(localdatasource: Localdatasource(notesBox: _mybox));
    Future<void> handleDelete() async {
      await Deletenote(noteRepository: noteRepoImpl).call(widget.note);
      Navigator.of(context).pushNamed("home");
    }

    Future<void> handletitleEdit() async {
      //!bad code change it when you can!!!!!
      NoteModel dummyNote = NoteModel(
          id: widget.note.id,
          title: _titleController.text,
          content: _mybox.get(widget.note.id)!.content,
          creationDate: widget.note.creationDate,
          isArchived: widget.note.isArchived);
      await Updatenote(noteRepoImpl).call(dummyNote);
      setState(() {});
    }

    Future<void> handleContentEdit(String val) async {
      NoteModel dummyNote = NoteModel(
          id: widget.note.id,
          title: _mybox.get(widget.note.id)!.title,
          content: getDummyNotecontent(widget.note.content, val),
          creationDate: widget.note.creationDate,
          isArchived: widget.note.isArchived);

      return await Updatenote(noteRepoImpl).call(dummyNote);
    }

    if (widget.note.content.getType() == 'TextEntity') {
      return Scaffold(
        //resizeToAvoidBottomInset: true,
        backgroundColor: Appcolors.backgroundColor,
        appBar: AppBar(
            backgroundColor: Appcolors.backgroundColor,
            leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('home');
                },
                child: SizedBox(
                  width: 5,
                  height: 5,
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
        body: GestureDetector(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(
                      DateFormat.yMMMd()
                          .format(widget.note.creationDate)
                          .toString(),
                      style: const TextStyle(
                          color: Appcolors.lightgrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Appcolors.lightgrey,
                      size: 25,
                    )
                  ],
                ),
              ),
              TextField(
                onChanged: (String value) {
                  handletitleEdit();
                },
                decoration: const InputDecoration(
                    hintText: "Enter title......",
                    hintStyle: TextStyle(
                        color: Appcolors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
                controller: _titleController,
                style: const TextStyle(
                    color: Appcolors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  onChanged: (String value) {
                    handleContentEdit(value);
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter Note......",
                      hintStyle: TextStyle(
                          color: Appcolors.lightgrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  controller: _contentController,
                  style: const TextStyle(
                      color: Appcolors.lightgrey,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      );
    } else if (widget.note.content.getType() == 'TasksEntity') {
      return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Appcolors.lightBlue,
            onPressed: () async {
              setState(() {
                _tasksList.add(Taskentity(isDone: false, task: ""));
              });

              await Updatenote(noteRepoImpl).call(NoteModel(
                  id: widget.note.id,
                  title: widget.note.title,
                  content: TasksEntity(tasks: _tasksList),
                  creationDate: widget.note.creationDate,
                  isArchived: widget.note.isArchived));
            },
            label: const Text(
              "Add task",
              style: TextStyle(
                  color: Appcolors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: Appcolors.backgroundColor,
          appBar: AppBar(
              backgroundColor: Appcolors.backgroundColor,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('home');
                  },
                  child: SizedBox(
                    width: 5,
                    height: 5,
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
                        return PopupMenuItem(
                            value: choice, child: Text(choice));
                      }).toList();
                    })
              ]),
          body: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(
                      DateFormat.yMMMd()
                          .format(widget.note.creationDate)
                          .toString(),
                      style: const TextStyle(
                          color: Appcolors.lightgrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Appcolors.lightgrey,
                      size: 25,
                    )
                  ],
                ),
              ),
              TextField(
                onChanged: (String value) {
                  handletitleEdit();
                },
                decoration: const InputDecoration(
                    hintText: "Enter title......",
                    hintStyle: TextStyle(
                        color: Appcolors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
                controller: _titleController,
                style: const TextStyle(
                    color: Appcolors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _tasksList.length,
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemBuilder: (context, index) {
                    TextEditingController taskNameController =
                        TextEditingController();
                    taskNameController.text = _tasksList[index].task;
                    FocusNode textFocusNode = FocusNode();
                    return GestureDetector(
                      onLongPress: () {
                        noteRepoImpl.localdatasource.removeNote(widget.note.id);
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Row(
                          children: [
                            Checkbox(
                                checkColor: Appcolors.black,
                                activeColor: Appcolors.lightGreen,
                                value: _tasksList[index].isDone,
                                onChanged: (bool? val) {
                                  _tasksList = getTasks(widget.note.content);
                                  _tasksList[index].isDone =
                                      !_tasksList[index].isDone;

                                  final Notesrepoimplement noteRepoImpl =
                                      Notesrepoimplement(
                                          localdatasource: Localdatasource(
                                              notesBox: _mybox));
                                  noteRepoImpl.updateNote(NoteModel(
                                      id: widget.note.id,
                                      title: widget.note.title,
                                      content: TasksEntity(tasks: _tasksList),
                                      creationDate: widget.note.creationDate,
                                      isArchived: widget.note.isArchived));
                                  setState(() {});
                                }),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                focusNode: textFocusNode,
                                onSubmitted: (value) =>
                                    _onTaskNameChanged(value, index),
                                onChanged: (String value) {
                                  //_onTaskNameChanged(value, index);
                                },
                                decoration: const InputDecoration(
                                    hintText: "Enter task.....",
                                    hintStyle: TextStyle(
                                        color: Appcolors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.none),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                                controller: taskNameController,
                                style: const TextStyle(
                                    color: Appcolors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            ElevatedButton.icon(
                                style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.transparent),
                                    elevation: WidgetStatePropertyAll(0)),
                                onPressed: () async {
                                  setState(() {
                                    _tasksList.removeAt(index);
                                    print('deleted');
                                  });

                                  await Updatenote(noteRepoImpl).call(NoteModel(
                                      id: widget.note.id,
                                      title: widget.note.title,
                                      content: TasksEntity(tasks: _tasksList),
                                      creationDate: widget.note.creationDate,
                                      isArchived: widget.note.isArchived));
                                },
                                label: const Icon(
                                  Icons.delete,
                                  color: Appcolors.red,
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
            ]),
          ));
    } else {
      return Text(widget.note.runtimeType.toString());
    }
  }
}
