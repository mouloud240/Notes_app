import 'package:note_app/Domain/repos/notesRepo.dart';
import 'package:note_app/data/models/NoteModel.dart';

class Deletenote{
  final NotesRepo noteRepository;

  Deletenote({required this.noteRepository});

  Future<void> call(NoteModel note) async {
    await noteRepository.deleteNote(note.id);
  }
}
