import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/home/create_group_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/models/friend_request.dart';
import 'package:projet_picsou/models/group.dart';
import 'package:projet_picsou/widgets/friends/friend_request_widget.dart';
import 'package:projet_picsou/widgets/friends/friend_widget.dart';
import 'package:projet_picsou/widgets/ui/popup_page_widget.dart';
import 'package:provider/provider.dart';
import '../../controllers/me/edit_paiement_data_controller.dart';
import '../../controllers/me/edit_personal_data_controller.dart';
import '../../dialogs/alert_dialog_builder.dart';
import '../../models/user.dart';
import '../../widgets/animations/scale_animation_widget.dart';
import '../../widgets/ui/Text_field_widget.dart';
import '../../widgets/ui/button_widget.dart';

class CreateGroupView extends StatefulWidget {
  CreateGroupView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  _CreateGroupViewState createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {

  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<CreateGroupController>();
      controller.initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CreateGroupController>();

    return PopupPageWidget(
        title: "Créer un groupe",
        body: Column(
          children: [
            Form(
              key: widget._formKey,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(height: 20),

                  controller.groupPictureUrl == "" ?
                  ButtonWidget(
                    message: "Choisir une image",
                    icon: Icons.image,
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      DialogBuilder.selectGroupPicture(controller.setGroupPictureUrl);
                    },
                  )

                      :
                  Stack(
                    children: [
                      Image.network(
                        controller.groupPictureUrl,
                        width: 200,
                        height: 200,
                      ),
                      Positioned(
                          right: 4,
                          bottom: 4,
                          child: IconButton(
                              onPressed: () => DialogBuilder.selectGroupPicture(controller.setGroupPictureUrl),
                              icon: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.edit, size: 30, color: backgroundColor,),
                              )
                          )
                      ),
                    ],
                  ),

                  SizedBox(height: 40),

                  TextFieldWidget(
                    controller: controller.nameController,
                    labelText: "Nom du groupe",
                    validator: Group.checkNameFormatValidator,
                  ),

                  SizedBox(height: 40),

                  Text(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    "Membres du groupe :",
                  ),

                  SizedBox(height: 20),

                  Column(
                    children: [

                      Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: foregroundVariantColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    User.getCurrentUserInstance().profilPictureRef,
                                    width: 50,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "${User.getCurrentUserInstance().firstName} ${User.getCurrentUserInstance().lastName} (vous)",
                                    style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  ScaleAnimationWidget(
                                    duration: Duration(milliseconds: 300),
                                    child: Icon(
                                      color: backgroundColor,
                                      Icons.check,
                                      size: 35,
                                    ),
                                  )
                                ],
                              ),
                                SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    color: foregroundColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    style: TextStyle(
                                      color: backgroundColor
                                    ),
                                    "Propriétaire",
                                  )
                                )

                            ],
                          )
                      ),
                      SizedBox(height: 10),
                      ...controller.users.map((user) {
                        return AnimatedScale(
                            scale: controller.isSelected(user.id) ? 0.98 : 1.0,
                            duration: Duration(milliseconds: 300),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    HapticFeedback.mediumImpact();
                                    if (controller.isSelected(user.id)) {
                                      controller.removeSelectedFriend(UserIdWithStatus(user.id, UserStatus.member));
                                    } else {
                                      controller.addSelectedFriend(UserIdWithStatus(user.id, UserStatus.member));
                                    }
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: controller.isSelected(user.id) ? secondaryColor : backgroundVariantColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image.network(
                                                user.profilPictureRef,
                                                width: 50,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "${user.firstName} ${user.lastName}",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              if (controller.isSelected(user.id))
                                                ...[
                                                  Spacer(),
                                                  ScaleAnimationWidget(
                                                    duration: Duration(milliseconds: 300),
                                                    child: Icon(
                                                      Icons.check,
                                                      size: 35,
                                                    ),
                                                  )
                                                ],
                                            ],
                                          ),
                                          if (controller.isSelected(user.id))
                                            SizedBox(height: 20),
                                          if (controller.isSelected(user.id))
                                            Container(
                                              decoration: BoxDecoration(
                                                color: foregroundVariantColor,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: 12),
                                              child: DropdownButton<UserStatus>(
                                                value: controller.selectedUsers.where((u) => u.userId == user.id).first.status,
                                                borderRadius: BorderRadius.circular(12),
                                                dropdownColor: foregroundVariantColor,
                                                icon: Icon(Icons.arrow_drop_down, color: backgroundColor),
                                                underline: SizedBox(),
                                                items: UserStatus.values
                                                    .map((s) {
                                                  if (s != UserStatus.owner) {
                                                    return DropdownMenuItem<UserStatus>(
                                                      value: s,
                                                      child: Text(
                                                        style: TextStyle(color: backgroundColor),
                                                        s.title,
                                                      ),
                                                    );
                                                  } else {
                                                    return null;
                                                  }
                                                })
                                                    .whereType<DropdownMenuItem<UserStatus>>() // Filtre les nulls
                                                    .toList(),
                                                onChanged: (val) {
                                                  if (val != null) {
                                                    controller.updateSelectedFriendStatus(user.id, val);
                                                  }
                                                },
                                              ),
                                            )

                                        ],
                                      )
                                  ),
                                ),
                                SizedBox(height: 10)
                              ],
                            )
                        );
                      }),
                    ]

                  )

                ],
              ),
            ),

            SizedBox(height: 40),

            ButtonWidget(
                message: "Créer le groupe",
                icon: Icons.add,
                onPressed: () => controller.createGroup(widget._formKey)
            )
          ],
        )
    );
  }
}