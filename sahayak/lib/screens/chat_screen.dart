import 'package:flutter/material.dart';
import '../services/locale_service.dart';
import '../widgets/fade_in_wrapper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isListening = false;
  
  // Dummy messages for UI demonstration
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text': 'Namaskara! I am Sahayak. How can I help you with your class today?',
      'time': DateTime.now().subtract(const Duration(minutes: 5)),
    },
    {
      'isUser': true,
      'text': 'I have a student struggling with subtraction.',
      'time': DateTime.now().subtract(const Duration(minutes: 2)),
    },
    {
      'isUser': false,
      'text': 'I recommend the "Bundle and Sticks" activity. Would you like me to show you the instructions?',
      'time': DateTime.now(),
    },
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'isUser': true,
        'text': _controller.text,
        'time': DateTime.now(),
      });
      _controller.clear();
    });

    // Auto-scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // Simulate AI response delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'isUser': false,
            'text': 'I am just a demo for now, but soon I will answer using the Nali Kali corpus!',
            'time': DateTime.now(),
          });
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('chat_title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            onPressed: () {},
            tooltip: 'History',
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages Area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['isUser'];
                return FadeInWrapper(
                  child: Row(
                    mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isUser) ...[
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          child: Icon(Icons.smart_toy_rounded, size: 18, color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(child: _buildMessageBubble(message['text'], isUser, message['time'])),
                      if (isUser) ...[
                        const SizedBox(width: 8),
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person_rounded, size: 18, color: Colors.white),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),


          // Suggestion Chips (Sunita's Context)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildSuggestionChip('Class is chaotic!'),
                const SizedBox(width: 8),
                _buildSuggestionChip('Explain "Zero" concept'),
                const SizedBox(width: 8),
                _buildSuggestionChip('Fast finishers are bored'),
              ],
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -2),
                  blurRadius: 5,
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(_isListening ? Icons.graphic_eq_rounded : Icons.mic_rounded),
                    color: _isListening ? Colors.red : Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      setState(() => _isListening = true);
                      Future.delayed(const Duration(seconds: 2), () {
                        if (mounted) {
                          setState(() {
                             _isListening = false;
                             _controller.text = "How do I teach place value?";
                          });
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask a pedagogical question...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    mini: true,
                    onPressed: _sendMessage,
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser, DateTime time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isUser
            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
            : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(5),
          bottomRight: isUser ? const Radius.circular(5) : const Radius.circular(20),
        ),
        border: Border.all(
          color: isUser
              ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
              : Colors.grey[300]!,
        ),
        boxShadow: isUser
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                )
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(text, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary)),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () {
        _controller.text = text;
        _sendMessage();
      },
    );
  }
}
