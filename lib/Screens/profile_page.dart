// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'package:medsapp_project/Screens/about_us.dart';
// import 'package:medsapp_project/Screens/beautiful_cards.dart';
// import 'package:medsapp_project/Screens/contact_us.dart';
// import 'package:medsapp_project/Screens/dashbored.dart';
// import 'package:medsapp_project/Screens/login_screen1.dart';
// import 'package:medsapp_project/Screens/on_boarding_screens.dart';
// import 'package:medsapp_project/Screens/splash_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../Models/user_model.dart';

// class UserProfilePage extends StatefulWidget {
//   const UserProfilePage({super.key});

//   @override
//   State<UserProfilePage> createState() => _UserProfilePageState();
// }

// class _UserProfilePageState extends State<UserProfilePage> {
//   User? user = FirebaseAuth.instance.currentUser;
//   UserModel LoggedInUser = UserModel();

//   @override
//   void initState() {
//     super.initState();
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(user!.uid)
//         .get()
//         .then((value) {
//       print('hello');
//       this.LoggedInUser = UserModel.fromMap(value.data());
//       print(e.toString());
//       setState(() {
//         // LoggedInUser = user as UserModel;
//         print('heelo dear');
//       });
//     });
//   }

//   Future<void> _logout() async {
//     // Navigate to the login screen and remove all the routes
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
//       (route) => false,
//     );
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (BuildContext context) => Dashbored()),
//       (route) => false,
//     );
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (BuildContext context) => AboutUs()),
//       (route) => false,
//     );
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (BuildContext context) => ContactUsScreen()),
//       (route) => false,
//     );
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
//       (route) => false,
//     );
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
//       (route) => true,
//     );
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (BuildContext context) => OnboardingScreen()),
//       (route) => false,
//     );
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (BuildContext context) => BeautifulCards()),
//       (route) => false,
//     );
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (BuildContext context) => UserProfilePage()),
//       (route) => false,
//     );
//     //  Navigator.pushAndRemoveUntil(
//     //   context,
//     //   MaterialPageRoute(builder: (BuildContext context) => ()),
//     //   (route) => false,
//     // );
//     //  Navigator.pushAndRemoveUntil(
//     //   context,
//     //   MaterialPageRoute(builder: (BuildContext context) => ()),
//     //   (route) => false,
//     // );

//     // Clear any saved user data or tokens if needed
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xffF50057),
//         title: Text('User Profile'),
//       ),
//       body: Container(
//         margin: EdgeInsets.only(top: 20),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 40,
//             ),
//             Center(
//                 child: Text(
//               'Welcome Back To MedsApp',
//               style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
//             )),
//             SizedBox(
//               height: 30,
//             ),
//             Container(
//               // alignment: Alignment.topLeft,
//               child: CircleAvatar(
//                 radius: 80,
//                 backgroundImage: AssetImage('assets/images/1.png'),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               '${LoggedInUser.firstName} ${LoggedInUser.secondName}',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 22,
//                   fontFamily: 'Poppins'),
//             ),
//             Text(
//               '${LoggedInUser.email}',
//               style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
//             ),
//             SizedBox(
//               height: 100,
//             ),
//             Container(
//               padding: EdgeInsets.only(left: 20),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.logout),
//                     onPressed: () async {
//                       _logout();
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return LoginScreen();
//                       }));
//                     },
//                   ),
//                   SizedBox(
//                     width: 2,
//                   ),
//                   Text(
//                     'Logout',
//                     style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medsapp_project/Models/user_model.dart';
import 'package:medsapp_project/Screens/change_password.dart';
import 'package:medsapp_project/Screens/login_screen1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      if (userSnapshot.exists) {
        setState(() {
          loggedInUser = UserModel.fromMap(userSnapshot.data()!);
        });
      } else {
        print("User data not found in Firestore.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _logout() async {
    // Clear any saved user data or tokens if needed
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    // Navigate to the login screen and remove all the routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF50057),
        title: Text('User Profile'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                'Welcome Back To MedsApp',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              // alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/1.png'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${loggedInUser.firstName} ${loggedInUser.secondName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              '${loggedInUser.email}',
              style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () async {
                      _logout();
                    },
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.lock_open),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChangePasswordScreen();
                      }));
                    },
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    'Change Password',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
