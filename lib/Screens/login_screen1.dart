//import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medsapp_project/Screens/dashbored.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_button.dart';
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
                      height: 250,
                      child: Image.asset(
                        'assets/images/logo2.png',
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(right: 0.65),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
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
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'email',
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
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'password',
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: CustomButton(
                    // child: Text('Login'),
                    onPressed: () async {
                      SignIn(emailController.text, passwordController.text);
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString(
                          'email', emailController.text);
                    },
                    text: 'LOG IN',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    children: [
                      Text('dont have an account?'),
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
                                color: Colors.blue,
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
                    MaterialPageRoute(builder: (context) => Dashbored()))
              })
          // ignore: body_might_complete_normally_catch_error
          .catchError((error) {
        Fluttertoast.showToast(msg: error!.message);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUP()));
      });
    }
  }
}
