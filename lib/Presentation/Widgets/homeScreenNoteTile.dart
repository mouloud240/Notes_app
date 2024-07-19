import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:note_app/Domain/Entities/Text_entity.dart';
import 'package:note_app/Domain/Entities/note.dart';
import 'package:note_app/Domain/Entities/subEntities/taskEntity.dart';
import 'package:note_app/Domain/Entities/subEntities/tasksEntity.dart';
import 'package:note_app/Domain/usecases/deleteNote.dart';
import 'package:note_app/Presentation/Screens/noteInnerScreen.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/data/models/NoteModel.dart';
import 'package:intl/intl.dart';
import 'package:note_app/data/repos/notesRepoImplement.dart';
import 'package:note_app/data/source/local/LocalDataSource.dart'; // Add this line to import the 'intl' package

class Homescreennotetile extends StatelessWidget {
  final NoteModel note;
  const Homescreennotetile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final _mybox = Hive.box<NoteModel>('notes');

    Future<void> handleDelete() async {
      await Deletenote(
              noteRepository: Notesrepoimplement(
                  localdatasource: Localdatasource(notesBox: _mybox)))
          .call(note);
    }

    Widget GetContent(NoteContent content) {
      if (content is TextEntity) {
        return Text(
          content.content,
          style: const TextStyle(
              color: Appcolors.lightgrey,
              fontSize: 19,
              fontWeight: FontWeight.normal),
        );
      } else if (content is TasksEntity) {
        final List<Taskentity> _tasks = content.tasks.length >= 3
            ? content.tasks.sublist(0, 3)
            : List.from(content.tasks);
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Text(
                _tasks[index].task,
                style: const TextStyle(
                    color: Appcolors.lightgrey,
                    fontSize: 19,
                    fontWeight: FontWeight.normal),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: _tasks.length);
      } else {
        return const Text("Unexcpected Type");
      }
    }

    Widget setDatedisplayer() {
      if (note.creationDate.compareTo(DateTime.now()) == 0) {
        return Row(
          children: [
            Container(
              height: 2,
              width: 2,
              decoration: const BoxDecoration(
                  color: Appcolors.lightGreen, shape: BoxShape.circle),
            ),
            const Text(
              "Just Now",
              style: TextStyle(color: Appcolors.lightgrey, fontSize: 17),
            )
          ],
        );
      } else {
        return Text(
          DateFormat.MMMMd()
              .format(note.creationDate)
              .toString(), // Use the DateFormat class from the 'intl' package
          style: const TextStyle(color: Appcolors.lightgrey, fontSize: 17),
        );
      }
    }

    return GestureDetector(
      onLongPress: () => handleDelete(),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Noteinnerscreen(note: note),
        ));
      },
      child: Container(
          decoration: BoxDecoration(
            color: Appcolors.darkGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.MMMMd()
                            .format(note.creationDate)
                            .toString(), // Use the DateFormat class from the 'intl' package
                        style: const TextStyle(
                            color: Appcolors.lightgrey, fontSize: 17),
                      ),
                      SvgPicture.asset("assets/icons/share.svg"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        style: const TextStyle(
                          color: Appcolors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 36,
                        ),
                      ),
                      GetContent(note.content)
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
