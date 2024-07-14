import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:note_app/Domain/Entities/Text_entity.dart';
import 'package:note_app/Domain/usecases/addNote.dart';
import 'package:note_app/Presentation/Screens/noteInnerScreen.dart';
import 'package:note_app/Presentation/Widgets/CutombuttonWigdet.dart';
import 'package:note_app/Presentation/Widgets/NoteTypewidget.dart';
import 'package:note_app/core/constants/Appconstants.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/data/models/NoteModel.dart';
import 'package:note_app/data/repos/notesRepoImplement.dart';
import 'package:note_app/data/source/local/LocalDataSource.dart';
import 'package:note_app/Domain/Entities/note.dart';

class Plustapscreen extends StatelessWidget {
  const Plustapscreen({super.key});
  static List<NoteType> typesList = GetNoteTypesList().getNotes();

  @override
  Widget build(BuildContext context) {
    final _mybox = Hive.box<NoteModel>('notes');
    Future<void> handlenoteClick() async {
      int nextId =
          (_mybox.isNotEmpty ? _mybox.getAt(_mybox.length - 1)?.id ?? -1 : -1) +
              1;
      NoteModel _addedNote = NoteModel(
          id: nextId,
          title: "I am the Hunter",
          content: TextEntity(
              content: "This is the end",
              isUnderlined: false,
              isItalique: false,
              isBold: false,
              fontSize: 20),
          creationDate: DateTime.now(),
          isArchived: false);
      await AddNote(
              notesRepo: Notesrepoimplement(
                  localdatasource: Localdatasource(notesBox: _mybox)))
          .call(_addedNote);
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Noteinnerscreen(note: _addedNote)));
    }

    return Scaffold(
      floatingActionButton: CustomButtonWidget(
        buttonIcon: Icons.cancel_sharp,
        onclickFuntction: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Appcolors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "What Notes\nDo you Want??",
              style: TextStyle(color: Appcolors.white, fontSize: 45),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 14),
              decoration: const BoxDecoration(color: Appcolors.darkGrey),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 40,
                    ),
                    itemCount: typesList.length,
                    itemBuilder: (context, index) {
                      return Notetypewidget(
                          name: typesList[index].name,
                          iconPath: typesList[index].iconPath);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Appcolors.lightgrey.withOpacity(0.33),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ActionButton(
                        textColor: Appcolors.black,
                        backgroundColor: Appcolors.lightGreen,
                        iconPath: "assets/icons/note.svg",
                        name: "Notes",
                        onclickfunction: () {
                          handlenoteClick();
                        },
                      ),
                      ActionButton(
                          textColor: Appcolors.white,
                          name: "Tasks",
                          iconPath: "assets/icons/task.svg",
                          backgroundColor: Appcolors.blue,
                          onclickfunction: () {})
                    ],
                  )
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String name;
  final String iconPath;
  final Color textColor;
  final Color backgroundColor;
  final Function onclickfunction;

  const ActionButton({
    super.key,
    required this.name,
    required this.iconPath,
    required this.backgroundColor,
    required this.onclickfunction,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Padding(
        padding: const EdgeInsets.only(left: 0.2),
        child: ElevatedButton(
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(6))),
                backgroundColor: WidgetStatePropertyAll(backgroundColor)),
            onPressed: () {
              onclickfunction();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(iconPath),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
