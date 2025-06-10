import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/files_controller.dart';
import '../../models/course_file.dart';

class FilesView extends GetView<FilesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Files'),
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
                  onPressed: controller.fetchFiles,
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.files.isEmpty) {
          return Center(
            child: Text(
              'No files available.',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.files.length,
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final file = controller.files[index];
            return FileCard(file: file);
          },
        );
      }),
    );
  }
}

class FileCard extends StatelessWidget {
  final CourseFile file;

  const FileCard({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilesController>();

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getFileColor(file),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              file.extension.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        title: Text(
          file.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('Size: ${file.size}'),
            Text('Uploaded: ${file.formattedDate}'),
          ],
        ),
        trailing: Obx(() {
          final progress = controller.downloadProgress[file.id];
          if (progress != null) {
            return SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 2,
              ),
            );
          }

          return IconButton(
            icon: Icon(Icons.download),
            onPressed: () => controller.downloadFile(file.id),
          );
        }),
      ),
    );
  }

  Color _getFileColor(CourseFile file) {
    if (file.isPDF) return Colors.red;
    if (file.isDocument) return Colors.blue;
    if (file.isPresentation) return Colors.orange;
    return Colors.grey;
  }
}
