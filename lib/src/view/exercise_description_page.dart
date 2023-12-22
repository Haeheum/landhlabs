import 'package:flutter/material.dart';

import 'exercise_page.dart';

class ExerciseDescriptionPage extends StatelessWidget {
  const ExerciseDescriptionPage({super.key});

  static const _exerciseDescriptionBody =
      '허벅지 근육을 골고루 자극하여 하체 체지방 제거에 도움을 주는 스쿼트 트위스트 동작입니다. 기존 스쿼트 동작에 상제의 움직임을 추가하여 더 많은 칼로리를 연소할 수 있는 동작입니다. 집에서 가볍게 할 수 있는 홈트 운동으로 가능한 범위 내에서 꾸준히 해주시면 좋습니다.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('맨손 근력운동'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Placeholder(
              fallbackHeight: 300,
              fallbackWidth: 500,
            ),
            const Text(
              '스쿼트 트위스트',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              _exerciseDescriptionBody,
            ),
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ExercisePage(),
                      ),
                    );
                  },
                  child: const Text(
                    '운동 시작하기',
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
}
