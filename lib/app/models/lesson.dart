class Lesson {
  final int id;
  final String title;
  final String content;
  final List<String> files;
  final bool hasExam;

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.files,
    required this.hasExam,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      files: List<String>.from(json['files']),
      hasExam: json['hasExam'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'files': files,
      'hasExam': hasExam,
    };
  }
}
