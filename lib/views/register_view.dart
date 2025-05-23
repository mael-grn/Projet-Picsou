import 'package:flutter/material.dart';
import 'package:projet_picsou/views/login_view.dart';
import 'package:projet_picsou/widgets/ui/Text_field_widget.dart';
import 'package:provider/provider.dart';
import '../controllers/register_controller.dart';
import '../core/PageRoute.dart';
import '../core/theme/app_theme.dart';
import '../widgets/animations/scale_animation_widget.dart';
import '../widgets/ui/button_widget.dart';

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
                      "images/register.png"
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  "Créer un compte",
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
                SizedBox(height: 20),

                ButtonWidget(
                  tag: "validate_button",
                  backgroundColor: primaryColor,
                  onPressed: () {
                    registerController.submitForm(widget._formKey);
                  },
                  message: "S'enregistrer",
                  icon: Icons.arrow_circle_right_outlined,
                ),
                SizedBox(height: 30),
                Text(
                    textAlign: TextAlign.center,
                    "Déjà membre de la communauté Picsou ?"
                ),
                SizedBox(height: 10),

                ButtonWidget(
                  tag: "change_auth_method_button",
                  backgroundColor: backgroundVariantColor,
                  foregroundColor: foregroundColor,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      DefaultPageRoute(
                        builder: (_) => LoginView(),
                      ),
                    );
                  },
                  message: "Se connecter",
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
