import 'package:note_app/data/models/NoteModel.dart';

abstract class NotesRepo {
  Future<List<NoteModel>> getNotes();
  Future<void> addNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(int id);
}
