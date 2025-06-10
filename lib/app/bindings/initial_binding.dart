import 'package:get/get.dart';
import '../controllers/lessons_controller.dart';
import '../controllers/chat_controller.dart';
import '../controllers/exams_controller.dart';
import '../controllers/files_controller.dart';
import '../controllers/home_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize controllers
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<LessonsController>(() => LessonsController());
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<ExamsController>(() => ExamsController());
    Get.lazyPut<FilesController>(() => FilesController());
  }
}
