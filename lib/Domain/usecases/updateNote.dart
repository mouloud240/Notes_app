import 'package:note_app/Domain/repos/notesRepo.dart';
import 'package:note_app/data/models/NoteModel.dart';

class Updatenote{

  final NotesRepo noteRepository;

  Updatenote(this.noteRepository);

  Future<void> call(NoteModel note) async {
    return await noteRepository.updateNote(note);
  }
}