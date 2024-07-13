import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Presentation/Widgets/NoteTypewidget.dart';
import 'package:note_app/core/constants/Appconstants.dart';
import 'package:note_app/core/constants/colors.dart';

class Plustapscreen extends StatelessWidget {
  const Plustapscreen({super.key});
  static List<NoteType> typesList = GetNoteTypesList().getNotes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.black,
      body: Column(
        children: [
          const Text(
            "What Notes\nDo you Want??",
            style: TextStyle(color: Appcolors.white, fontSize: 45),
          ),
          Expanded(
            child: Container(
              height:100,
              decoration: BoxDecoration(color: Appcolors.darkGrey),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: typesList.length,
                itemBuilder: (context, index) {
                  return Notetypewidget(
                      name: typesList[index].name,
                      iconPath: typesList[index].iconPath);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
