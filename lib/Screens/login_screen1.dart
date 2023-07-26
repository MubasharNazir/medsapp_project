//import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medsapp_project/Screens/beautiful_cards.dart';
import 'package:medsapp_project/Screens/forget_screen.dart';
//import 'package:medsapp_project/Screens/dashbored.dart';
//import 'package:medsapp_project/Screens/home_screen.dart';
//import 'package:medsapp_project/Screens/lets_go_screen.dart';
import 'package:medsapp_project/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../widgets/custom_button.dart';
//import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        backgroundColor: Color(0xffF50057),
        title: Text(
          '        MeDsApp',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: h * 0.07, left: w * 0.07, right: w * 0.07),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                    child: Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.only(right: w * 0.56),
                    //   child: Text(
                    //     'MedsApp',
                    //     style: TextStyle(
                    //         color: Colors.blue,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 18),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Container(
                      height: 170,
                      child: Image.asset(
                        'assets/images/7.png',
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(right: 0.65),
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xffF50057),
                            //color: Colors.black
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                )),
                Container(
                  // color: Colors.grey.shade200,
                  child: TextFormField(
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        // labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter the email';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Please enter the valid email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  //color: Colors.grey.shade200,
                  child: TextFormField(
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        // labelText: 'password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      RegExp regex = new RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (value == null || value.isEmpty) {
                        return 'Enter the password';
                      }
                      if (!regex.hasMatch(value)) {
                        return 'Enter the Valid Password';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xffF50057),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ForgotPasswordScreen();
                      }));
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  // color: Color(0xffF50057),
                  child: CustomButton(
                    // child: Text('Login'),
                    onPressed: () async {
                      SignIn(emailController.text, passwordController.text);
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString(
                          'email', emailController.text);
                    },
                    text: 'SIGN IN',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUP()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Color(0xffF50057),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void SignIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: 'Login SuccessFully'),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BeautifulCards()))
              })
          // ignore: body_might_complete_normally_catch_error
          .catchError((error) {
        Fluttertoast.showToast(msg: error!.message);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) {
        //   return
        // }));
      });
    }
  }
}
