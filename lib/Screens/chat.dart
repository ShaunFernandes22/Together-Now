import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                // itemBuilder: (context, index) {
                //   return ListTile(
                //     title: Text(_messages[index]),
                //   );
                // },
                itemBuilder: (context, index) {
                  // return buildMessageBubble(_messages[index]);
                },
              ),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage() async {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      // Send message to the chatbot backend
      String response = await sendMessageToChatbot(message);

      // Update the UI
      setState(() {
        _messages.add('User: $message');
        _messages.add('Chatbot: $response');
        _messageController.clear();
      });
    }
  }

  Widget buildMessageBubble(Message message) {
    final isUserMessage = message.sender == MessageSender.user;
    final alignment =
        isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = isUserMessage ? Colors.blue : Colors.grey.shade300;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: alignment,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message.text,
              style:
                  TextStyle(color: isUserMessage ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> sendMessageToChatbot(String message) async {
    try {
      // Replace this URL with your actual chatbot API endpoint
      final url = Uri.parse('https://your-chatbot-api-url.com/send-message');
      final response = await http.post(
        url,
        body: jsonEncode({'message': message}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        return responseBody['response'];
      } else {
        return 'Failed to get a response from the chatbot.';
      }
    } catch (e) {
      return 'Error sending message to the chatbot: $e';
    }
  }
}

enum MessageSender {
  user,
  chatbot,
}

class Message {
  final MessageSender sender;
  final String text;

  Message({required this.sender, required this.text});
}
