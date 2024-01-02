// ignore_for_file: library_private_types_in_public_api
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireshipapp/firebase_auth/firebase_auth_services.dart';
import 'package:fireshipapp/screens/login.dart';
import 'package:fireshipapp/themes/theme_provider.dart';
import 'package:fireshipapp/user/user_model.dart';
import 'package:fireshipapp/widgets/already_have_account_widget.dart';
import 'package:fireshipapp/widgets/avatar_widget.dart';
import 'package:fireshipapp/fields/confirm_password_field.dart';
import 'package:fireshipapp/fields/email_field.dart';
import 'package:fireshipapp/fields/first_name_field.dart';
import 'package:fireshipapp/widgets/gender_selection.dart';
import 'package:fireshipapp/fields/last_name_field.dart';
import 'package:fireshipapp/widgets/profession_dropdown.dart';
import 'package:fireshipapp/buttons/registration_button.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fireshipapp/fields/password_field.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
  bool _isMale = true; // Initial value for the gender checkbox
  String _selectedProfession =
      'Student'; // Initial value for the profession dropdown
  final List<String> _professions = ['Student', 'Teacher'];

  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDarkMode ? Colors.deepPurple.shade400 : Colors.deepPurple.shade300,
        title: const Text("PublicEye"),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            alignment: Alignment.centerRight,
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleDarkMode();
            },
          ),
        ],

        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w600,
          fontFamily: 'lato',
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar
              const AvatarWidget(radius: 50, icon: Icons.person_add),
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // First Name Field
              FirstNameField(controller: _firstNameController),
              const SizedBox(height: 20),
              // Last Name Field
              LastNameField(controller: _lastNameController),
              const SizedBox(height: 20),
              // Email Field
              EmailField(controller: _emailController),
              const SizedBox(height: 20),
              PasswordField(controller: _passwordController),
              const SizedBox(height: 20),
              ConfirmPasswordField(controller: _confirmPasswordController),
              const SizedBox(height: 20),
              // Gender Selection
              GenderSelection(
                isMale: _isMale,
                onMaleChanged: (value) {
                  setState(() {
                    _isMale = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Profession Dropdown
              ProfessionDropdown(
                selectedProfession: _selectedProfession,
                professions: _professions,
                onProfessionChanged: (value) {
                  setState(() {
                    _selectedProfession = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Register Button
              RegistrationButton(onPressed: _register),
              const SizedBox(height: 20),
              AlreadyHaveAccountWidget(
                onPressed: () {
                  Navigator.pop(context); // Go back to the login screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    final String firstName = _firstNameController.text.trim();
    final String lastName = _lastNameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    final String gender = _isMale ? 'Male' : 'Female';

    // Validate fields
    if (!_validateFields(firstName, lastName, email, password, confirmPassword)) {
      _showSnackBar("Please fill in all fields", Colors.red);
      return;
    }

    // Validate email format
    if (!EmailValidator.validate(email)) {
      _showSnackBar("Invalid email format", Colors.red);
      return;
    }

    // Validate password format
    if (!_isValidPassword(password)) {
      _showSnackBar("Invalid password format (min 6 chars)", Colors.red);
      return;
    }

    // Check if passwords match
    if (password != confirmPassword) {
      _showSnackBar("Passwords do not match", Colors.red);
      return;
    }

    // Create user
    User? user = await _firebaseAuthServices.createUserWithEmailAndPasswordAndInfos(email, password, "$firstName $lastName");

    if (user != null) {
      await _storeAdditionalUserInfo(user.uid, firstName, lastName, gender, _selectedProfession);
      print("User created successfully");
      _showSnackBar("User created successfully", Colors.green);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
    } else {
      _showSnackBar("User creation failed", Colors.red);
    }
  }
  Future<void> _storeAdditionalUserInfo(String uid, String firstName, String lastName, String gender, String profession) async {
  try {
    // use firestore to store additional user information (firstName, lastName, gender)
    UserModel? user =  UserModel(firstName: firstName, lastName: lastName, gender: gender, profession: profession) ;
    await FirebaseFirestore.instance.collection('Users').doc('users_infos').set(user.toJson());
  } catch (e) {
    print("Failed to store user information in Firestore: $e");
  }
}

  bool _validateFields(String firstName, String lastName, String email, String password, String confirmPassword) {
    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return false;
    }
    return true;
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

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
        )
      ),
    );
  }
}