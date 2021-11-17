import 'package:cornnapp/model/profile.dart';
import 'package:cornnapp/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(
    email: '',
    password: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ตั้งค่ารหัสผ่าน",
          style: GoogleFonts.itim(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("อีเมล", style: TextStyle(fontSize: 18)),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String? email) {
                        profile.email = email!;
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Text("รหัสผ่านใหม่", style: TextStyle(fontSize: 18)),
                  TextFormField(
                      obscureText: true,
                      onSaved: (String? password) {
                        profile.password = password!;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Text("กรอกรหัสผ่านอีกครั้ง", style: TextStyle(fontSize: 18)),
                  TextFormField(
                      obscureText: true,
                      onSaved: (String? password) {
                        profile.password = password!;
                      }),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(
                          "ยืนยันรหัสผ่าน",
                          style: GoogleFonts.itim(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
