import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../../controllers/me/edit_paiement_data_controller.dart';
import '../../controllers/me/edit_personal_data_controller.dart';
import '../../dialogs/alert_dialog_builder.dart';
import '../../models/user.dart';
import '../../widgets/ui/Text_field_widget.dart';
import '../../widgets/ui/button_widget.dart';

class EditPaiementDataView extends StatefulWidget {
  EditPaiementDataView({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  _EditPaiementDataViewViewState createState() => _EditPaiementDataViewViewState();
}

class _EditPaiementDataViewViewState extends State<EditPaiementDataView>{

  @override @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<EditPaiementDataController>();
      controller.paypalController.text = User.getCurrentUserInstance().emailPaypal;
      controller.weroController.text = User.getCurrentUserInstance().telWero;
      controller.ribController.text = User.getCurrentUserInstance().rib;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EditPaiementDataController>();

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
                  "Vous pouvez modifier vos informations de paiement ici."
              ),
              SizedBox(height: 40),
              Form(
                key: widget._formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFieldWidget(
                      controller: controller.paypalController,
                      labelText: "Email Paypal",
                      validator: User.checkOptionalEmailFormatValidator,
                    ),
                    SizedBox(height: 10),
                    TextFieldWidget(
                      controller: controller.weroController,
                      labelText: "Tel Wero",
                      validator: User.checkOptionalTelFormatValidator,
                    ),
                    SizedBox(height: 10),
                    TextFieldWidget(
                      controller: controller.ribController,
                      labelText: "Rib",
                      validator: User.checkOptionalRibFormatValidator,
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
}