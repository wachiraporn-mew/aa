import 'package:cornnapp/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeSreen extends StatelessWidget {
  final aunt = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ยินดีต้อนรับเข้าสู่ระบบ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text(
                "email",
                style: TextStyle(fontSize: 25),
              ),
              ElevatedButton(
                  child: Text("ออกจากระบบ"),
                  onPressed: () {
                    aunt.signOut().then((value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }));
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
