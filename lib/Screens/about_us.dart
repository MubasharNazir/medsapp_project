import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xffF50057),
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Column(children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Your Story',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Poppins'),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Once upon a time, in a world where access to medicine was a challenge for many, a group of passionate individuals came together to make a difference. They believed that every individual deserved access to life-saving medication, regardless of their financial circumstances. Thus, the Medicine Donation App was born.',
              style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Your Mission',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Poppins'),
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Text(
            '1:Our Mission: To provide essential medicines to those in need and make a positive impact on the health and well-being of communities.',
            style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '2:At Medicine Donation Mission,our goal is to bridge the gap in access to healthcare by collecting and distributing donated medicines to underserved areas.',
            style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '3:We believe that everyone should have access to life-saving medications. Our mission is to ensure that no one goes without essential medicines due to financial constraints',
            style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          // Container(
          //     alignment: Alignment.topLeft,
          //     child: Text(
          //       'Contact Info',
          //       style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.bold,
          //           fontFamily: 'Poppins'),
          //     )),
          // SizedBox(
          //   height: 20,
          // ),
          // Container(
          //     alignment: Alignment.topLeft,
          //     child: Row(
          //       children: [
          //         Text(
          //           'Email:',
          //           style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 16,
          //               fontFamily: 'Poppins'),
          //         ),
          //         Text(
          //           'engr.mubasharnazir@gmail.com',
          //           style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          //         ),
          //       ],
          //     )),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     alignment: Alignment.topLeft,
          //     child: Row(
          //       children: [
          //         Text(
          //           'Phone:',
          //           style: TextStyle(
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold,
          //               fontFamily: 'Poppins'),
          //         ),
          //         Text(
          //           '+92 3057923392',
          //           style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          //         ),
          //       ],
          //     )),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     alignment: Alignment.topLeft,
          //     child: Row(
          //       children: [
          //         Text('Website:',
          //             style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold,
          //                 fontFamily: 'Poppins')),
          //         Text('www.medicinedonationmission.org',
          //             style: TextStyle(fontSize: 16, fontFamily: 'Poppins')),
          //       ],
          //     )),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     alignment: Alignment.topLeft,
          //     child: Row(
          //       children: [
          //         Text('Facebook: ',
          //             style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold,
          //                 fontFamily: 'Poppins')),
          //         Text('www.facebook.com/  \n medicinedonationmission',
          //             style: TextStyle(fontSize: 16, fontFamily: 'Poppins')),
          //       ],
          //     )),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     alignment: Alignment.topLeft,
          //     child: Row(
          //       children: [
          //         Text('Instagram:',
          //             style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold,
          //                 fontFamily: 'Poppins')),
          //         Text(' www.instagram.com \n medicinedonationmission',
          //             style: TextStyle(fontSize: 16, fontFamily: 'Poppins')),
          //       ],
          //     )),
        ]),
      ),
    );
  }
}
