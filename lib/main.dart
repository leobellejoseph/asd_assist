import 'package:asd_assist/screens/speak_screen.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:text_to_speech/text_to_speech.dart';

void main(List<String> args) async {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final faker = Faker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saved Texts & Phrases')),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final word = faker.food.dish();
            return ListTile(
              isThreeLine: true,
              title: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black45),
                  image: DecorationImage(image: NetworkImage(faker.image.loremPicsum(random: index)), fit: BoxFit.fill),
                ),
                width: 100,
                height: 200,
              ),
              subtitle: Text(word, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              onTap: () async {
                final tts = TextToSpeech();
                final language = 'en-US';
                tts.setLanguage(language);
                tts.speak(word);
              },
            );
          },

          separatorBuilder: (context, index) {
            return Divider(thickness: 0.5, color: Colors.black54);
          },
          itemCount: 100,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SpeakScreen()));
        },
        child: Lottie.asset('assets/speak_bar.json'),
      ),
    );
  }

  // Future _speak() async {
  //   var result = await flutterTts.speak("Hello World");
  //   if (result == 1) setState(() => ttsState = TtsState.playing);
  // }
  //
  // Future _stop() async {
  //   var result = await flutterTts.stop();
  //   if (result == 1) setState(() => ttsState = TtsState.stopped);
  // }
}