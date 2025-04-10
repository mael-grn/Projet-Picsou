import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/views/splash_screen_view.dart';
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
  late AnimationController _animationController;
  late Animation<Offset> _introAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _introAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.decelerate),
    );

    _animationController.forward();
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
                  position: _introAnimation,
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
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(foregroundVariantColor),
                            foregroundColor: WidgetStatePropertyAll<Color>(backgroundColor),
                          ),
                          onPressed: meController.logout,
                          child: Text("Déconnexion"),
                        ),
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
