import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/entry_point_controller.dart';
import 'package:projet_picsou/views/error_screen_view.dart';
import 'package:projet_picsou/views/loading_sceen_view.dart';
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
      entryPointController.checkToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    final entryPointController = context.watch<EntryPointController>();
    return Scaffold(
        body:
        entryPointController.isLoading ?
        LoadingSceenView() :
        entryPointController.page ??
            ErrorScreenView( image: entryPointController.errorImage ?? "images/wondering.png", errorMessage: entryPointController.error ?? "Une erreur est survenue. Essayez de relancer l'application.")
    );
  }
}
