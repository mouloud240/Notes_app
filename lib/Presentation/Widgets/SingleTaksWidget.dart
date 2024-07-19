import 'package:flutter/material.dart';
import 'package:note_app/Domain/Entities/subEntities/taskEntity.dart';
import 'package:note_app/core/constants/colors.dart';

class Singletakswidget extends StatefulWidget {
  Taskentity task;
  int id;
  Singletakswidget({super.key, required this.task, required this.id});

  @override
  State<Singletakswidget> createState() => _SingletakswidgetState();
}

class _SingletakswidgetState extends State<Singletakswidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: widget.task.isDone,
            onChanged: (bool) {
              widget.task.isDone = !widget.task.isDone;
            }),
     const SizedBox(
          width: 10,
        ),
        Text(
          widget.task.task,
          style: const TextStyle(
              color: Appcolors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none),
        )
      ],
    );
  }
}
