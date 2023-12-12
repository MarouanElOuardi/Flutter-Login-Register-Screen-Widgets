import 'package:fireshipapp/buttons/login_button.dart';
import 'package:fireshipapp/fields/email_field.dart';
import 'package:fireshipapp/fields/password_field.dart';
import 'package:fireshipapp/themes/theme_provider.dart';
import 'package:fireshipapp/widgets/avatar_widget.dart';
import 'package:fireshipapp/widgets/dont_have_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("PublicEye"),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleDarkMode();
            },
          ),
        ],
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w400,
          fontFamily: 'lato',
        ),
        backgroundColor: isDarkMode ? Colors.deepPurple.shade300 : Colors.purple.shade100,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Avatar
            const AvatarWidget(radius: 50, icon: Icons.person),
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            //Email Field
            EmailField(controller: TextEditingController()),
            const SizedBox(height: 20),
            //Password Field
            PasswordField(controller: TextEditingController()),
            const SizedBox(height: 50),
            //Login Button
            LoginButton(onPressed: _login),
            const SizedBox(height: 20),
            //dont have account
            const DontHaveAccount(),
          ],
        ),
      ),
    );
  }

  void _login() async {}
}
