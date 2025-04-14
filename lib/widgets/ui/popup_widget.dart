import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';

class PopupWidget extends StatefulWidget {
  final bool show;
  final Function? onClosePressed;
  final bool showCloseButton;
  final List<Widget> children;

  const PopupWidget({
    required this.show,
    this.onClosePressed,
    required this.children,
    this.showCloseButton = true,
    super.key,
  });

  @override
  State<PopupWidget> createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget>
    with TickerProviderStateMixin {
  late AnimationController _popupController;
  late Animation<Offset> _popupAnimation;
  bool _isVisibleInTree = false;

  @override
  void initState() {
    super.initState();

    _popupController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _popupAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _popupController, curve: Curves.decelerate),
    );

    // Démarrer l'animation et marquer comme visible si show est true
    if (widget.show) {
      _isVisibleInTree = true;
      _popupController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant PopupWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show && !oldWidget.show) {
      setState(() {
        _isVisibleInTree = true;
      });
      _popupController.forward();
    } else if (!widget.show && oldWidget.show) {
      _popupController.reverse().then((_) {
        if (!mounted) return;
        setState(() {
          _isVisibleInTree = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _popupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isVisibleInTree,
      child: Positioned.fill(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedOpacity(
                opacity: widget.show ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                child: Container(color: Color(0xC0000000)),
              ),
            ),

            SlideTransition(
              position: _popupAnimation,
              child: Container(
                margin: EdgeInsets.only(top: 100),
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: backgroundColor,
                ),

                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 100),
                            ...widget.children
                            ],
                        ),
                      )
                    ),

                    if (widget.showCloseButton)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CloseButton(
                                color: backgroundColor,
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    foregroundVariantColor,
                                  ),
                                  padding: WidgetStateProperty.all(
                                    EdgeInsets.all(10),
                                  ),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (widget.onClosePressed != null) {
                                    widget.onClosePressed!();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
