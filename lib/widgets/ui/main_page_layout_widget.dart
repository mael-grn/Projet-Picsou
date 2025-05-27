    import 'package:flutter/material.dart';
    import 'package:projet_picsou/core/theme/app_theme.dart';
    import '../animations/scale_animation_widget.dart';
    import '../animations/slide_up_animation_widget.dart';

    class MainPageLayoutWidget extends StatefulWidget {
      final Widget groundFloor;
      final Widget firstFloor;
      final Widget secondFloor;

      const MainPageLayoutWidget({
        super.key,
        required this.groundFloor,
        required this.firstFloor,
        required this.secondFloor,
      });

      @override
      State<MainPageLayoutWidget> createState() => _MainPageLayoutWidgetState();
    }

    class _MainPageLayoutWidgetState extends State<MainPageLayoutWidget> with TickerProviderStateMixin {
      final ScrollController _scrollController = ScrollController();
      double _opacity = 1.0;

      @override
      void initState() {
        super.initState();
        _scrollController.addListener(_onScroll);
      }

      void _onScroll() {
        double offset = _scrollController.offset;
        double fadeStart = 0;
        double fadeEnd = 80; // Ajuste la distance de disparition
        double newOpacity = 1.0;

        if (offset <= fadeStart) {
          newOpacity = 1.0;
        } else if (offset >= fadeEnd) {
          newOpacity = 0.0;
        } else {
          newOpacity = 1.0 - ((offset - fadeStart) / (fadeEnd - fadeStart));
        }

        if (newOpacity != _opacity) {
          setState(() {
            _opacity = newOpacity;
          });
        }
      }

      @override
      void dispose() {
        _scrollController.dispose();
        super.dispose();
      }

      @override
      Widget build(BuildContext context) {
        return Container(
          width: double.infinity,
          color: primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              AnimatedSize(
                duration: Duration(milliseconds: 250),
                curve: Curves.ease,
                alignment: Alignment.topCenter,
                child: _opacity > 0
                    ? AnimatedOpacity(
                        opacity: _opacity,
                        duration: Duration(milliseconds: 250),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                          child: widget.secondFloor,
                        ),
                      )
                    : SizedBox.shrink(),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ScaleAnimationWidget(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                            color: backgroundColor,
                          ),
                          child: widget.firstFloor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SlideUpAnimationWidget(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: backgroundColor,
                          ),
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (scrollNotification) {
                              if (scrollNotification is ScrollUpdateNotification) {
                                _onScroll();
                              }
                              return false;
                            },
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: widget.groundFloor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }