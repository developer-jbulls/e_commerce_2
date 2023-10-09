
import 'dart:math';

import 'package:e_commerce/cart_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData.dark(),
//       home: const OnboardingScreen(),
//     );
//   }
// }

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  bool showDoneButton = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page?.round() ?? 0;
        showDoneButton = _currentIndex == 2;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF26262F),
                  Color(0xFF1F1F26)
                ], // Define your gradient colors here
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          CustomPaint(
            painter: ArcPainter(),
            child: SizedBox(
              child: Image.asset('assets/images/orange.png'),
              height: screenSize.height / 1.3,
              width: screenSize.width,
            ),
          ),
          Positioned(
            top: 150,
            right: 5,
            left: 5,
            child: Lottie.asset(
              tabs[_currentIndex].lottieFile,
              key: Key('${Random().nextInt(999999999)}'),
              width: 600,
              alignment: Alignment.topCenter,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 270,
              child: Column(
                children: [
                  Flexible(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: tabs.length,
                      itemBuilder: (BuildContext context, int index) {
                        OnboardingModel tab = tabs[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tab.title,
                              style: const TextStyle(
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 50),
                            Text(
                              tab.subtitle,
                              style: const TextStyle(
                                fontSize: 17.0,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        );
                      },
                      onPageChanged: (value) {
                        setState(() {
                          _currentIndex = value;
                          showDoneButton = _currentIndex == 2;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int index = 0; index < tabs.length; index++)
                        _DotIndicator(isSelected: index == _currentIndex),
                    ],
                  ),
                  if (showDoneButton) // Show the "Done" button on index 2
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the next screen when "Done" button is tapped
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                        );
                      },
                      child: Text("Done"),
                    ),
                  const SizedBox(height: 75)
                ],
              ),

            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentIndex == 2) {
            _pageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          }
        },
        child: const Icon(
          CupertinoIcons.chevron_right,
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path orangeArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 170)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 170)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    // canvas.drawPath(orangeArc, Paint()..color = Colors.orange);
    //
    Path whiteArc = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, size.height - 185)
      ..quadraticBezierTo(
          size.width / 2, size.height - 70, size.width, size.height - 185)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(whiteArc, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _DotIndicator extends StatelessWidget {
  final bool isSelected;

  const _DotIndicator({Key? key, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 6.0,
        width: 6.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white : Colors.white38,
        ),
      ),
    );
  }
}

class OnboardingModel {
  final String lottieFile;
  final String title;
  final String subtitle;

  OnboardingModel(this.lottieFile, this.title, this.subtitle);
}

List<OnboardingModel> tabs = [
  OnboardingModel(
    'assets/lotty_files/launch_pad.json',
    'Choose A Tasty',
    'When you order Eat Street , \nwe\'ll hook you up with exclusive \ncoupons.',
  ),
  OnboardingModel(
    'assets/lotty_files/basketball_sport.json',
    'Discover Places',
    'We make it simple to find the \nfood you crave. Enter your \naddress and let',
  ),
  OnboardingModel(
    'assets/lotty_files/calender_event_management.json',
    'Pick Up Or',
    'We make food ordering fast ,\n simple and free - no matter if you \norder',
  ),
];
