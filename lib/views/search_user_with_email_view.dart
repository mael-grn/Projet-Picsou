import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/widgets/animations/scale_animation_widget.dart';
import 'package:projet_picsou/widgets/ui/popup_page_widget.dart';
import 'package:provider/provider.dart';
import '../controllers/search_user_with_email_controller.dart';
import '../models/user.dart';
import '../widgets/ui/Text_field_widget.dart';
import '../widgets/ui/button_widget.dart';

class SearchUserWithEmailView extends StatefulWidget {
  SearchUserWithEmailView({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  _SearchUserWithEmailViewState createState() => _SearchUserWithEmailViewState();
}

class _SearchUserWithEmailViewState extends State<SearchUserWithEmailView>{

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SearchUserWithEmailController>();

    return PopupPageWidget(
      title: "Rechercher un utilisateur",
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                ScaleAnimationWidget(
                  duration: Duration(milliseconds: 1500),
                  child: Image.asset(
                      height: 250,
                      width: 250,
                      "images/search.png"
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                  "Faites-vous des amis !",
                ),
                SizedBox(height: 20),
                Text(
                    textAlign: TextAlign.center,
                    "Pour ajouter des amis, il vous suffit de saisir leur adresse e-mail.",
                ),
                SizedBox(height: 40),
                Form(
                  key: widget._formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFieldWidget(
                        controller: controller.emailController,
                        labelText: "E-mail",
                        validator: User.checkEmailFormatValidator,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ButtonWidget(
                  tag: "search_user",
                  onPressed: () {
                    controller.searchUser(widget._formKey);
                  },
                  message: "Rechercher",
                  icon: Icons.search,
                ),
                SizedBox(height: 20),
              ],
            )
        ),
      ),
    );
  }
}