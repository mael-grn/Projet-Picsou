import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/controllers/friends_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:provider/provider.dart';
import '../controllers/me_controller.dart';
import 'edit_personal_data_view.dart';

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
      controller.initUser();
      controller.initFriends();
      controller.animationsController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = context.watch<FriendsController>();

    if (controller.user == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(top: 100),
          decoration: BoxDecoration(color: primaryColor),
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                "Mes amis",
                overflow: TextOverflow.ellipsis, // Ajout de l'overflow
                maxLines: 1, // Limite à une seule ligne
              ),
              SizedBox(height: 30),
              Expanded(
                child: SlideTransition(
                  position: controller.offsetAnimation,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: backgroundColor,
                    ),
                    child:
                        controller.isLoading
                            ? Center(
                              child: LoadingAnimationWidget.inkDrop(
                                color: foregroundColor,
                                size: 20,
                              ),
                            )
                            : controller.friends.isEmpty
                            ? Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    height: 200,
                                    width: 200,
                                    "images/alone.png",
                                  ),
                                  Text(
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                      "Vous n'avez pas encore d'amis"
                                  ),
                                  Text("Commencez à en rechercher à partir de leurs email.")
                                ],
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
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
