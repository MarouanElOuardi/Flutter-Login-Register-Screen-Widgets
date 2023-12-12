import 'package:flutter/material.dart';

class GenderSelection extends StatelessWidget {
  final bool isMale;
  final Function(bool) onMaleChanged;

  const GenderSelection({
    super.key,
    required this.isMale,
    required this.onMaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Gender: "),
        Row(
          children: [
            Row(
              children: [
                Checkbox(
                  value: isMale,
                  onChanged: (bool? value) => onMaleChanged(value ?? false),
                ),
                const Text("Male"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: !isMale,
                  onChanged: (value) => onMaleChanged(!value!),
                ),
                const Text("Female"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
