import 'package:hive/hive.dart';
import 'package:note_app/data/models/NoteModel.dart';
class Localdatasource {
  final Box<NoteModel> notesBox;
  Localdatasource({required this.notesBox});
  Future<List<NoteModel>> getNotes() async {
    return await notesBox.values.toList();
  }
  Future<void> addNote(NoteModel note) async {
    await notesBox.put(note.id, note);
  }
  Future<void> removeNote(int id) async {
    await notesBox.delete(id);
  }
  Future<void> updateNote(NoteModel note) async {
    await notesBox.put(note.id,note);
  }
}
