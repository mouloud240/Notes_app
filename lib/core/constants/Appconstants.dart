class NoteType {
  final String name;
  final String iconPath;
  NoteType(
    this.name,
    this.iconPath,
  );
}

class GetNoteTypesList {
  List<NoteType> getNotes() {
    List<NoteType> list = [  
    NoteType("Camera", "assets/icons/camera.svg"),
     NoteType("Drawing Sketch", "assets/icons/sketch.svg"),
      NoteType("Attach file", "assets/icons/file.svg"),
       NoteType("Audio file", "assets/icons/audio.svg"),
        NoteType("Private Note", "assets/icons/private.svg"),
    
    ];
    return list;
  }
}
