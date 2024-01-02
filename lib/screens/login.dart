import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireshipapp/buttons/dark_mode_button.dart';
import 'package:fireshipapp/buttons/login_button.dart';
import 'package:fireshipapp/fields/email_field.dart';
import 'package:fireshipapp/fields/password_field.dart';
import 'package:fireshipapp/firebase_auth/firebase_auth_services.dart';
import 'package:fireshipapp/screens/homepage.dart';
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
  final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        actions: const [
          Row(
            children: [
              DarkModeButton(),
            ],
          ),
        ],
        centerTitle: true,
        title: const Text("PublicEye"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w600,
          fontFamily: 'lato',
        ),
        backgroundColor: isDarkMode
            ? Colors.deepPurple.shade400
            : Colors.deepPurple.shade300,
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
            EmailField(controller: _emailController),
            const SizedBox(height: 20),
            //Password Field
            PasswordField(controller: _passwordController),
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

  void _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    void _showSnackBar(String message, Color backgroundColor) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message),
            backgroundColor: backgroundColor,
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: "Close",
              textColor: Colors.white,
              onPressed: () {},
            )),
      );
    }

    bool _validateFields(String email, String password) {
      if (email.isEmpty || password.isEmpty) {
        return false;
      }
      return true;
    }

    if (!_validateFields(email, password)) {
      _showSnackBar(
          "Both Email and Password are required to login", Colors.red);
      return;
    }
    if (!EmailValidator.validate(email)) {
      _showSnackBar("Invalid email format", Colors.red);
      return;
    }

// User? user=await _firebaseAuthServices.signInWithEmailAndPassword(email, password);
// if(user!=null){
//   print("User logged in successfully");
//   Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
//   }
//   else{
//     _showSnackBar("Wrong credentials", Colors.red);
// }
    try {
      User? user = await _firebaseAuthServices.signInWithEmailAndPassword(
          email, password);
      if (user != null) {
        print("User logged in successfully");
        _showSnackBar("Connected as $email", Colors.deepPurple.shade400);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));

        // Clear fields after successful login
        _emailController.clear();
        _passwordController.clear();
      } else {
        _showSnackBar("Wrong credentials", Colors.red);
      }
    } catch (e) {
      print("Login failed: $e");
      _showSnackBar("Login failed. Check your email and password.", Colors.red);
    }
  }
}
