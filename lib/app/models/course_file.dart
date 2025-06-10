import '../controllers/files_controller.dart';

class CourseFile {
  final String id;
  final String name;
  final String size;
  final FileType type;
  final String url;
  final DateTime uploadDate;

  CourseFile({
    required this.id,
    required this.name,
    required this.size,
    required this.type,
    required this.url,
    required this.uploadDate,
  });

  factory CourseFile.fromJson(Map<String, dynamic> json) {
    return CourseFile(
      id: json['id'],
      name: json['name'],
      size: json['size'],
      type: FileType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => FileType.document,
      ),
      url: json['url'],
      uploadDate: DateTime.parse(json['uploadDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'size': size,
      'type': type.toString(),
      'url': url,
      'uploadDate': uploadDate.toIso8601String(),
    };
  }

  String get formattedDate {
    return '${uploadDate.year}-${uploadDate.month.toString().padLeft(2, '0')}-${uploadDate.day.toString().padLeft(2, '0')}';
  }

  String get extension {
    return name.split('.').last.toLowerCase();
  }

  bool get isPDF => extension == 'pdf';
  bool get isDocument => extension == 'doc' || extension == 'docx';
  bool get isPresentation => extension == 'ppt' || extension == 'pptx';
}
