import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/home/home_controller.dart';
import 'package:projet_picsou/widgets/groups/groupe_list_item_widget.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:provider/provider.dart';
import '../../core/custom_navigator.dart';
import '../../models/user.dart';
import '../../widgets/ui/main_page_layout_widget.dart';
import 'create_group_view.dart';

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
      controller.initData();
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

      intermediate: ButtonWidget(
        tag: "create_group",
          message: "Créer un groupe",
          icon: Icons.add,
          onPressed: () => CustomNavigator.pushFromRight(CreateGroupView())
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            ...homeController.groups
                .map((group) => GroupeListItemWidget(group: group))
          ],
        ),
      ),
    );
  }
}
