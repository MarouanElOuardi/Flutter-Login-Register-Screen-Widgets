import 'package:flutter/material.dart';
class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.deepPurple.shade800,
        padding: const EdgeInsets.symmetric(horizontal: 50),
      ),
      child: const Text("Login"),
    );
  }
}
