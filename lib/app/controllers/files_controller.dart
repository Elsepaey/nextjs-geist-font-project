import 'package:get/get.dart';
import '../models/course_file.dart';

class FilesController extends GetxController {
  final files = <CourseFile>[].obs;
  final isLoading = true.obs;
  final error = ''.obs;
  final downloadProgress = RxMap<String, double>();

  @override
  void onInit() {
    super.onInit();
    fetchFiles();
  }

  Future<void> fetchFiles() async {
    try {
      isLoading(true);
      // Simulated API call
      await Future.delayed(Duration(seconds: 1));
      files.assignAll([
        CourseFile(
          id: '1',
          name: 'Course Introduction.pdf',
          size: '2.5 MB',
          type: FileType.pdf,
          url: 'https://example.com/files/intro.pdf',
          uploadDate: DateTime.now().subtract(Duration(days: 5)),
        ),
        CourseFile(
          id: '2',
          name: 'Week 1 Slides.pptx',
          size: '5.8 MB',
          type: FileType.presentation,
          url: 'https://example.com/files/week1.pptx',
          uploadDate: DateTime.now().subtract(Duration(days: 4)),
        ),
        CourseFile(
          id: '3',
          name: 'Practice Exercise.docx',
          size: '1.2 MB',
          type: FileType.document,
          url: 'https://example.com/files/exercise.docx',
          uploadDate: DateTime.now().subtract(Duration(days: 2)),
        ),
      ]);
    } catch (e) {
      error.value = 'Failed to load files: ${e.toString()}';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading(false);
    }
  }

  Future<void> downloadFile(String fileId) async {
    try {
      final file = files.firstWhere((f) => f.id == fileId);
      downloadProgress[fileId] = 0.0;

      // Simulate download progress
      for (var i = 0; i <= 100; i += 10) {
        await Future.delayed(Duration(milliseconds: 200));
        downloadProgress[fileId] = i / 100;
      }

      Get.snackbar(
        'Success',
        '${file.name} downloaded successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = 'Failed to download file: ${e.toString()}';
      Get.snackbar('Error', error.value);
    } finally {
      downloadProgress.remove(fileId);
    }
  }

  String getFileIcon(FileType type) {
    switch (type) {
      case FileType.pdf:
        return '📄';
      case FileType.presentation:
        return '📊';
      case FileType.document:
        return '📝';
      default:
        return '📁';
    }
  }
}

enum FileType {
  pdf,
  presentation,
  document,
}
