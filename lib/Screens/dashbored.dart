//import 'dart:html';
//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medsapp_project/Screens/about_us.dart';
//import 'package:medsapp_project/Screens/Donate_medicine_form.dart';
import 'package:medsapp_project/Screens/altervatives.dart';
import 'package:medsapp_project/Screens/chat_screen.dart';
import 'package:medsapp_project/Screens/header_drawer.dart';
import 'package:medsapp_project/Screens/medicine_donation_form.dart';
import 'package:medsapp_project/Screens/search_donations_here.dart';
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
  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          // ignore: prefer_const_constructors
          title: Text('MedsApp',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue))),

      drawer: Drawer(
        // shadowColor: Colors.blue,
        backgroundColor: Colors.blue,
        // ignore: prefer_const_literals_to_create_immutables
        child: SingleChildScrollView(
            child: Column(
          children: [
            MyHeaderDrawer(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => DonateMedicine()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_box_rounded),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AboutUs();
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
              title: const Text('Logout'),
              onTap: () {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => LoginScreen()));
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

      // ignore: prefer_const_constructors
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
        child: Expanded(
          child: Column(children: [
            Expanded(
              child: Container(
                // height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: InkWell(
                    child: Text(
                      'Donate Medicines',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DonationForm()));
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                // height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: InkWell(
                    child: Text(
                      'Find Donations Here',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FindDonationScreen()));
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                // height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: InkWell(
                    child: Text(
                      'Alternative of Medicines',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MedicineSearchScreen()));
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                // height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: ProviderScope(
                    child: InkWell(
                      child: Text(
                        'ChatBOT Any Query?',
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatScreen()));
                      },
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        // height: 55,
        // color: Colors.grey.shade100,
        child:
            BottomNavigationBar(backgroundColor: Colors.grey.shade100, items: [
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
            icon: Icon(Icons.settings),
            label: 'Setting',
            // backgroundColor: Colors.blue
          ),
        ]),
      ),
    );
  }
}
