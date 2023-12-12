import 'package:flutter/material.dart';
class AlreadyHaveAccountWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const AlreadyHaveAccountWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        TextButton(
          onPressed: onPressed,
          child: const Text("Login"),
        ),
      ],
    );
  }
}
