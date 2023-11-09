// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  String label;
  TextEditingController controller;
  bool obscureText;
  TextInputType keyboardType;
  InputField(
      {super.key,
      required this.label,
      required this.controller,
      this.obscureText = false,
      this.keyboardType = TextInputType.text});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
