import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/entry_point_controller.dart';
import 'package:provider/provider.dart';

class EntryPointView extends StatefulWidget {
  const EntryPointView({super.key});
  @override
  State<EntryPointView> createState() => _EntryPointViewState();

}

class _EntryPointViewState extends State<EntryPointView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final entryPointController = Provider.of<EntryPointController>(context, listen: false);
      entryPointController.recover();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
