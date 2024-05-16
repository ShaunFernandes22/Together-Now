import 'package:flutter/material.dart';
import 'package:together_now_ipd/Screens/chat/chat_bubble.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:together_now_ipd/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String apiKey = dotenv.get("GEMINI_API_KEY", fallback: "");

String prompt = Constants().prompt;

class GeminiPage extends StatefulWidget {
  const GeminiPage({super.key});

  @override
  State<GeminiPage> createState() => _GeminiPageState();
}

class _GeminiPageState extends State<GeminiPage> {
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.chatbot),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];
                return ChatBubble(
                  text: message['text'],
                  isCurrentUser: message['isCurrentUser'],
                );
              },
            )),
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ask me anything...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ),
              onFieldSubmitted: (_) => _sendMessage(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage() async {
    String text = _controller.text.trim();
    if (text.isEmpty) return;

    // Add user message to chat list
    _addMessage(text, isCurrentUser: true);

    // Clear the text field
    _controller.clear();

    // Call the chatbot API
    final response = await _callChatbotAPI(text);

    // Add bot response to chat list
    if (response != null) {
      _addMessage(response);
    }
  }

  Future<String?> _callChatbotAPI(String text) async {
    final msg = prompt + text;
    final content = Content.text(msg);
    final response = await model.generateContent([content]);
    return response.text;
  }

  final List<Map<String, dynamic>> _chatMessages = [];

  void _addMessage(String text, {bool isCurrentUser = false}) {
    setState(() {
      _chatMessages.add({
        'text': text,
        'isCurrentUser': isCurrentUser,
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
