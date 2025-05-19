import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/friends_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

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

    return Container(
      color: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 75, 15, 20),
                child: Text(
                  'Mes amis',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                ),
              ),
            ],
          ),
          Expanded(
            child: SlideTransition(
              position: controller.firstOffsetAnimation,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: backgroundVariantColor,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                      child: Text("aaa"),
                    ),
                    Expanded(
                      child: SlideTransition(
                        position: controller.secondOffsetAnimation,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: backgroundColor,
                          ),
                          child:
                              controller.friends.isEmpty
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
