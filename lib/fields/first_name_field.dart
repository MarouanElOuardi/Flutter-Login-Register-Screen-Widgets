import 'package:flutter/material.dart';

class FirstNameField extends StatefulWidget {
  final TextEditingController controller;

  const FirstNameField({super.key, required this.controller});

  @override
  _FirstNameFieldState createState() => _FirstNameFieldState();
}

class _FirstNameFieldState extends State<FirstNameField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: widget.controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "First Name",
        ),
      ),
    );
  }
}
