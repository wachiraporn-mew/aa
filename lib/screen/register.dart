import 'package:cornnapp/model/profile.dart';
import 'package:cornnapp/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(
    email: '',
    password: '',
  );
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "สร้างบัญชีผู้สมัคร",
                  style: GoogleFonts.itim(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("อีเมล", style: TextStyle(fontSize: 16)),
                          TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(errorText: "กรุณากรอกอีเมล"),
                                EmailValidator(
                                    errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String? email) {
                                profile.email = email!;
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Text("รหัสผ่าน", style: TextStyle(fontSize: 16)),
                          TextFormField(
                              validator: RequiredValidator(
                                  errorText: "กรุณากรอกรหัสผ่าน"),
                              obscureText: true,
                              onSaved: (String? password) {
                                profile.password = password!;
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Text("ชื่อ-สกุล", style: TextStyle(fontSize: 16)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณากรอกชื่อ-สกุล"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("ที่อยู่", style: TextStyle(fontSize: 16)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณากรอกที่อยู่"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("เบอร์โทร", style: TextStyle(fontSize: 16)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณากรอกเบอร์โทร"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(100, 20, 100, 0),
                              child: ElevatedButton(
                                child: Text(
                                  "ลงทะเบียน",
                                  style: GoogleFonts.itim(
                                    fontSize: 26,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    try {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: profile.email,
                                              password: profile.password)
                                          .then((value) {
                                        formKey.currentState!.reset();
                                        Fluttertoast.showToast(
                                            msg:
                                                "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
                                            gravity: ToastGravity.TOP);
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return HomeScreen();
                                        }));
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      print(e.code);
                                      String message;
                                      if (e.code == 'email-already-in-use') {
                                        message =
                                            "มีอีเมลนี้ในระบบแล้ว โปรดใช้อีเมลอื่น";
                                      } else if (e.code == 'weak-password') {
                                        message =
                                            "รหัสผ่านต้องมีความยาว 6 ตัวอักษรขี้นไป";
                                      } else {
                                        message = e.message!;
                                      }
                                      Fluttertoast.showToast(
                                          msg: message,
                                          gravity: ToastGravity.CENTER);
                                    }
                                  }
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
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
