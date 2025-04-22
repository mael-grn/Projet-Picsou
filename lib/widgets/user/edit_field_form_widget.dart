import 'package:flutter/material.dart';
import '../ui/Text_field_widget.dart';
import '../ui/button_widget.dart';

class EditFieldFormWidget extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  final String? Function(String?) validator;
  final TextEditingController controller;
  final Function validate;
  final String label;

   EditFieldFormWidget({
    required this.validator,
    required this.controller,
    required this.validate,
     required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Image.asset(
            height: 200,
            width: 200,
            "images/edit.png"
        ),
        SizedBox(height: 10),
        Text(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          "Modifier mon $label",
        ),
        SizedBox(height: 10),

        SizedBox(height: 20),

        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldWidget(
                controller: controller,
                labelText: label,

                keyboardType: TextInputType.emailAddress,
                validator: validator,
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        ButtonWidget(
          message: "Valider",
          icon: Icons.check,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              validate();
            }
          }
        )
      ],
    );

  }
}
