import 'package:get/get.dart';
import '../models/chat_message.dart';

class ChatController extends GetxController {
  final messages = <ChatMessage>[].obs;
  final isLoading = false.obs;
  final currentChatType = ChatType.group.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialMessages();
  }

  void changeChatType(ChatType type) {
    currentChatType.value = type;
  }

  Future<void> loadInitialMessages() async {
    try {
      isLoading(true);
      // Simulated API call
      await Future.delayed(Duration(seconds: 1));
      messages.assignAll([
        ChatMessage(
          id: '1',
          sender: 'John Doe',
          content: 'Hello everyone!',
          timestamp: DateTime.now().subtract(Duration(minutes: 5)),
          type: ChatType.group,
        ),
        ChatMessage(
          id: '2',
          sender: 'Admin',
          content: 'Welcome to the course chat!',
          timestamp: DateTime.now().subtract(Duration(minutes: 3)),
          type: ChatType.admin,
        ),
      ]);
    } catch (e) {
      error.value = 'Failed to load messages: ${e.toString()}';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading(false);
    }
  }

  void sendMessage(String content) {
    try {
      final newMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: 'You', // In a real app, this would come from user authentication
        content: content,
        timestamp: DateTime.now(),
        type: currentChatType.value,
      );
      messages.add(newMessage);
    } catch (e) {
      error.value = 'Failed to send message: ${e.toString()}';
      Get.snackbar('Error', error.value);
    }
  }
}

enum ChatType { group, admin }
