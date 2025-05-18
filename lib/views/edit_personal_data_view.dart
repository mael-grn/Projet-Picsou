import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:provider/provider.dart';
import '../controllers/edit_personal_data_controller.dart';
import '../controllers/me_controller.dart';
import '../models/user.dart';
import '../widgets/ui/Text_field_widget.dart';

class EditPersonalDataView extends StatefulWidget {
  const EditPersonalDataView({super.key});

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

    if (controller.user == null || controller.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DialogBuilder.loading(context);
      });

    }

    if (controller.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DialogBuilder.warning(context, "Une erreur s'est produite", controller.error!, () {
          controller.error = null;
          Navigator.pop(context);
        });
      });

    }

    if (controller.userUpdated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier mes informations"),
        backgroundColor: backgroundVariantColor,
        actions: [

        ],
      ),

      body: Container(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: SingleChildScrollView(
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
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.updateUser();
        },
        label: Text(style: TextStyle(color: foregroundColor), "Valider"),
        icon: Icon(color: foregroundColor, Icons.save),
        backgroundColor: primaryColor,
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}