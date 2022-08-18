class Blog{
  String uid = '';
  String writer_uid;
  String title;
  String content;
  DateTime posted;
  String category;

  Blog({
    required this.writer_uid,
    required this.title,
    required this.content,
    required this.posted,
    required this.category
  });
}