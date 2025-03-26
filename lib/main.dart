import 'package:flutter/material.dart';
import 'package:projet_picsou/views/friends_view.dart';
import 'package:projet_picsou/views/home_view.dart';
import 'package:projet_picsou/views/me_view.dart';
import 'package:projet_picsou/views/money_view.dart';
import 'core/theme/app_theme.dart';
void main() {
  runApp(MyApp());
}

///Creating the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PICSOU',
      debugShowCheckedModeBanner: false,
      home: GlobalLayout(),
      theme: appTheme,
    );
  }
}

/// The GlobalLayout is the main widget containing the main pages and the navigation bar.
/// It handles the state of the navigation bar and the current page.
class GlobalLayout extends StatefulWidget {
  const GlobalLayout({super.key});

  @override
  _GlobalLayoutState createState() => _GlobalLayoutState();
}

class _GlobalLayoutState extends State<GlobalLayout> {

  // The current page's index
  int currentPageIndex = 0;

  // All the pages accessible with the navigation bar
  final List<Widget> _pages = [
    HomeView(),
    MoneyView(),
    FriendsView(),
    MeView(),
  ];

  @override
  Widget build(BuildContext context) {

    ///Main widget of the application.
    return Scaffold(

      appBar: AppBar(
        title: const Text('Picsou'),
        backgroundColor: primaryColor,
        foregroundColor: backgroundColor,
      ),

      ///IndexedStack shows the current page. It also avoids creating a new instance of each widget,
      ///therefore the state of each widget is preserved.
      body: IndexedStack(
        index: currentPageIndex,
        children: _pages,
      ),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: darkColor,
        backgroundColor: backgroundColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.monetization_on),
            label: 'Argent',
          ),
          NavigationDestination(
            icon: Icon(Icons.people),
            label: 'Amis',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Moi',
          ),
        ],
      ),
    );
  }
}