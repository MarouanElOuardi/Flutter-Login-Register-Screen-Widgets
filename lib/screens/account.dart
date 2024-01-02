import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireshipapp/buttons/dark_mode_button.dart';
import 'package:fireshipapp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:fireshipapp/user/user_model.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late Future<UserModel> _userData;

  @override
  void initState() {
    super.initState();
    _userData = fetchData();
  }

  Future<UserModel> fetchData() async {
  try {
    // Access the collection and document
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Users')  // Change to the actual collection name
        .doc('users_infos')   // Change to the actual document ID
        .get();

    // Print the entire snapshot data
    print('Snapshot Data: ${snapshot.data()}');

    // Retrieve the data
    Map<String, dynamic>? data = snapshot.data();

    if (data != null) {
      // Access the desired fields
      String firstName = data['FirstName'] ?? '';
      String lastName = data['LastName'] ?? '';
      String profession = data['Profession'] ?? '';
      String gender = data['Gender'] ?? '';

      // Use the fetched data
      print('First Name: $firstName');
      print('Last Name: $lastName');
      print('Profession: $profession');
      print('Gender: $gender');

      return UserModel(firstName: firstName, lastName: lastName, gender: gender, profession: profession);
    } else {
      print('Data is null');
      throw 'Data is null';
    }
  } catch (e) {
    print('Error fetching data: $e');
    throw e;  // Propagate the error to the caller
  }
}


  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    // Placeholder image, replace with the actual image of the user
    String userImage = "images/avatar.jpg";

    return Scaffold(
      appBar: AppBar(
        actions: const [DarkModeButton()],
        centerTitle: true,
        backgroundColor: isDarkMode
            ? Colors.deepPurple.shade400
            : Colors.deepPurple.shade300,
        title: const Text("PublicEye"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w600,
          fontFamily: 'lato',
        ),
      ),
      body: Center(
        child: FutureBuilder<UserModel>(
          future: _userData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // If the Future is still running, display a loading indicator
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If there is an error, display an error message
              return Text('Error: ${snapshot.error}');
            } else {
              // If the Future is complete, display the fetched data
              UserModel user = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // User Image
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(userImage),
                  ),
                  const SizedBox(height: 20),
                  // User Information
                  UserInfoItem(label: 'First Name', value: user.firstName),
                  UserInfoItem(label: 'Last Name', value: user.lastName),
                  UserInfoItem(label: 'Profession', value: user.profession),
                  UserInfoItem(label: 'Gender', value: user.gender),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class UserInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'lato',
              color: Colors.deepPurple,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'lato',
            ),
          ),
        ],
      ),
    );
  }
}
