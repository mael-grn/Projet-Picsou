import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';

class PopupWidget extends StatefulWidget {
  final bool show;
  final Function onClosePressed;
  final String title;
  final String content;
  final String? imageSrc;

  const PopupWidget({
    required this.title,
    required this.content,
    required this.show,
    required this.onClosePressed,
    this.imageSrc,
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
      CurvedAnimation(parent: _popupController, curve: Curves.easeOutCubic),
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
                  child:Container(color: Color(0xC0000000))
              ),
            ),

            SlideTransition(
              position: _popupAnimation,
              child: Container(
                margin: EdgeInsets.only(top: 100),
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
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (widget.imageSrc != null)
                              Image.asset(
                                widget.imageSrc!,
                                width: double.infinity,
                                fit: BoxFit.contain,
                                height: 100,
                              ),
                            SizedBox(height: 20),
                            Text(
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                              widget.title,
                            ),
                            SizedBox(height: 10),
                            Text(
                              textAlign: TextAlign.center,
                                widget.content
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(20),
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
                                widget.onClosePressed();
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
