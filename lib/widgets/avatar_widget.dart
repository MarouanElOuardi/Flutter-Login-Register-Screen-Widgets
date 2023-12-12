import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final double radius;
  final IconData icon;

  const AvatarWidget({super.key, this.radius = 45, this.icon = Icons.person_add});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CircleAvatar(
        radius: radius,
        child: Icon(
          icon,
          size: radius - 5, // Adjust the size based on the radius
        ),
      ),
    );
  }
}
