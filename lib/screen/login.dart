import 'package:cornnapp/model/profile.dart';
import 'package:cornnapp/screen/register.dart';
import 'package:cornnapp/screen/welcome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          "เข้าสู่ระบบ",
          style: GoogleFonts.itim(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/3.png"),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text(
                      "สร้างบัญชีบัญชีผู้ใช้",
                      style: GoogleFonts.itim(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return RegisterScreen();
                      }));
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
