import '../controllers/chat_controller.dart';

class ChatMessage {
  final String id;
  final String sender;
  final String content;
  final DateTime timestamp;
  final ChatType type;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
    required this.type,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      sender: json['sender'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      type: ChatType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => ChatType.group,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'type': type.toString(),
    };
  }

  bool get isFromCurrentUser => sender == 'You';
}
