import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Screens/front_page.dart';
import '../Screens/features_description.dart';
import '../Screens/welcome.dart';

class PageViewDemo extends StatefulWidget {
  const PageViewDemo({Key? key}) : super(key: key);
  @override
  State<PageViewDemo> createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 0;
  final List<Widget> _pages = [
    const Home(),
    const Preview(),
    const Welcome(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
          ),
          Positioned(
              bottom: 0,
              right: MediaQuery.of(context).size.width * 0.43,
              height: MediaQuery.of(context).size.height * 0.1,
              child: SmoothPageIndicator(
                  controller: _pageController, // PageController
                  count: 3,
                  effect: const WormEffect(
                    spacing: 8.0,
                    activeDotColor: Color(0xff1A2A3A),
                  ),
                  onDotClicked: (index) {})),
        ],
      ),
    );
  }
}
