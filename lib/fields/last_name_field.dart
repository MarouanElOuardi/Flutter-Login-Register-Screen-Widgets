import 'package:flutter/material.dart';

class LastNameField extends StatefulWidget {
  final TextEditingController controller;

  const LastNameField({super.key, required this.controller});

  @override
  _LastNameFieldState createState() => _LastNameFieldState();
}

class _LastNameFieldState extends State<LastNameField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: widget.controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Last Name",
        ),
      ),
    );
  }
}
