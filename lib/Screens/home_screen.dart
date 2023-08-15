import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:happy_birthday/Screens/message_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayer _audioPlayer;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  bool _isPlaying = false;
  bool _isVisible = false;
  bool _isMessage = false;
  late Timer _timer;
  int _start = 5;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            _isVisible = true;
            _isMessage = true;
            _audioPlayer.play(AssetSource('audios/birthday_song.mp3'));
            _controllerCenterRight.play();
            _controllerCenterLeft.play();
            timer.cancel();
          } else {
            _start = _start - 1;
            _audioPlayer.play(AssetSource('audios/countdown.wav'));
          }
        },
      ),
    );
  }
  void _startAnimation()  {
    if (!_isPlaying) {
      startTimer();
      setState(() {
        _isPlaying = true;
      });
    }
  }

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 15));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 15));
    super.initState();
  }
  @override
  void dispose() {
    _timer.cancel();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _audioPlayer.dispose(); // Dispose the audio player
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const SizedBox(
        height: 50,
        child: BottomAppBar(
          color: Colors.pinkAccent,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: (){
          _startAnimation();
        },
        backgroundColor: const Color(0xFF13195b),
        child: const Icon(Icons.play_circle_outline_outlined,color: Colors.white,size: 50,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,// This trailing comma makes auto-formatting nicer for build methods.
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: 220,
              //  color: Colors.pinkAccent,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/birthday.jpg"),fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right:16.0),
            child: Align(
                alignment: Alignment.topCenter,
                child: Visibility(
                  visible: !_isVisible,
                    child: Text("$_start",style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 50),))),
          ),
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: ConfettiWidget(
                  confettiController: _controllerCenterRight,
                  blastDirection: pi, // radial value - LEFT
                  particleDrag: 0.05, // apply drag to the confetti
                  emissionFrequency: 0.05, // how often it should emit
                  numberOfParticles: 20, // number of particles to emit
                  gravity: 0.05, // gravity - or fall speed
                  shouldLoop: false,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink
                  ], // manually specify the colors to be used
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ConfettiWidget(
                  confettiController: _controllerCenterLeft,
                  blastDirection: 0, // radial value - RIGHT
                  emissionFrequency: 0.6,
                  minimumSize: const Size(10,
                      10), // set the minimum potential size for the confetti (width, height)
                  maximumSize: const Size(50,
                      50), // set the maximum potential size for the confetti (width, height)
                  numberOfParticles: 1,
                  gravity: 0.1,
                ),
              ),
               Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10), // Add some space between the text
                          Visibility(
                            visible: _isVisible,
                            child: const Text(
                              "Happy Birthday 🎂",
                              style: TextStyle(
                                color: Color(0xff13195b),
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Satisfy',
                                fontSize: 30,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(height: 10), // Add more space between text and person's name
                          Visibility(
                            visible: _isVisible,
                            child: const Text(
                              "[Name]", // Replace with the actual person's name
                              style: TextStyle(
                                color: Color(0xff13195b),
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: _isMessage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  const MessageScreen()),
                      );
                    },
                    backgroundColor: const Color(0xFF13195b),
                    child: const Icon(Icons.message,color: Colors.white,size: 50,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


