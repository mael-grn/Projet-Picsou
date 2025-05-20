import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_picsou/views/friends_view.dart';
import 'package:projet_picsou/views/home_view.dart';
import 'package:projet_picsou/views/me_view.dart';
import 'package:projet_picsou/views/money_view.dart';

import '../core/theme/app_theme.dart';

class GlobalLayout extends StatefulWidget {
  const GlobalLayout({super.key});

  @override
  _GlobalLayoutState createState() => _GlobalLayoutState();
}

class _GlobalLayoutState extends State<GlobalLayout> {
  int currentPageIndex = 0;
  late PageController _pageController;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPageIndex);
    _pages = const [
      HomeView(key: PageStorageKey('HomeView')),
      MoneyView(key: PageStorageKey('MoneyView')),
      FriendsView(key: PageStorageKey('FriendsView')),
      MeView(key: PageStorageKey('MeView')),
    ];
  }

  void _onItemTapped(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      currentPageIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          children: _pages,
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 25.0),
              height: 70,
              child: Center(
                child: Container(
                  width: 280,
                  height: 70,
                  decoration: BoxDecoration(
                    color: foregroundColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem('icons/home.svg', 0),
                      _buildNavItem('icons/money.svg', 1),
                      _buildNavItem('icons/friends.svg', 2),
                      _buildNavItem('icons/user.svg', 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNavItem(String assetPath, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SvgPicture.asset(
          assetPath,
          width: 30,
          height: 30,
          colorFilter: ColorFilter.mode(
            index == currentPageIndex ? backgroundColor : secondaryColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}