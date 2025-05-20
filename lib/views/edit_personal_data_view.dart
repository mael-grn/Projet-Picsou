import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/widgets/animations/scale_animation_widget.dart';
import 'package:provider/provider.dart';
import '../controllers/edit_personal_data_controller.dart';
import '../models/user.dart';
import '../widgets/ui/Text_field_widget.dart';
import '../widgets/ui/button_widget.dart';

class EditPersonalDataView extends StatefulWidget {
  EditPersonalDataView({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  _EditPersonalDataViewState createState() => _EditPersonalDataViewState();
}

class _EditPersonalDataViewState extends State<EditPersonalDataView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<EditPersonalDataController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = context.watch<EditPersonalDataController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 10.0,
        surfaceTintColor: backgroundVariantColor,
        backgroundColor: backgroundColor,
        title: Text("Modifier mes informations"),
      ),

      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              ScaleAnimationWidget(
                  child: Image.asset(
                      height: 200,
                      width: 200,
                      "images/edit.png"
                  ),
              ),
              SizedBox(height: 30),
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
                      controller: controller.phoneController,
                      labelText: "Téléphone",
                      validator: User.checkTelFormatValidator,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ButtonWidget(
                onPressed: () {
                  controller.updateUser(widget._formKey);
                },
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

  @override
  bool get wantKeepAlive => true;
}