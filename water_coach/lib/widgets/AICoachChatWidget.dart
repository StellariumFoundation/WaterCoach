import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'MessageBubble.dart'; // Corrected import path

class AICoachChatWidget extends StatefulWidget {
  const AICoachChatWidget({super.key});

  @override
  State<AICoachChatWidget> createState() => _AICoachChatWidgetState();
}

enum STTState { idle, listening, processing, error }

class _AICoachChatWidgetState extends State<AICoachChatWidget> {
  final TextEditingController _textController = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  STTState _sttState = STTState.idle;

  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hello! How can I help you today?', 'isUserMessage': false},
    {'text': 'Hi there! I have a question about my workout plan.', 'isUserMessage': true},
    {'text': 'Sure, ask away!', 'isUserMessage': false},
  ];

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _textController.text,
          'isUserMessage': true,
        });
      });
      _textController.clear();
      // Here you would typically also send the message to the AI
      // and add its response to the _messages list.
      // For now, we'll simulate an AI response after a short delay.
      Future.delayed(const Duration(milliseconds: 500), () {
        final aiResponse = 'Thanks for your message! I am processing it. This is a spoken response.';
        setState(() {
          _messages.add({
            'text': aiResponse,
            'isUserMessage': false,
          });
        });
        _speak(aiResponse);
      });
    }
  }

  Future<void> _speak(String text) async {
    // iOS specific configuration for audio session
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      await _flutterTts.setSharedInstance(true);
      await _flutterTts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.ambient,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers,
          ],
          IosTextToSpeechAudioMode.voicePrompt);
    }

    // Basic TTS setup - can be expanded with more configurations
    await _flutterTts.setLanguage("en-US"); // Example: set language
    await _flutterTts.setPitch(1.0); // Default is 1.0
    await _flutterTts.setSpeechRate(0.5); // Default is 0.5 for normal speed
    await _flutterTts.speak(text);
  }

  void _listen() async {
    if (_sttState == STTState.listening) {
      _speech.stop();
      setState(() => _sttState = STTState.idle); // Or processing if there's a noticeable delay
      return;
    }

    // Reset to idle if in error state before attempting to listen again
    if (_sttState == STTState.error) {
      setState(() => _sttState = STTState.idle);
    }

    var status = await Permission.microphone.status;
      if (status.isDenied || status.isRestricted || status.isLimited) {
        status = await Permission.microphone.request();
      }

      if (status.isPermanentlyDenied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Microphone permission is permanently denied. Please enable it in app settings.'),
            ),
          );
        }
        setState(() => _sttState = STTState.error);
        return;
      }

      if (status.isGranted) {
        setState(() => _sttState = STTState.processing); // Indicate initialization
        bool available = await _speech.initialize(
          onStatus: (val) {
            print('onStatus: $val');
            if (val == stt.SpeechToText.listeningStatus) {
              if (mounted) setState(() => _sttState = STTState.listening);
            } else if (val == stt.SpeechToText.doneStatus || val == "notListening") {
              // Check if _textController is empty after listening is done
              if (_textController.text.isEmpty && _sttState == STTState.listening) {
                 if (mounted) setState(() => _sttState = STTState.error); // Or a specific 'no_input' state
                 print("No speech input detected or result is empty.");
              } else {
                if (mounted) setState(() => _sttState = STTState.idle);
              }
            }
          },
          onError: (val) {
            print('onError: $val');
            if (mounted) setState(() => _sttState = STTState.error);
          },
        );

        if (available) {
          // Note: onStatus will set it to listening. If initialize is fast, processing might not be seen.
          _speech.listen(
            onResult: (val) {
              if (mounted) {
                setState(() {
                  _textController.text = val.recognizedWords;
                  // Optionally, move to processing or idle based on finality of result
                  // if (val.finalResult) setState(() => _sttState = STTState.idle);
                });
              }
            },
            // consider listenFor, partialResults, cancelOnError, etc.
          );
        } else {
          print("The user has denied the use of speech recognition or an error occurred during initialization.");
          if (mounted) setState(() => _sttState = STTState.error);
        }
      } else {
        print("Microphone permission was not granted.");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Microphone permission denied.')),
          );
          setState(() => _sttState = STTState.error);
        }
      }
    }
    // No 'else' block for stopping, as tapping when listening is handled at the start of the method.
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return MessageBubble(
                text: message['text'] as String,
                isUserMessage: message['isUserMessage'] as bool,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: "Type your message here...",
                  ),
                  onSubmitted: (value) => _sendMessage(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: (_sttState == STTState.processing || _sttState == STTState.listening)
                    ? null // Disable send button while listening/processing speech
                    : _sendMessage,
              ),
              if (_sttState == STTState.listening || _sttState == STTState.processing || _sttState == STTState.error)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    _sttState == STTState.listening
                        ? "Listening..."
                        : _sttState == STTState.processing
                            ? "Processing..."
                            : "Error",
                    style: TextStyle(
                        color: _sttState == STTState.error
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.primary,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              IconButton(
                icon: Icon(
                  _sttState == STTState.listening
                      ? Icons.mic_off
                      : _sttState == STTState.processing
                          ? Icons.hourglass_top // Or a CircularProgressIndicator if handled differently
                          : _sttState == STTState.error
                              ? Icons.error_outline
                              : Icons.mic,
                ),
                color: _sttState == STTState.listening
                    ? Theme.of(context).colorScheme.error // Active listening color
                    : _sttState == STTState.error
                        ? Theme.of(context).colorScheme.error // Error color
                        : Theme.of(context).iconTheme.color, // Default color
                // Disable button while processing, allow tap to stop if listening, allow tap to retry if error or idle
                onPressed: (_sttState == STTState.processing && !_speech.isAvailable) ? null : _listen,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
