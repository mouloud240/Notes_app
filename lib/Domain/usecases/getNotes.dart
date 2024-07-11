import 'package:note_app/Domain/repos/notesRepo.dart';
import 'package:note_app/data/models/NoteModel.dart';

class Getnotes {
  final NotesRepo notesRepository;

  Getnotes(this.notesRepository);

  Future<List<NoteModel>> call() async {
    return await notesRepository.getNotes();
  }
}