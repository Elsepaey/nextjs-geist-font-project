class Exam {
  final String id;
  final String title;
  final String description;
  final Duration duration;
  final int totalQuestions;
  final DateTime deadline;

  Exam({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.totalQuestions,
    required this.deadline,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      duration: Duration(minutes: json['durationMinutes']),
      totalQuestions: json['totalQuestions'],
      deadline: DateTime.parse(json['deadline']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'durationMinutes': duration.inMinutes,
      'totalQuestions': totalQuestions,
      'deadline': deadline.toIso8601String(),
    };
  }

  String get formattedDuration {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '$hours hr ${minutes > 0 ? '$minutes min' : ''}';
    }
    return '$minutes min';
  }

  String get formattedDeadline {
    return '${deadline.year}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')}';
  }

  bool get isExpired => DateTime.now().isAfter(deadline);
}
