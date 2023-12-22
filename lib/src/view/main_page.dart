import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'exercise_description_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _controller = PageController(viewportFraction: 0.7);
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 24),
            RichText(
              text: const TextSpan(
                text: '블루투스 연결상태',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' 양호',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        leadingWidth: double.infinity,
        backgroundColor: Colors.grey,
        actions: const [
          Icon(Icons.keyboard_arrow_right),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 36, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '길동님,\n건강뉴스가 도착했어요.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 460,
                    child: PageView(
                      controller: _controller,
                      children: [
                        _pageViewItem(
                          title: '실내에서 하는\n근력 강화 운동',
                          onClicked: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ExerciseDescriptionPage(),
                              ),
                            );
                          },
                        ),
                        _pageViewItem(
                          title: '여름철\n효과적인 운동',
                          onClicked: () {},
                        ),
                        _pageViewItem(
                          title: '이성과 함께\n커플 운동',
                          onClicked: (_) {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: const WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      dotColor: Color(0xFFB4B1B1),
                      activeDotColor: Color(0xFF3D3D3F),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 2,
            thickness: 2,
            color: Colors.grey,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_box_outlined),
            selectedIcon: Icon(Icons.check_box_rounded),
            label: '평가',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.heart),
            selectedIcon: Icon(CupertinoIcons.heart_fill),
            label: '운동',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_box_outlined),
            selectedIcon: Icon(Icons.account_box),
            label: '기록',
          ),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _pageViewItem({required String title, required Function onClicked}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          onClicked();
        },
        child: Stack(
          children: [
            Container(
              height: 460,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Positioned(
              left: 24,
              top: 24,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
