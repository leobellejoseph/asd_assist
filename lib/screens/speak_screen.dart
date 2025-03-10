import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:text_to_speech/text_to_speech.dart';

class SpeakScreen extends StatefulWidget {
  const SpeakScreen({super.key});

  @override
  State<SpeakScreen> createState() => _SpeakScreenState();
}

class _SpeakScreenState extends State<SpeakScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Type text to speak', style: TextStyle(color: Colors.blueGrey))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  autocorrect: false,

                  controller: _controller,
                  maxLines: 20,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              OutlinedButton(
                onPressed: () async {
                  final text = _controller.text;
                  if (text.isEmpty) return;
                  final tts = TextToSpeech();
                  final language = 'en-US';
                  tts.setLanguage(language);
                  tts.speak(text);
                  _controller.clear();
                },
                child: Lottie.asset('assets/speak_bar.json'),
              ),
              // IconButton(
              //   onPressed: () async {
              //     final tts = TextToSpeech();
              //     final language = 'en-US';
              //     tts.setLanguage(language);
              //     tts.speak(_controller.text);
              //   },
              //   icon: Icon(FontAwesomeIcons.teamspeak, size: 50, color: Colors.blueAccent),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}