import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/controllers/login_controller.dart';
import 'package:projet_picsou/views/register_view.dart';
import 'package:projet_picsou/widgets/global_layout.dart';
import 'package:projet_picsou/widgets/ui/Text_field_widget.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../dialogs/alert_dialog_builder.dart';


class LoginView extends StatefulWidget {
  LoginView({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  State<LoginView> createState() => _LoginViewState();


}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final loginController = context.watch<LoginController>();

    // Redirection automatique si la connexion a réussi
    if (loginController.user != null && loginController.error == null) {
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
                    "images/login.png"
                ),
                SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  "Se connecter",
                ),
                SizedBox(height: 10),
                Text(
                    textAlign: TextAlign.center,
                    "Pas encore membre de la communauté Picsou ?"
                ),
                SizedBox(height: 10),
                ButtonWidget(
                  size: ButtonWidgetSize.small,
                  buttonBackgroundColor: secondaryColor,
                  textColor: foregroundColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterView()),
                    );
                  },
                  message: "Créer un compte",
                ),

                SizedBox(height: 20),

                Form(
                  key: widget._formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        controller: loginController.emailController,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: loginController.emailValidator,
                      ),
                      const SizedBox(height: 16.0),
                      TextFieldWidget(
                        controller: loginController.passwordController,
                        obscureText: loginController.hidePassword,
                        labelText: 'Mot de passe',
                        suffixIcon: IconButton(
                          color: foregroundColor,
                          icon: Icon(
                            loginController.hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: loginController.togglePasswordVisibility,
                        ),
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
              if (!loginController.isLoading && loginController.user == null) {
                loginController.submitForm(widget._formKey)
              }
              else if (!loginController.isLoading &&
                  loginController.user != null &&
                  loginController.error == null)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GlobalLayout()),
                  ),
                },
            },
        label:
            loginController.isLoading
                ? LoadingAnimationWidget.inkDrop(
                  color: backgroundColor,
                  size: 20,
                )
                : loginController.error == null && loginController.user != null
                ? Text(style: TextStyle(color: backgroundColor), 'Continuer')
                : Text(style: TextStyle(color: backgroundColor), 'Connexion'),
      ),
    );
  }
}
