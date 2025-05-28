
                      import 'package:flutter/material.dart';
                      import 'package:projet_picsou/core/theme/app_theme.dart';
                      import '../animations/scale_animation_widget.dart';
                      import '../animations/slide_up_animation_widget.dart';

                      class MainPageLayoutWidget extends StatefulWidget {
                        final Widget body;
                        final Widget? intermediate;
                        final Widget title;

                        const MainPageLayoutWidget({
                          super.key,
                          required this.body,
                          this.intermediate,
                          required this.title,
                        });

                        @override
                        State<MainPageLayoutWidget> createState() => _MainPageLayoutWidgetState();
                      }

                      class _MainPageLayoutWidgetState extends State<MainPageLayoutWidget>
                          with TickerProviderStateMixin {
                        final ScrollController _scrollController = ScrollController();
                        bool _showTitle = true;

                        @override
                        void initState() {
                          super.initState();
                          _scrollController.addListener(_onScroll);
                        }

                        void _onScroll() {
                          bool shouldShow = _scrollController.offset <= 0;
                          if (shouldShow != _showTitle) {
                            setState(() {
                              _showTitle = shouldShow;
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
                                  child: _showTitle
                                      ? Padding(
                                          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                                          child: widget.title,
                                        )
                                      : SizedBox.shrink(),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      if (widget.intermediate != null)
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
                                              child: widget.intermediate,
                                            ),
                                          ),
                                        ),
                                      Expanded(
                                        child: SlideUpAnimationWidget(
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(40),
                                              topRight: Radius.circular(40),
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                              decoration: BoxDecoration(color: backgroundColor),
                                              child: NotificationListener<ScrollNotification>(
                                                onNotification: (scrollNotification) {
                                                  if (scrollNotification
                                                      is ScrollUpdateNotification) {
                                                    _onScroll();
                                                  }
                                                  return false;
                                                },
                                                child: SingleChildScrollView(
                                                  controller: _scrollController,
                                                  child: widget.body,
                                                ),
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