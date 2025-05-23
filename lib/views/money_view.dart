import 'package:flutter/material.dart';

import '../widgets/ui/main_page_layout_widget.dart';

class MoneyView extends StatelessWidget {
  const MoneyView({super.key});
  @override
  Widget build(BuildContext context) {
    return MainPageLayoutWidget(
      secondFloor: Text("Argent"),
      firstFloor: Text("Rien"),
      groundFloor: Text("Toujours rien"),
    );
  }
}