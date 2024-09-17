import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text(
          "This is the Profile Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
