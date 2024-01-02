// class DarkModeButton extends StatelessWidget {
//   const DarkModeButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;

//     return IconButton(
//       onPressed: () {
//         final newTheme = isDarkMode ? lightTheme : darkTheme;
//         context.read<ThemeCubit>().changeTheme(newTheme);
//       },
//       icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
//     );
//   }
// }
import 'package:fireshipapp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.dark_mode),
      onPressed: () {
        Provider.of<ThemeProvider>(context, listen: false).toggleDarkMode();
      },
    );
}
}