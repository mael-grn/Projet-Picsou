import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/auth/select_profile_picture_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../../widgets/ui/button_widget.dart';

class SelectProfilePictureView extends StatefulWidget {
  SelectProfilePictureView({super.key});
  @override
  _SelectProfilePictureViewState createState() => _SelectProfilePictureViewState();
}

class _SelectProfilePictureViewState extends State<SelectProfilePictureView> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SelectProfilePictureController>();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Text(
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                "Montrez-nous qui vous êtes !",
              ),
              SizedBox(height: 20),
              Text(
                textAlign: TextAlign.center,
                "Sélectionnez votre photo de profile parmi celles disponibles dans la liste ci-dessous. Elle sera visible par vous et vos amis.",
              ),
              SizedBox(height: 40),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.profilePictureList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final url = controller.profilePictureList[index];
                  final isSelected = controller.selectedProfilePicture == url;
                  return GestureDetector(
                    onTap: () => {controller.setSelectedProfilePicture(url)},
                    child: AnimatedScale(
                      scale: isSelected ? 0.85 : 1.0,
                      duration: Duration(milliseconds: 200),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipOval(
                            child: Hero(
                                tag: url,
                                child: Image.network(
                                  url,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              right: 4,
                              top: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.check, color: Colors.white, size: 18),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ButtonWidget(
                onPressed: () {
                  controller.updateUser();
                },
                tag: "validate_button",
                message: "Valider",
                icon: Icons.check,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}