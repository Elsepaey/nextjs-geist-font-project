import 'package:get/get.dart';
import '../bindings/initial_binding.dart';
import '../views/home/home_view.dart';
import '../views/lessons/lessons_view.dart';
import '../views/chat/chat_view.dart';
import '../views/exams/exams_view.dart';
import '../views/files/files_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: Routes.LESSONS,
      page: () => LessonsView(),
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => ChatView(),
    ),
    GetPage(
      name: Routes.EXAMS,
      page: () => ExamsView(),
    ),
    GetPage(
      name: Routes.FILES,
      page: () => FilesView(),
    ),
  ];
}

abstract class Routes {
  static const HOME = '/';
  static const LESSONS = '/lessons';
  static const CHAT = '/chat';
  static const EXAMS = '/exams';
  static const FILES = '/files';
}
