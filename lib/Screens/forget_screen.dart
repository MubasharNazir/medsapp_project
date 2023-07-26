import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medsapp_project/widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xffF50057),
        title: Text(
          'Forgot Password',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              TextField(
                style: TextStyle(fontFamily: 'Poppins'),
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Enter Email'),
              ),
              SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  _resetPassword();
                },
                text: 'Reset Password',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _resetPassword() async {
    try {
      final String email = _emailController.text.trim();

      // Send password reset email to the user
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // Show a success message to the user
      Fluttertoast.showToast(
        msg: 'Password reset email sent. Check your inbox.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );

      // Navigate back to the login screen after resetting password
      Navigator.pop(context);
    } catch (e) {
      // Show an error message to the user
      Fluttertoast.showToast(
        msg: 'Error: ${e.toString()}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
}
