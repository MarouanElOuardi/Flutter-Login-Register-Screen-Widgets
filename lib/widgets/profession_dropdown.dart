import 'package:flutter/material.dart';

class ProfessionDropdown extends StatelessWidget {
  final String selectedProfession;
  final List<String> professions;
  final Function(String) onProfessionChanged;

  const ProfessionDropdown({
    super.key,
    required this.selectedProfession,
    required this.professions,
    required this.onProfessionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("I'm a: "),
        Theme(
          data: Theme.of(context).copyWith(
            focusColor: Colors.deepPurple.shade100,
          ),
          child: DropdownButton<String>(
            value: selectedProfession,
            onChanged: (String? value) {
              onProfessionChanged(value ?? '');
            },
            elevation: 0,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            focusNode: FocusNode(skipTraversal: true),
            items: professions.map((String profession) {
              return DropdownMenuItem<String>(
                value: profession,
                child: Text(profession),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
