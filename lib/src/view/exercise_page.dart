import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final ValueNotifier<int> _leftTimeInSeconds = ValueNotifier(360);
  late Timer _countDownTimer;

  _startTimer() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _countDown();
      });
    });
  }

  _countDown() {
    if (_leftTimeInSeconds.value > 0) {
      _leftTimeInSeconds.value -= 1;
    } else {
      _countDownTimer.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _countDownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text('6분 걷기'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Placeholder(
              fallbackHeight: 300,
              fallbackWidth: 500,
            ),
            const Spacer(),
            Chip(
              backgroundColor: const Color(0xFF101010),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              label: const Text(
                '평가중',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            ValueListenableBuilder(
                valueListenable: _leftTimeInSeconds,
                builder: (_, count, ___) {
                  return Text(
                    _formatSeconds(count),
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  );
                }),
            const Spacer(),
            _userStatus(userStatus: UserStatus.heartRate, value: 126),
            _userStatus(userStatus: UserStatus.stress, value: 56),
            const Spacer(),
            Center(
              child: SizedBox(
                height: 48,
                width: 500,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.redAccent),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '종료',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userStatus({required UserStatus userStatus, required int value}) {
    return Container(
      height: 48,
      width: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color(0xFF969696),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 18),
          Text(
            userStatus.title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            '${value.toString()} ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(userStatus.unit),
          const SizedBox(width: 18),
        ],
      ),
    );
  }

  String _formatSeconds(int seconds) {
    int minutes = (seconds / 60).truncate();
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }
}

enum UserStatus {
  heartRate(title: '심박수', unit: 'bpm'),
  stress(title: '스트레스', unit: '');

  const UserStatus({
    required this.title,
    required this.unit,
  });

  final String title;
  final String unit;
}
