import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_store_app/features/auth/data/models/timer_model.dart';

class CountdownClock extends StatefulWidget {
  final int countdownDuration;

  const CountdownClock({super.key, required this.countdownDuration});

  @override
  CountdownClockState createState() => CountdownClockState();
}

class CountdownClockState extends State<CountdownClock> {
  int remainingSeconds = 0;
  late Timer countdownTimer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }

  void startCountdown() {
    remainingSeconds = widget.countdownDuration;
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          countdownTimer.cancel();
        }
      });
    });
  }

  TimerModel formatDuration(int seconds) {
    int days = seconds ~/ (24 * 60 * 60);
    seconds -= days * (24 * 60 * 60);

    int hours = seconds ~/ (60 * 60);
    seconds -= hours * (60 * 60);

    int minutes = seconds ~/ 60;
    seconds -= minutes * 60;

    return TimerModel(days: days, hours: hours, minutes: minutes, seconds: seconds);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CustomNumberQuarter(number: formatDuration(remainingSeconds).days ?? 0),
        const Text(' : '),
        _CustomNumberQuarter(number: formatDuration(remainingSeconds).hours ?? 0),
        const Text(' : '),
        _CustomNumberQuarter(number: formatDuration(remainingSeconds).minutes ?? 0),
        const Text(' : '),
        _CustomNumberQuarter(number: formatDuration(remainingSeconds).seconds ?? 0),
      ],
    );
  }
}

class _CustomNumberQuarter extends StatelessWidget {
  const _CustomNumberQuarter({required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      height: 27,
      width: 27,
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(color: Colors.amber.shade700, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: textStyle.titleMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
