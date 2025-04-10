import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/controllers/auth_controller.dart';
import 'package:projet_picsou/widgets/global_layout.dart';
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
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
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
      String nom = _nomController.text;
      String prenom = _prenomController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      authController.register(nom, prenom, email, password);
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
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nomController,
                        decoration: const InputDecoration(
                          labelText: 'Nom',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre nom';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _prenomController,
                        decoration: const InputDecoration(
                          labelText: 'Prénom',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre prénom';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre email';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Veuillez entrer un email valide';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
                          }
                          if (value.length < 6) {
                            return 'Le mot de passe doit contenir au moins 6 caractères';
                          }
                          return null;
                        },
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
