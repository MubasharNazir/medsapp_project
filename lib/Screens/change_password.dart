import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medsapp_project/Screens/login_screen1.dart';
import 'package:medsapp_project/widgets/custom_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xffF50057),
        title: Text('Change Password'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontFamily: 'Poppins'),
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Current Password', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(fontFamily: 'Poppins'),
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'New Password', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                _changePassword();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
              text: 'Change Password',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changePassword() async {
    try {
      final String currentPassword = _currentPasswordController.text.trim();
      final String newPassword = _newPasswordController.text.trim();

      // Get the current user to reauthenticate
      User? user = FirebaseAuth.instance.currentUser;

      // Create a credential with the current email and password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      // Reauthenticate the user
      await user.reauthenticateWithCredential(credential);

      // Update the user's password
      await user.updatePassword(newPassword);

      // Show a success message to the user
      Fluttertoast.showToast(
        msg: 'Password changed successfully.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );

      // Navigate back to the previous screen
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
