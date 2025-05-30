import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/home/create_expense_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/core/custom_navigator.dart';
import 'package:projet_picsou/views/user_profile_view.dart';
import 'package:projet_picsou/widgets/animations/slide_fade_animation_widget.dart';
import 'package:projet_picsou/widgets/list_item_profile_elem_widget.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:projet_picsou/widgets/ui/popup_page_widget.dart';
import 'package:provider/provider.dart';

import '../../models/group.dart';
import '../../models/user.dart';
import '../animations/slide_fade_animation_from_right_widget.dart';

class CreateExpenseStep1Widget extends StatelessWidget {
  const CreateExpenseStep1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CreateExpenseController>();
    return SlideFadeAnimationFromRightWidget(
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Où souhaitez-vous partager cette dépense ?",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),

          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: foregroundVariantColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Groupes",
                      style: TextStyle(
                        color: backgroundColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ...controller.groups.asMap().entries.map((entry) {
                  final i = entry.key;
                  final group = entry.value;
                  return AnimatedScale(
                    scale:
                        controller.selectedGroup != null &&
                                controller.selectedGroup!.id == group.id
                            ? 0.95
                            : 1,
                    duration: Duration(milliseconds: 300),
                    child: ListItemProfileElemWidget(
                      showTag: false,
                      id: group.id ?? -1,
                      onTap: () {
                        controller.selectGroup(group);
                      },
                      color:
                          controller.selectedGroup != null &&
                                  controller.selectedGroup!.id == group.id
                              ? secondaryColor
                              : backgroundColor,
                      imageUrl: group.pictRef,
                      name: group.name,
                      addGapAfter:
                          i !=
                          controller.friends.length -
                              1, // false pour le dernier
                    ),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 20),

          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: foregroundVariantColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Discussions",
                      style: TextStyle(
                        color: backgroundColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ...controller.discussions.asMap().entries.map((entry) {
                  final i = entry.key;
                  final group = entry.value;
                  return AnimatedScale(
                    scale:
                    controller.selectedGroup != null &&
                        controller.selectedGroup!.id == group.id
                        ? 0.95
                        : 1,
                    duration: Duration(milliseconds: 300),
                    child: ListItemProfileElemWidget(
                      showTag: false,
                      id: group.id ?? -1,
                      onTap: () {
                        controller.selectGroup(group, discussion: true);
                      },
                      color:
                      controller.selectedGroup != null &&
                          controller.selectedGroup!.id == group.id
                          ? secondaryColor
                          : backgroundColor,
                      imageUrl: group.pictRef,
                      name: group.name,
                      addGapAfter:
                      i !=
                          controller.friends.length -
                              1, // false pour le dernier
                    ),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 60),
          Text(
            "Vous ne trouvez pas ce que vous cherchez dans la liste ?",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            "Vous pouvez créer une nouvelle discussion de dépenses avec un ami.",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),

          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: foregroundVariantColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Amis",
                      style: TextStyle(
                        color: backgroundColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ...controller.friends.asMap().entries.map((entry) {
                  final i = entry.key;
                  final friend = entry.value;
                  return AnimatedScale(
                    scale:
                        controller.selectedFriend != null &&
                                controller.selectedFriend!.id == friend.id
                            ? 0.95
                            : 1,
                    duration: Duration(milliseconds: 300),
                    child: ListItemProfileElemWidget(
                      showTag: false,
                      id: friend.id,
                      onTap: () {
                        controller.selectFriend(friend);
                      },
                      color:
                          controller.selectedFriend != null &&
                                  controller.selectedFriend!.id == friend.id
                              ? secondaryColor
                              : backgroundColor,
                      imageUrl: friend.profilPictureRef,
                      name: "${friend.firstName} ${friend.lastName}",
                    ),
                  );
                }),
                ButtonWidget(
                  disabled: controller.selectedFriend == null,
                  message: "Créer une discussion",
                  icon: Icons.add,
                  onPressed: controller.createDiscussion,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
