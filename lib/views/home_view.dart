import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/home_controller.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../widgets/ui/main_page_layout_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<HomeController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getUserBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeController = context.watch<HomeController>();


    return MainPageLayoutWidget(
      title: Text(
        'Bonjour, ${User.getCurrentUserInstance().firstName}',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 35,
        ),
      ),

      intermediate: Text("Rien"),
      body: Text("Toujours rien"),
    );
  }
}
