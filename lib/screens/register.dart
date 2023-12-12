// ignore_for_file: library_private_types_in_public_api
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

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isMale = true; // Initial value for the gender checkbox
  String _selectedProfession =
      'Student'; // Initial value for the profession dropdown
  final List<String> _professions = ['Student', 'Teacher'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        centerTitle: true,
        title: const Text("PublicEye"),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w400,
          fontFamily: 'sans-serif',
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Avatar
              const AvatarWidget(radius: 50, icon: Icons.person_add),
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              //First Name Field
              FirstNameField(controller: _firstNameController),
              const SizedBox(height: 20),
              //Last Name Field
              LastNameField(controller: _lastNameController),
              const SizedBox(height: 20),
              //Email Field
              EmailField(controller: _emailController),
              const SizedBox(height: 20),
              PasswordField(controller: _passwordController),
              const SizedBox(height: 20),
              ConfirmPasswordField(controller: _confirmPasswordController),
              const SizedBox(height: 20),
              //Gender Selection

              GenderSelection(
                isMale: _isMale,
                onMaleChanged: (value) {
                  setState(() {
                    _isMale = value;
                  });
                },
              ),

              const SizedBox(height: 20),
              //Profession Dropdown
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
              //Register Button
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

    // Check if any of the required fields is empty
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      // Show an error dialog
      _showErrorDialog("Please fill in all fields(Required).");
      return;
    }

    // Validate email format
    if (!EmailValidator.validate(email)) {
      _showErrorDialog("Invalid email format");

      return;
    }
    // passwordconfirmationcheck
    if (password != confirmPassword) {
      _showErrorDialog("Passwords do not match");
      return;
    }

    // Show registration details dialog
    _showRegistrationDialog(
        firstName, lastName, email, gender, _selectedProfession);
    // Request focus to a different element to trigger the TextField update
  }

  void _showRegistrationDialog(String firstName, String lastName, String email,
      String gender, String profession) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Registration Details"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Name: $firstName $lastName"),
              Text("Email: $email"),
              Text("Gender: $gender"),
              Text("Profession : $profession"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
