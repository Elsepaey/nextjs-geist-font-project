import 'package:get/get.dart';
import '../models/lesson.dart';

class LessonsController extends GetxController {
  final lessons = <Lesson>[].obs;
  final isLoading = true.obs;
  final currentTabIndex = 0.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLessons();
  }

  void changeTab(int index) {
    currentTabIndex.value = index;
  }

  Future<void> fetchLessons() async {
    try {
      isLoading(true);
      // Simulated API call
      await Future.delayed(Duration(seconds: 1));
      lessons.assignAll([
        Lesson(
          id: 1,
          title: 'Introduction to the Course',
          content: 'Welcome to our comprehensive course...',
          files: ['intro.pdf', 'syllabus.pdf'],
          hasExam: true,
        ),
        Lesson(
          id: 2,
          title: 'Basic Concepts',
          content: 'In this lesson, we will cover the fundamental concepts...',
          files: ['basics.pdf', 'exercise1.pdf'],
          hasExam: true,
        ),
        Lesson(
          id: 3,
          title: 'Advanced Topics',
          content: 'Now we will dive into more advanced topics...',
          files: ['advanced.pdf', 'practice.pdf'],
          hasExam: true,
        ),
      ]);
    } catch (e) {
      error.value = 'Failed to load lessons: ${e.toString()}';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading(false);
    }
  }
}
