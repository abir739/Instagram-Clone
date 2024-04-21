import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {

  final TextInputType textInputType; // It specifies the type of input (e.g., text, number, email).
  final TextEditingController textFieldController; // It represents the controller for the text field.
  final String hintText; // It provides a hint text to display inside the text field when it’s empty.
  final bool isPwd; // It determines whether the text input should be treated as a password (obscured)
  final InputBorder inputBorder; //  It specifies the border style for the text field.

  const TextFieldInput(
      {Key? key,
      required this.textFieldController,
      required this.inputBorder,
      required this.hintText,
     this.isPwd = false,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    // returns a BorderSide object that matches the default divider style used in Flutter.
    final inputBorder = OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textFieldController,
      decoration: InputDecoration(
          border: inputBorder,
          hintText: hintText,
          // Specify the border style when the text field is focused or enabled.
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          // Sets the padding around the text input area.
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textInputType, // Determines the type of keyboard to display (e.g., numeric, email, etc.).
      obscureText: isPwd, // Hides the input characters (useful for password fields).
    );
  }
}
