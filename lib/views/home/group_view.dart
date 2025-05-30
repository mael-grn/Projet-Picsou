import 'package:flutter/material.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/models/group.dart';
import 'package:projet_picsou/widgets/list_item_profile_elem_widget.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:projet_picsou/widgets/ui/popup_page_widget.dart';
import '../../core/theme/app_theme.dart';
import '../../models/user.dart';

class GroupView extends StatelessWidget {
  final Group group;
  final List<User> members;
  const GroupView({required this.group, required this.members, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PopupPageWidget(
            body: Column(
              children: [
                Hero(
                    tag: "${group.id}_pp",
                    child: Image.network(
                      group.pictRef,
                      width: 200,
                      height: 200,
                    ),
                ),

                SizedBox(height: 20),

                Text(
                  textAlign: TextAlign.center,
                  group.name,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),

                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: foregroundVariantColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: members.map((user) => ListItemProfileElemWidget(id: user.id, imageUrl: user.profilPictureRef, name: "${user.firstName} ${user.lastName}")).toList(),
                  ),
                ),


                SizedBox(height: 40),

                ButtonWidget(
                    message: "Supprimer le groupe",
                    icon: Icons.delete,
                    backgroundColor: invalidColor,
                    onPressed: () {
                      DialogBuilder.warning("Pas trop vite !", "Cette fonctionalité n'est pas encore implémentée, mais elle le sera bientôt !");
                    }
                ),

                SizedBox(height: 20),

                ButtonWidget(
                    message: "Ajouter un membre",
                    icon: Icons.add,
                    onPressed: () {
                      DialogBuilder.warning("Pas trop vite !", "Cette fonctionalité n'est pas encore implémentée, mais elle le sera bientôt !");
                    }
                )
              ],
            )
        )
    );
  }
}
