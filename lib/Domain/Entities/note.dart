class Note {
  int id;
  String title;
  String content;
  DateTime creationDate;
  DateTime? updatedAt;
  bool isArchived;
  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.creationDate,
      this.updatedAt,
      required this.isArchived});
}
