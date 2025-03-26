import 'package:flutter/material.dart';
import 'package:projet_picsou/views/friends_view.dart';
import 'package:projet_picsou/views/home_view.dart';
import 'package:projet_picsou/views/me_view.dart';
import 'package:projet_picsou/views/money_view.dart';
import 'core/theme/app_theme.dart';
void main() {
  runApp(MyApp());
}

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

class GlobalLayout extends StatefulWidget {
  const GlobalLayout({super.key});

  @override
  _GlobalLayoutState createState() => _GlobalLayoutState();
}

class _GlobalLayoutState extends State<GlobalLayout> {

  // Index de la page courante
  int currentPageIndex = 0;

  // Liste des pages
  final List<Widget> _pages = [
    HomeView(),
    MoneyView(),
    FriendsView(),
    MeView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Picsou'),
        backgroundColor: primaryColor,
        foregroundColor: backgroundColor,
      ),

      // IndexedStack pour afficher la page courante. Il permet aussi d'éviter de créer
      // une nouvelle instance de chaque widget, ainsi l'état de chaque widget est conservé.
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