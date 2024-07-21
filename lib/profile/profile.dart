import 'dart:io';
import 'package:app/global.dart';
import 'package:app/login.dart';
import 'package:app/profile/contact.dart';
import 'package:app/profile/help&support.dart';
import 'package:app/profile/privacypolicy.dart';
import 'package:app/profile/termandcondation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'editprofile.dart';
// Import the HelpSupport screen file

class Profile extends StatefulWidget {
  const Profile({super.key, required String name, required String email});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  String name = 'soban';
  String mobile = '0303 4883743';
  String email = 'sobanmalik1212@gmail.com';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _navigateAndEditProfile() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          name: name,
          mobile: mobile,
          email: email,
          image: _image,
        ),
      ),
    );

    if (updatedData != null) {
      setState(() {
        name = updatedData['name'];
        mobile = updatedData['mobile'];
        email = updatedData['email'];
        _image = updatedData['image'];
      });
    }
  }

  void _navigateToPrivacyPolicy() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PrivacyPolicy(),
        ));
  }

  void _navigateToHelpSupport() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HelpSupport()),
    );
  }

  void _navigateToTermCondation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TermCondation()),
    );
  }

  void _navigateTocontact() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Contact()),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Logout', style: TextStyle(color: Colors.red)),
            ],
          ),
          content: const Text('Are you sure you want to logout this app?'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.blue),
                ),
              ),
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.blue),
                ),
              ),
              child: const Text(
                'Yes logout',
                style: TextStyle(
                  // color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                setState(() {
                  userData = {};
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black,
        elevation: 1,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _image == null
                                ? const AssetImage('assets/profile.png')
                                : FileImage(_image!) as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 60,
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 25,
                              ),
                              onPressed: () {
                                _pickImage(); // Call your image picker function here
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData['username'],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            userData['email'],
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
            buildMenuItem(Icons.payment_outlined, 'Payment', '\$0.0'),
            buildMenuItem(
                Icons.help, 'Help & support', null, _navigateToHelpSupport),
            buildMenuItem(Icons.privacy_tip, 'Privacy policy', null,
                _navigateToPrivacyPolicy),
            buildMenuItem(Icons.description, 'Terms and condition', null,
                _navigateToTermCondation),
            buildMenuItem(
                Icons.contact_emergency, 'Contact', null, _navigateTocontact),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title, String? trailing,
      [VoidCallback? onTap]) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing != null
          ? Text(trailing, style: const TextStyle(color: Colors.green))
          : const Icon(Icons.arrow_forward_ios),
      onTap: onTap ?? () {},
    );
  }
}
