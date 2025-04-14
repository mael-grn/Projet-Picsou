import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/controllers/home_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/widgets/conversation/conversation_button_list_widget.dart';
import 'package:projet_picsou/widgets/ui/fast_popup_widget.dart';
import 'package:provider/provider.dart';
import '../widgets/ui/popup_widget.dart';

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
    controller.initAnimations(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getUserBalance();
      controller.getCurrentUser();
      controller.animationsController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Nécessaire pour AutomaticKeepAliveClientMixin
    final homeController = context.watch<HomeController>();

    return Stack(
      children: [
        Container(
          color: primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                   Padding(
                    padding: EdgeInsets.fromLTRB(15, 75, 15, 20),
                    child: Text(
                      'Bonjour, ${homeController.currentUser?.firstName ?? 'Utilisateur'}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SlideTransition(
                  position: homeController.firstOffsetAnimation,
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
                          child: homeController.isLoading ?
                            LoadingAnimationWidget.inkDrop(
                              color: foregroundColor,
                              size: 30,
                            ) :
                          Text(
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 40,
                                  color: foregroundColor
                              ),
                              homeController.userBalance > 0 ? '+ ${homeController.userBalance} €' : '- ${homeController.userBalance} €'
                          )
                        ),
                        Expanded(
                          child: SlideTransition(
                            position: homeController.secondOffsetAnimation,
                            child: ConversationButtonListWidget(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        FastPopupWidget(
          show: homeController.showPopup,
          title: homeController.popupTitle ?? "",
          content: homeController.popupContent ?? "",
          imageSrc: homeController.popupImage,
          onClosePressed: () {
            homeController.closePopup();
          }
        ),
      ],
    );
  }
}
