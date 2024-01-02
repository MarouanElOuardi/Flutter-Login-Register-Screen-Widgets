import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireshipapp/buttons/dark_mode_button.dart';
import 'package:fireshipapp/screens/account.dart';
import 'package:fireshipapp/screens/login.dart';
import 'package:fireshipapp/screens/register.dart';
import 'package:fireshipapp/screens/todo.dart';
import 'package:fireshipapp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarImage {
  final String imagePath;
  final String description;
  final String publisherName;
  final String date;
  final String avatar;

  CarImage({
    required this.imagePath,
    required this.description,
    required this.publisherName,
    required this.date,
    required this.avatar,
  });
}

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  final List<CarImage> carouselImages = [
    CarImage(
      imagePath: 'images/bmw1.jpg',
      description: 'Luxurious BMW with cutting-edge features.',
      publisherName: 'Marouan El Ouardi',
      date: '2023-01-01',
      avatar: 'images/avatar.jpg',
    ),
    CarImage(
      imagePath: 'images/bmw2.jpg',
      description: 'Sleek design and powerful performance.',
      publisherName: 'Yassine Laouina',
      date: '2023-01-02',
      avatar: 'images/avatar.jpg',
    ),
    CarImage(
      imagePath: 'images/bmw3.jpg',
      description: 'Classic BMW elegance with modern technology.',
      publisherName: 'Anass El Karfi',
      date: '2023-01-03',
      avatar: 'images/avatar.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text("PublicEye"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w600,
          fontFamily: 'lato',
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/menu.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'lato',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            buildListTile(
              title: 'Account',
              icon: Icons.person,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()),
                );
              },
            ),
            buildListTile(
              title: 'Todo',
              icon: Icons.check,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodoPage()),
                );
              },
            ),
            buildListTile(
              title: 'Logout',
              icon: Icons.logout,
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                // clear instance of user and go back to login page
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'BMW Collection',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'lato',
            ),
          ),
          const SizedBox(height: 10),
          // Wrap the CarouselSlider with Center
          Center(
            child: CarouselSlider(
              items: carouselImages.map((carImage) {
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          carImage.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        carImage.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'lato',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Publisher: ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontFamily: 'lato'),
                          ),
                          Text(
                            carImage.publisherName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontFamily: 'lato',
                            ),
                          ),
                          const SizedBox(width: 5),
                          CircleAvatar(
                            radius: 10,
                            backgroundImage: AssetImage(carImage.avatar),
                          ),
                        ],
                      ),
                      Text(
                        'Date: ${carImage.date}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'lato',
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 600,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: 'lato',
        ),
      ),
      leading: Icon(
        icon,
        size: 24,
      ),
      onTap: onTap,
    );
  }
}
