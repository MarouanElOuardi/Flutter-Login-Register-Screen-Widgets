// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

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
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: CircleAvatar(
                  radius: 45,
                  child: Icon(
                    Icons.person_add,
                    size: 40,
                  ),
                ),
              ),
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "First Name",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Last Name",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Confirm Password",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Gender: "),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _isMale,
                            onChanged: (bool? value) {
                              setState(() {
                                _isMale = value ?? false;
                              });
                            },
                          ),
                          const Text("Male"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: !_isMale,
                            onChanged: (bool? value) {
                              setState(() {
                                _isMale = !(value ?? true);
                              });
                            },
                          ),
                          const Text("Female"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Im a: "),
                  Theme(
                    data: Theme.of(context).copyWith(
                      // Set the focus color to transparent
                      focusColor: Colors.deepPurple.shade100,
                    ),
                    child: DropdownButton<String>(
                      value: _selectedProfession,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedProfession = value ?? 'Student';
                        });
                      },
                      elevation: 0,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      focusNode: FocusNode(skipTraversal: true),
                      items: _professions.map((String profession) {
                        return DropdownMenuItem<String>(
                          value: profession,
                          child: Text(profession),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _register();
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.deepPurple.shade800,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                ),
                child: const Text("Register"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to the login screen
                    },
                    child: const Text("Login"),
                  ),
                ],
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
