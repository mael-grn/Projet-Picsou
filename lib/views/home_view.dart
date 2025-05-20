import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/home_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/widgets/conversation/conversation_button_list_widget.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../widgets/ui/main_page_layout_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
    super.build(context); // Nécessaire pour AutomaticKeepAliveClientMixin
    final homeController = context.watch<HomeController>();


    return MainPageLayoutWidget(
      secondFloor: Text(
        'Bonjour, ${User.getCurrentUserInstance().firstName}',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 35,
        ),
      ),

      firstFloor: Text(
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 40,
              color: foregroundColor
          ),
          homeController.userBalance > 0 ? '+ ${homeController.userBalance} €' : '- ${homeController.userBalance} €'
      ),

      groundFloor: ConversationButtonListWidget()
    );
  }
}
