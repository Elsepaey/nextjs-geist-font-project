import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/exams_controller.dart';
import '../../models/exam.dart';

class ExamsView extends GetView<ExamsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exams'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.error.value,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchExams,
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.exams.isEmpty) {
          return Center(
            child: Text(
              'No exams available at the moment.',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.exams.length,
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final exam = controller.exams[index];
            return ExamCard(exam: exam);
          },
        );
      }),
    );
  }
}

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({Key? key, required this.exam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isExpired = exam.isExpired;

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    exam.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isExpired ? Colors.red : Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isExpired ? 'Expired' : 'Available',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(exam.description),
            SizedBox(height: 16),
            Row(
              children: [
                _InfoChip(
                  icon: Icons.timer,
                  label: exam.formattedDuration,
                ),
                SizedBox(width: 8),
                _InfoChip(
                  icon: Icons.quiz,
                  label: '${exam.totalQuestions} Questions',
                ),
                SizedBox(width: 8),
                _InfoChip(
                  icon: Icons.event,
                  label: 'Due: ${exam.formattedDeadline}',
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isExpired
                    ? null
                    : () => Get.find<ExamsController>().startExam(exam.id),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isExpired ? 'Exam Expired' : 'Start Exam',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
