import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/views/login_view.dart';
import 'package:projet_picsou/widgets/global_layout.dart';
import 'package:projet_picsou/widgets/ui/Text_field_widget.dart';
import 'package:provider/provider.dart';
import '../controllers/register_controller.dart';
import '../core/theme/app_theme.dart';
import '../widgets/ui/button_widget.dart';
import '../dialogs/alert_dialog_builder.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  @override
  Widget build(BuildContext context) {
    final registerController = context.watch<RegisterController>();


    // Redirection automatique si la connexion a réussi
    if (registerController.user != null && registerController.error == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GlobalLayout()),
        );
      });
    }

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.fromLTRB(30, 100, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                    height: 200,
                    width: 200,
                    "images/register.png"
                ),
                SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  "Créer un compte",
                ),
                SizedBox(height: 10),
                Text(
                    textAlign: TextAlign.center,
                    "Déjà membre de la communauté Picsou ?"
                ),
                SizedBox(height: 10),

                ButtonWidget(
                  size: ButtonWidgetSize.small,
                  buttonBackgroundColor: secondaryColor,
                  textColor: foregroundColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginView(),
                      ),
                    );
                  },
                  message: "Se connecter",
                ),

                SizedBox(height: 20),

                Form(
                  key: widget._formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        labelText: 'Nom',
                        controller: registerController.lastNameController,

                        validator: registerController.lastNameValidator,
                      ),
                      const SizedBox(height: 16.0),
                      TextFieldWidget(
                        controller: registerController.firstNameController,
                        labelText: 'Prénom',
                        validator: registerController.firstNameValidator,
                      ),
                      const SizedBox(height: 16.0),
                      TextFieldWidget(
                        controller: registerController.emailController,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: registerController.emailValidator,
                      ),
                      const SizedBox(height: 16.0),
                      TextFieldWidget(
                        controller: registerController.passwordController,
                        obscureText: registerController.hidePassword,
                        labelText: 'Mot de passe',
                        suffixIcon: IconButton(
                          color: foregroundColor,
                          icon: Icon(
                            registerController.hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: registerController.togglePasswordVisibility,
                        ),
                        validator: registerController.passwordValidator,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          )
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: foregroundColor,
        onPressed:
            () => {
              if (!registerController.isLoading && registerController.user == null)
                {registerController.submitForm(widget._formKey)}
              else if (!registerController.isLoading &&
                  registerController.user != null &&
                  registerController.error == null)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GlobalLayout()),
                  ),
                },
            },
        label:
        registerController.isLoading
                ? LoadingAnimationWidget.inkDrop(
                  color: backgroundColor,
                  size: 20,
                )
                : registerController.error == null && registerController.user != null
                ? Text(style: TextStyle(color: backgroundColor), 'Continuer')
                : Text(
                  style: TextStyle(color: backgroundColor),
                  'Créer un compte',
                ),
      ),
    );
  }
}
