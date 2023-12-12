import 'package:flutter/material.dart';
class ConfirmPasswordField extends StatefulWidget {
  final TextEditingController controller;

  const ConfirmPasswordField({super.key, required this.controller});

  @override
  _ConfirmPasswordFieldState createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  bool _isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: widget.controller,
        obscureText: _isConfirmPasswordHidden,
        onChanged: (text) {
          setState(() {
            // Rebuild the widget when the text changes
          });
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: "Confirm Password",
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    _isConfirmPasswordHidden
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.deepPurpleAccent.shade100,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
