import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          onTap: () async {
            await FirebaseAuth.instance.signOut().whenComplete(
                  () =>    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            )
                );
          },
          child: Container(
            margin: const EdgeInsets.all(16.0),
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.red[700],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Log out",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  }
}
