import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/controllers/auth_controller.dart';
import 'package:projet_picsou/views/login_view.dart';
import 'package:projet_picsou/widgets/global_layout.dart';
import 'package:projet_picsou/widgets/ui/TextFieldWidget.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../widgets/ui/popup.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
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
      String lastName = _lastNameController.text;
      String firstName = _firstNameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      authController.register(firstName, lastName, email, password);
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
                  "Créer un compte",
                ),
                SizedBox(height: 10),
                Text("Déjà membre de la communauté Picsou ?"),
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
                          builder: (context) => LoginView(),
                        ),
                      );
                    },
                    child: Text("Se connecter")
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        labelText: 'Nom',
                        controller: _lastNameController,

                        validator: authController.lastNameValidator,
                      ),
                      const SizedBox(height: 16.0),
                      TextFieldWidget(
                        controller: _firstNameController,
                        labelText: 'Prénom',
                        validator: authController.firstNameValidator,
                      ),
                      const SizedBox(height: 16.0),
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
                        validator: authController.passwordValidator,
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
                  'Créer un compte',
                ),
      ),
    );
  }
}
