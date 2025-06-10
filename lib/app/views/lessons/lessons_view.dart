import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/lessons_controller.dart';
import 'tabs/content_tab.dart';
import 'tabs/files_tab.dart';
import 'tabs/exam_tab.dart';

class LessonsView extends GetView<LessonsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lessons'),
        bottom: TabBar(
          onTap: controller.changeTab,
          tabs: [
            Tab(text: 'Content'),
            Tab(text: 'Files'),
            Tab(text: 'Exam'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          ContentTab(),
          FilesTab(),
          ExamTab(),
        ],
      ),
    );
  }
}

// Create the tab views in separate files for better organization
class ContentTab extends GetView<LessonsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      
      if (controller.error.isNotEmpty) {
        return Center(child: Text(controller.error.value));
      }

      return ListView.builder(
        itemCount: controller.lessons.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final lesson = controller.lessons[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(lesson.content),
                  if (lesson.hasExam) ...[
                    SizedBox(height: 8),
                    Chip(
                      label: Text('Has Exam'),
                      backgroundColor: Colors.blue.withOpacity(0.1),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class FilesTab extends GetView<LessonsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        itemCount: controller.lessons.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final lesson = controller.lessons[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    lesson.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...lesson.files.map((file) => ListTile(
                  leading: Icon(Icons.file_present),
                  title: Text(file),
                  trailing: IconButton(
                    icon: Icon(Icons.download),
                    onPressed: () {
                      Get.snackbar(
                        'Download',
                        'Downloading $file',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                )).toList(),
              ],
            ),
          );
        },
      );
    });
  }
}

class ExamTab extends GetView<LessonsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      final examsAvailable = controller.lessons
          .where((lesson) => lesson.hasExam)
          .toList();

      if (examsAvailable.isEmpty) {
        return Center(
          child: Text('No exams available for these lessons'),
        );
      }

      return ListView.builder(
        itemCount: examsAvailable.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final lesson = examsAvailable[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(lesson.title),
              subtitle: Text('Exam available'),
              trailing: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/exams/${lesson.id}');
                },
                child: Text('Start Exam'),
              ),
            ),
          );
        },
      );
    });
  }
}
