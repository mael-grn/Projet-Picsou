import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projet_picsou/views/friends_view.dart';
import 'package:projet_picsou/views/home_view.dart';
import 'package:projet_picsou/views/me_view.dart';
import 'package:projet_picsou/views/money_view.dart';
import 'package:vibration/vibration.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PICSOU',
      debugShowCheckedModeBanner: false,
      home: const GlobalLayout(),
      theme: appTheme,
    );
  }
}

class GlobalLayout extends StatefulWidget {
  const GlobalLayout({super.key});

  @override
  _GlobalLayoutState createState() => _GlobalLayoutState();
}

class _GlobalLayoutState extends State<GlobalLayout>
    with SingleTickerProviderStateMixin {
  int currentPageIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Widget> _pages = [
    const HomeView(),
    const MoneyView(),
    const FriendsView(),
    const MeView(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);
  }

  void _onItemTapped(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _animation = Tween<double>(
        begin: currentPageIndex.toDouble(),
        end: index.toDouble(),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
      currentPageIndex = index;
      _controller.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: currentPageIndex, children: _pages),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Positioned(
                            left: (_animation.value * 70.0 +10),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: foregroundVariantColor,
                              ),
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNavItem('icons/home.svg', 0),
                          _buildNavItem('icons/money.svg', 1),
                          _buildNavItem('icons/friends.svg', 2),
                          _buildNavItem('icons/user.svg', 3),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]
      )
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
