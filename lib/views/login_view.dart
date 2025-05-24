import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/login_controller.dart';
import 'package:projet_picsou/views/register_view.dart';
import 'package:projet_picsou/widgets/animations/scale_animation_widget.dart';
import 'package:projet_picsou/widgets/global_layout.dart';
import 'package:projet_picsou/widgets/ui/Text_field_widget.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:provider/provider.dart';
import '../core/PageRoute.dart';
import '../core/theme/app_theme.dart';
import '../widgets/animations/scale_pop_animation_widget.dart';


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

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 75),
                ScaleAnimationWidget(
                  child: Image.asset(
                      height: 200,
                      width: 200,
                      "images/login.png"
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  "Se connecter",
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

                SizedBox(height: 20),
                ButtonWidget(
                  tag: "validate_button",
                  backgroundColor: primaryColor,
                  onPressed: () {
                    loginController.submitForm(widget._formKey);
                  },
                  message: "Connexion",
                  icon: Icons.arrow_circle_right_outlined,
                ),
                SizedBox(height: 30),
                Text(
                    textAlign: TextAlign.center,
                    "Pas encore membre de la communauté Picsou ?"
                ),
                SizedBox(height: 10),
                ButtonWidget(
                  tag: "change_auth_method_button",

                  backgroundColor: backgroundVariantColor,
                  foregroundColor: foregroundColor,
                  onPressed: () {
                    PageRouter.pushReplacement(RegisterView());
                  },
                  message: "Créer un compte",
                  icon: Icons.open_in_new,
                ),

                SizedBox(height: 25),
              ],
            ),
          )
      )
    );
  }
}
