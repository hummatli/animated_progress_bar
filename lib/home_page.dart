import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progress_bar/ui_components/animated_progress_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const double stripeWidth = 20.0;
const double stripeSpacing = 20.0;

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool stopped1 = false;
  bool stopped2 = false;

  final random = Random();
  late double randomStop1;
  late double randomStop2;

  @override
  void initState() {
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 5))
      ..addListener(() {
        if (_controller.value >= randomStop1 && !stopped1) {
          _controller.stop();
          stopped1 = true;
          resumeProgress();
        } else if (_controller.value >= randomStop2 && !stopped2) {
          _controller.stop();
          stopped2 = true;
          resumeProgress();
        }
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void resumeProgress() {
    int randomPauseMilliseconds = random.nextInt(1000) + 1000;

    Future.delayed(Duration(milliseconds: randomPauseMilliseconds), () {
      _controller.forward(from: _controller.value);
    });
  }

  void startProgress() {
    randomStop1 = random.nextDouble();
    do {
      randomStop2 = random.nextDouble();
    } while (randomStop1 == randomStop2);

    stopped1 = false;
    stopped2 = false;

    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    double progressBarWidth = MediaQuery.of(context).size.width * 0.9;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ProgressBar Simulation'),
        ),
        body: Center(
          child: SizedBox(
            width: progressBarWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedProgressIndicator(
                  width: progressBarWidth,
                  value: _controller.value,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text('Start'),
                  onPressed: () => startProgress(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
