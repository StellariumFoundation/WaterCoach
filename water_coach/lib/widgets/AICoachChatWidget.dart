import 'package:flutter/material.dart';

class AICoachChatWidget extends StatefulWidget {
  const AICoachChatWidget({super.key});

  @override
  State<AICoachChatWidget> createState() => _AICoachChatWidgetState();
}

class _AICoachChatWidgetState extends State<AICoachChatWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Minimal AICoachChatWidget'),
      ),
    );
  }
}
