import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/friends_controller.dart';
import 'package:provider/provider.dart';

import '../widgets/ui/main_page_layout_widget.dart';

class FriendsView extends StatefulWidget {
  const FriendsView({super.key});

  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    final controller = Provider.of<FriendsController>(context, listen: false);
    controller.initAnimations(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initFriends();
      controller.animationsController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = context.watch<FriendsController>();

    return MainPageLayoutWidget(
      secondFloor: Row(
        children: [
          Text(
            'Mes amis',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
          ),
        ],
      ),

      firstFloor: Text("aaa"),

      groundFloor: controller.friends.isEmpty
          ? Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                width: 250,
                "images/alone.png",
              ),
              SizedBox(height: 20),
              Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                "Vous n'avez pas encore d'amis",
              ),
              SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                "Commencez à en rechercher à partir de leurs email.",
              ),
            ],
          ),
        ),
      )
          : SingleChildScrollView(
        child: Column(children: []),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
