//import 'dart:html';
//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medsapp_project/Models/dashbored_model.dart';
import 'package:medsapp_project/Screens/about_us.dart';
//import 'package:medsapp_project/Screens/Donate_medicine_form.dart';
import 'package:medsapp_project/Screens/altervatives.dart';
import 'package:medsapp_project/Screens/beautiful_cards.dart';
import 'package:medsapp_project/Screens/chat_screen.dart';
import 'package:medsapp_project/Screens/contact_us.dart';
import 'package:medsapp_project/Screens/donations.dart';
import 'package:medsapp_project/Screens/header_drawer.dart';
import 'package:medsapp_project/Screens/login_screen1.dart';
import 'package:medsapp_project/Screens/medicine_donation_form.dart';
import 'package:medsapp_project/Screens/on_boarding_screens.dart';
import 'package:medsapp_project/Screens/profile_page.dart';
import 'package:medsapp_project/Screens/search_donations_here.dart';
import 'package:medsapp_project/Screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:medsapp_project/Screens/signup_screen.dart';
// import 'package:medecine_donation_app/screens/alternative_medicine.dart';
// import 'package:medecine_donation_app/screens/chatgptscreeen.dart';
// import 'package:medecine_donation_app/screens/login.dart';
// import 'package:medecine_donation_app/screens/medicinedonationform.dart';
// import 'package:medecine_donation_app/screens/search_medicine.dart';

// import 'DonateMedecine.dart';

// import 'header_drawer.dart';

class Dashbored extends StatefulWidget {
  const Dashbored({Key? key}) : super(key: key);

  @override
  State<Dashbored> createState() => _DashboredState();
}

class _DashboredState extends State<Dashbored> {
  int _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Handle navigation or any other logic based on the selected index
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BeautifulCards();
        }));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UserProfilePage();
        }));
        break;
      // Add cases for other navigation options
    }
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          backgroundColor: Color(0xffF50057),
          // ignore: prefer_const_constructors
          title: Text('MeDsApp',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontFamily: 'Poppins'))),

      drawer: Drawer(
        // shadowColor: Colors.blue,
        backgroundColor: Colors.grey.shade200,
        // ignore: prefer_const_literals_to_create_immutables
        child: SingleChildScrollView(
            child: Column(
          children: [
            MyHeaderDrawer(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BeautifulCards()));
              },
            ),
            ListTile(
              leading: Icon(Icons.local_offer),
              title: Text(
                'Donations',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDonationsScreen()),
                );
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => DonateMedicine()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text(
                'About Us',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AboutUs();
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.mail),
              title: const Text(
                'Contact Us',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ContactUsScreen();
                }));
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.help_center),
            //   title: const Text('NeedMedicine'),
            //   onTap: () {},
            // ),
            ListTile(
              leading: const Icon(Icons.logout_sharp),
              title: const Text(
                'Logout',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              onTap: () async {
                _logout();

                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.clear();

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            //  ListTile(
            //  leading: const Icon(Icons.home),
            // title: const Text('Home'),
            // onTap: () {},
            // ),
          ],
        )),
      ),
      body: Container(
        color: Colors.grey.shade200,
        padding: EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: CircularBox(
                      color: Color(0xffF50057),
                      boxWidth: MediaQuery.of(context).size.width / 2 - 30,
                      boxHeight: MediaQuery.of(context).size.height / 2 - 30,
                      boxText: 'Donate Medicine',
                      icon: Icons.medical_services,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DonationForm();
                        }));
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: CircularBox(
                      color: Color(0xffF50057),
                      boxWidth: MediaQuery.of(context).size.width / 2 - 30,
                      boxHeight: MediaQuery.of(context).size.height / 2 - 30,
                      boxText: 'Find Donations',
                      icon: Icons.pan_tool,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FindDonationScreen();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: CircularBox(
                      color: Color(0xffF50057),
                      boxWidth: MediaQuery.of(context).size.width / 2 - 30,
                      boxHeight: MediaQuery.of(context).size.height / 2 - 30,
                      boxText: 'Find Alternatives',
                      icon: Icons.local_hospital,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MedicineSearchScreen();
                        }));
                      },
                    ),
                  ),
                  Flexible(
                    child: CircularBox(
                      color: Color(0xffF50057),
                      boxWidth: MediaQuery.of(context).size.width / 2 - 30,
                      boxHeight: MediaQuery.of(context).size.height / 2 - 30,
                      boxText: 'Chat Bot',
                      icon: Icons.message,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChatScreen();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ignore: prefer_const_constructors
      // body: Padding(
      //   padding:
      //       const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
      //   child: Expanded(
      //     child: Column(children: [
      //       Expanded(
      //         child: Container(
      //           // height: 100,
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //               color: Colors.grey.shade100,
      //               borderRadius: BorderRadius.circular(10)),
      //           child: Center(
      //             child: InkWell(
      //               child: Text(
      //                 'Donate Medicines',
      //                 style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
      //               ),
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => DonationForm()));
      //               },
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 30,
      //       ),
      //       Expanded(
      //         child: Container(
      //           // height: 100,
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //               color: Colors.grey.shade100,
      //               borderRadius: BorderRadius.circular(10)),
      //           child: Center(
      //             child: InkWell(
      //               child: Text(
      //                 'Find Donations Here',
      //                 style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
      //               ),
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => FindDonationScreen()));
      //               },
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 30,
      //       ),
      //       Expanded(
      //         child: Container(
      //           // height: 100,
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //               color: Colors.grey.shade100,
      //               borderRadius: BorderRadius.circular(10)),
      //           child: Center(
      //             child: InkWell(
      //               child: Text(
      //                 'Alternative of Medicines',
      //                 style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
      //               ),
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => MedicineSearchScreen()));
      //               },
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 30,
      //       ),
      //       Expanded(
      //         child: Container(
      //           // height: 100,
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //               color: Colors.grey.shade100,
      //               borderRadius: BorderRadius.circular(10)),
      //           child: Center(
      //             child: ProviderScope(
      //               child: InkWell(
      //                 child: Text(
      //                   'ChatBOT Any Query?',
      //                   style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
      //                 ),
      //                 onTap: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) => const ChatScreen()));
      //                 },
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ]),
      //   ),
      // ),
      bottomNavigationBar: Container(
        // height: 55,
        color: Color(0xffF50057),
        child: BottomNavigationBar(
            onTap: _onItemTapped,
            //backgroundColor: Color(0xffF50057)
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',

                // backgroundColor: Colors.blue
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(
              //     Icons.health_and_safety,
              //   ),
              //   label: '',

              //   //backgroundColor: Colors.blue
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Person',

                // backgroundColor: Colors.blue
              ),
            ]),
      ),
    );
  }

  Future<void> _logout() async {
    // Navigate to the login screen and remove all the routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => Dashbored()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => AboutUs()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => ContactUsScreen()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
      (route) => true,
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => OnboardingScreen()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => BeautifulCards()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => UserProfilePage()),
      (route) => false,
    );
    //  Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (BuildContext context) => ()),
    //   (route) => false,
    // );
    //  Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (BuildContext context) => ()),
    //   (route) => false,
    // );

    // Clear any saved user data or tokens if needed
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
