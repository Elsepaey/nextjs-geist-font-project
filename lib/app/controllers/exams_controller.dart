import 'package:get/get.dart';
import '../models/exam.dart';

class ExamsController extends GetxController {
  final exams = <Exam>[].obs;
  final isLoading = true.obs;
  final error = ''.obs;
  final currentExam = Rxn<Exam>();

  @override
  void onInit() {
    super.onInit();
    fetchExams();
  }

  Future<void> fetchExams() async {
    try {
      isLoading(true);
      // Simulated API call
      await Future.delayed(Duration(seconds: 1));
      exams.assignAll([
        Exam(
          id: '1',
          title: 'Mid-Term Examination',
          description: 'Covers all topics from weeks 1-6',
          duration: Duration(minutes: 90),
          totalQuestions: 50,
          deadline: DateTime.now().add(Duration(days: 7)),
        ),
        Exam(
          id: '2',
          title: 'Final Examination',
          description: 'Comprehensive exam covering all course material',
          duration: Duration(minutes: 180),
          totalQuestions: 100,
          deadline: DateTime.now().add(Duration(days: 30)),
        ),
        Exam(
          id: '3',
          title: 'Practice Quiz',
          description: 'Practice quiz to help you prepare for the mid-term',
          duration: Duration(minutes: 30),
          totalQuestions: 20,
          deadline: DateTime.now().add(Duration(days: 5)),
        ),
      ]);
    } catch (e) {
      error.value = 'Failed to load exams: ${e.toString()}';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading(false);
    }
  }

  void selectExam(Exam exam) {
    currentExam.value = exam;
  }

  Future<void> startExam(String examId) async {
    try {
      final exam = exams.firstWhere((e) => e.id == examId);
      selectExam(exam);
      Get.toNamed('/exam/${exam.id}');
    } catch (e) {
      error.value = 'Failed to start exam: ${e.toString()}';
      Get.snackbar('Error', error.value);
    }
  }
}
