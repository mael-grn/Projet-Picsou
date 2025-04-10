import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/controllers/auth_controller.dart';
import 'package:projet_picsou/views/register_view.dart';
import 'package:projet_picsou/widgets/global_layout.dart';
import 'package:projet_picsou/widgets/ui/TextFieldWidget.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../widgets/ui/popup.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _submitForm(AuthController authController) {
    HapticFeedback.heavyImpact();
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      authController.login(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 100, 30, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  "Se connecter",
                ),
                SizedBox(height: 10),
                Text("Pas encore membre de la communauté Picsou ?"),
                SizedBox(height: 10),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(primaryColor),
                      foregroundColor: WidgetStatePropertyAll<Color>(foregroundColor),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterView(),
                        ),
                      );
                    },
                    child: Text("Créer un compte")
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        controller: _emailController,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: authController.emailValidator,
                      ),
                      const SizedBox(height: 16.0),
                      TextFieldWidget(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        labelText: 'Mot de passe',
                        suffixIcon: IconButton(
                          color: foregroundColor,
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          PopupWidget(
            show: authController.showPopup,
            title: authController.popupTitle ?? "",
            content: authController.popupContent ?? "",
            imageSrc: authController.popupImage,
            onClosePressed: () {
              authController.closePopup();
            },
          ),

        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: foregroundColor,
        onPressed:
            () => {
          if (!authController.isLoading && authController.user == null)
            {_submitForm(authController)}
          else if (!authController.isLoading &&
              authController.user != null &&
              authController.error == null)
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GlobalLayout()),
              ),
            },
        },
        label:
        authController.isLoading
            ? LoadingAnimationWidget.inkDrop(
          color: backgroundColor,
          size: 20,
        )
            : authController.error == null && authController.user != null
            ? Text(style: TextStyle(color: backgroundColor), 'Continuer')
            : Text(
          style: TextStyle(color: backgroundColor),
          'Connexion',
        ),
      ),
    );
  }
}
