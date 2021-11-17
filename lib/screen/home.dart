import 'package:cornnapp/model/profile.dart';
import 'package:cornnapp/screen/login.dart';
import 'package:cornnapp/screen/register.dart';
import 'package:cornnapp/screen/reset.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Profile profile = Profile(
      email: '',
      password: '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CORN APP",
            style: GoogleFonts.itim(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.w100,
            ),
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
                    Image.asset("assets/images/3.png"),
                    SizedBox(
                      height: 20,
                    ),
                    Text("อีเมล", style: TextStyle(fontSize: 18)),
                    TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(errorText: "กรุณากรอกอีเมล"),
                          EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                        ]),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String? email) {
                          profile.email = email!;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Text("รหัสผ่าน", style: TextStyle(fontSize: 18)),
                    TextFormField(
                        validator:
                            RequiredValidator(errorText: "กรุณากรอกรหัสผ่าน"),
                        obscureText: true,
                        onSaved: (String? password) {
                          profile.password = password!;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.teal),
                        child: Text(
                          "เข้าสู่ระบบ",
                          style: GoogleFonts.itim(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            print(
                                "email = ${profile.email} password = ${profile.password}");
                            formKey.currentState!.reset();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return ResetScreen();
                        }));
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ลืมรหัสผ่าน?",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.archivo(
                                fontSize: 16,
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return RegisterScreen();
                                  }));
                                },
                                child: Center(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "สร้างบัญชีผู้ใช้",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.archivo(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
