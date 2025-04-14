import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/views/splash_screen_view.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:provider/provider.dart';

import '../controllers/me_controller.dart';
import '../models/user.dart';
import '../widgets/ui/popup.dart';

class MeView extends StatefulWidget {
  const MeView({super.key});

  @override
  _MeViewState createState() => _MeViewState();
}

class _MeViewState extends State<MeView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<MeController>(context, listen: false);
    controller.initAnimations(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.animationsController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final meController = context.watch<MeController>();

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(top: 100),
          decoration: BoxDecoration(color: backgroundVariantColor),
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                "${User.getCurrentUserInstance().firstName} ${User.getCurrentUserInstance().lastName}",
              ),
              SizedBox(height: 30),
              Expanded(
                child: SlideTransition(
                  position: meController.offsetAnimation,
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
                    child: Column(
                      children: [
                        ButtonWidget(
                          buttonBackgroundColor: Colors.redAccent,
                          textColor: foregroundColor,
                          message: "Déconnexion",
                            icon: Icons.logout,
                            onPressed: meController.logout
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        PopupWidget(
          show: meController.showPopup,
          title: meController.popupTitle ?? "",
          content: meController.popupContent ?? "",
          imageSrc: meController.popupImage,
          onClosePressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashScreenView()),
            );
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
