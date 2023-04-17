import 'dart:async';
import 'package:flutter/material.dart';
import 'package:progress_bar/ui_components/animated_stripes_painter.dart';

class AnimatedProgressIndicator extends StatefulWidget {
  final double width;
  final double value;

  const AnimatedProgressIndicator({
    Key? key,
    required this.width,
    required this.value,
  }) : super(key: key);

  @override
  State<AnimatedProgressIndicator> createState() =>
      _AnimatedProgressIndicatorState();
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator> {
  Timer? _timer;
  double _offset = 0.0;

  final double speed = 0.2;
  final double stripeWidth = 5.0;
  final double stripeSpacing = 5.0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        _offset = (_offset + speed) % (stripeWidth + stripeSpacing);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        height: 26,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              width: double.infinity,
              color: Colors.blue,
            ),
            Container(
              width: double.infinity,
              child: CustomPaint(
                painter: AnimatedStripesPainter(
                    offset: _offset,
                    stripeWidth: stripeWidth,
                    stripeSpacing: stripeSpacing),
                child: Container(
                  width: double.infinity,
                ),
              ),
            ),
            Container(
              width: widget.width - widget.value * widget.width,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
