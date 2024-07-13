import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/data/models/NoteModel.dart';
import 'package:intl/intl.dart'; // Add this line to import the 'intl' package

class Homescreennotetile extends StatelessWidget {
  final NoteModel note;
  const Homescreennotetile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 150,
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
                    Text(
                      note.content.content,
                      style: const TextStyle(
                          color: Appcolors.lightgrey,
                          fontSize: 19,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
