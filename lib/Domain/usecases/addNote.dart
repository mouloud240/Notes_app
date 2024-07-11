import 'dart:async';

import 'package:note_app/Domain/repos/notesRepo.dart';
import 'package:note_app/data/models/NoteModel.dart';

class AddNote {
  NotesRepo notesRepo;
  AddNote({required this.notesRepo});

  Future<void> call(NoteModel note) async {
    await notesRepo.addNote(note);
  }
}
