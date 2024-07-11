import 'package:note_app/Domain/repos/notesRepo.dart';
import 'package:note_app/data/models/NoteModel.dart';
import 'package:note_app/data/source/local/LocalDataSource.dart';

class Notesrepoimplement implements NotesRepo {
  final Localdatasource localdatasource;
  Notesrepoimplement({required this.localdatasource});
  @override
  Future<void> addNote(NoteModel note) async {
    await localdatasource.addNote(note);
  }

  @override
  Future<void> deleteNote(int id) async {
    await localdatasource.removeNote(id);
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    return localdatasource.getNotes();
  }

  @override
  Future<void> updateNote(NoteModel note) async{
    await localdatasource.updateNote(note);
  }
}
