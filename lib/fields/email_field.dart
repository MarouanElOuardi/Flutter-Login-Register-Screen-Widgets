import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: widget.controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Email",
        ),
      ),
    );
  }
}
