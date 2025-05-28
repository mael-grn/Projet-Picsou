import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../controllers/edit_personal_data_controller.dart';
import '../dialogs/alert_dialog_builder.dart';
import '../models/user.dart';
import '../widgets/ui/Text_field_widget.dart';
import '../widgets/ui/button_widget.dart';

class EditPersonalDataView extends StatefulWidget {
  EditPersonalDataView({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  _EditPersonalDataViewState createState() => _EditPersonalDataViewState();
}

class _EditPersonalDataViewState extends State<EditPersonalDataView>{

  @override @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<EditPersonalDataController>();
      controller.firstNameController.text = User.getCurrentUserInstance().firstName;
      controller.lastNameController.text = User.getCurrentUserInstance().lastName;
      controller.emailController.text = User.getCurrentUserInstance().email;
      controller.phoneController.text = User.getCurrentUserInstance().tel;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EditPersonalDataController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 10.0,
        surfaceTintColor: backgroundVariantColor,
        backgroundColor: backgroundColor
      ),

      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),

              Text(
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                "Modifier vos informations",
              ),
              SizedBox(height: 20),
              Text(
                  textAlign: TextAlign.center,
                  "Vous pouvez modifier vos informations personnelles ici."
              ),
              SizedBox(height: 40),
              Stack(
                children: [
                  Hero(
                    tag: User.getCurrentUserInstance().profilPictureRef,
                    child: Image.network(
                      User.getCurrentUserInstance().profilPictureRef,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: IconButton(
                        onPressed: () {
                          DialogBuilder.warning("Oups", "Cette fonctionnalité n'est pas encore disponible");
                        },
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
              SizedBox(height: 30),
              Form(
                key: widget._formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFieldWidget(
                      controller: controller.firstNameController,
                      labelText: "Prénom",
                      validator: User.checkNameFormatValidator,
                    ),
                    SizedBox(height: 10),
                    TextFieldWidget(
                      controller: controller.lastNameController,
                      labelText: "Nom",
                      validator: User.checkNameFormatValidator,
                    ),
                    SizedBox(height: 10),
                    TextFieldWidget(
                      controller: controller.emailController,
                      labelText: "Email",
                      validator: User.checkEmailFormatValidator,
                    ),
                    SizedBox(height: 10),
                    TextFieldWidget(
                      controller: controller.phoneController,
                      labelText: "Téléphone",
                      validator: User.checkOptionalTelFormatValidator,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ButtonWidget(
                onPressed: () {
                  controller.updateUser(widget._formKey);
                },
                tag: "edit_user",
                message: "Valider",
                icon: Icons.save,
              ),
              SizedBox(height: 20),
            ],
          )
        ),
      ),
    );
  }
}