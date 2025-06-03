import 'dart:async'; // For Future.delayed
import 'dart:collection'; // For Queue
import 'dart:math'; // For Random

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
enum TTSState { idle, speaking, error }

class _AICoachChatWidgetState extends State<AICoachChatWidget> {
  final TextEditingController _textController = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  STTState _sttState = STTState.idle;
  TTSState _ttsState = TTSState.idle;
  final Queue<String> _ttsQueue = Queue<String>();
  bool _isWaitingForAI = false;

  // Placeholder for AI backend interaction
  Future<String> _sendToAiBackend(String userInput) async {
    print("Sending to AI Backend: $userInput");
    await Future.delayed(Duration(seconds: 1 + Random().nextInt(2))); // Simulate network delay 1-2 seconds

    // Simulate occasional errors
    if (Random().nextInt(5) == 0) { // 1 in 5 chance of error
      throw Exception("Simulated AI Backend Error: Could not connect.");
    }

    return "AI: You said '$userInput'. Thanks for sharing!";
  }

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() {
    _flutterTts.setStartHandler(() {
      if (mounted) setState(() => _ttsState = TTSState.speaking);
    });

    _flutterTts.setCompletionHandler(() {
      if (mounted) setState(() => _ttsState = TTSState.idle);
      _processMessageQueue();
    });

    _flutterTts.setErrorHandler((msg) {
      if (mounted) setState(() => _ttsState = TTSState.error);
      print("TTS Error: $msg");
      _processMessageQueue(); // Try to process next message even if current one errors
    });
  }

  final List<Map<String, dynamic>> _messages = [
    // Initial messages can be kept or removed if AI interaction starts immediately
    // {'text': 'Hello! How can I help you today?', 'isUserMessage': false},
  ];

  void _sendMessage() async {
    if (_textController.text.isEmpty) return;

    final userInput = _textController.text;
    _textController.clear();

    // Add user message to UI
    setState(() {
      _messages.add({'text': userInput, 'isUserMessage': true});
      _isWaitingForAI = true;
    });

    try {
      final aiResponseText = await _sendToAiBackend(userInput);
      if (mounted) {
        setState(() {
          _messages.add({'text': aiResponseText, 'isUserMessage': false});
        });
        _speak(aiResponseText);
      }
    } catch (e) {
      print("Error from AI Backend: $e");
      final errorMessage = "Error: Could not connect to AI. Please try again.";
      if (mounted) {
        setState(() {
          _messages.add({'text': errorMessage, 'isUserMessage': false, 'isError': true});
        });
        _speak(errorMessage);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isWaitingForAI = false;
        });
      }
    }
  }

  void _speak(String text) {
    if (text.trim().isEmpty) return;
    _ttsQueue.add(text);
    _processMessageQueue();
  }

  Future<void> _processMessageQueue() async {
    if (_ttsState == TTSState.speaking || _ttsQueue.isEmpty) {
      return;
    }

    // Reset error state before attempting to speak again
    if (_ttsState == TTSState.error) {
       if (mounted) setState(() => _ttsState = TTSState.idle);
    }

    final String textToSpeak = _ttsQueue.removeFirst();

    // TTS parameters - can be made configurable
    const String language = "en-US";
    const double speechRate = 0.5; // 0.0 to 1.0, 0.5 is normal
    const double pitch = 1.0;      // 0.5 to 2.0, 1.0 is normal

    try {
      // iOS specific configuration for audio session - ensure this is safe to call multiple times
      // or move to a one-time setup if possible and preferred.
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        await _flutterTts.setSharedInstance(true); // Safe to call multiple times
        await _flutterTts.setIosAudioCategory( // Safe to call multiple times
            IosTextToSpeechAudioCategory.ambient,
            [
              IosTextToSpeechAudioCategoryOptions.allowBluetooth,
              IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
              IosTextToSpeechAudioCategoryOptions.mixWithOthers,
            ],
            IosTextToSpeechAudioMode.voicePrompt);
      }

      await _flutterTts.setLanguage(language);
      await _flutterTts.setSpeechRate(speechRate);
      await _flutterTts.setPitch(pitch);

      // awaitSpeakCompletion is not needed here as handlers manage state and queue.
      // Direct call to speak. setStartHandler will set state to speaking.
      await _flutterTts.speak(textToSpeak);

    } catch (e) {
      print("Error occurred in _processMessageQueue: $e");
      if (mounted) setState(() { _ttsState = TTSState.error; });
      _processMessageQueue(); // Attempt to process next item in queue even if this one failed
    }
  }

  @override
  void dispose() {
    _speech.stop();
    _flutterTts.stop(); // Stop TTS and clear handlers if necessary
    super.dispose();
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
                  onSubmitted: (_isWaitingForAI || (_sttState != STTState.idle && _sttState != STTState.error)) ? null : (value) => _sendMessage(),
                  enabled: !(_isWaitingForAI || (_sttState != STTState.idle && _sttState != STTState.error)),
                ),
              ),
              _isWaitingForAI
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2.0)),
                    )
                  : IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: (_sttState == STTState.processing || _sttState == STTState.listening || _isWaitingForAI)
                          ? null
                          : _sendMessage,
                    ),
              if (!_isWaitingForAI && (_sttState == STTState.listening || _sttState == STTState.processing || _sttState == STTState.error))
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
                          ? Icons.hourglass_top
                          : _sttState == STTState.error
                              ? Icons.error_outline
                              : Icons.mic,
                ),
                color: _sttState == STTState.listening
                    ? Theme.of(context).colorScheme.error
                    : _sttState == STTState.error
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).iconTheme.color,
                onPressed: _isWaitingForAI ? null : ((_sttState == STTState.processing && !_speech.isAvailable) ? null : _listen),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
