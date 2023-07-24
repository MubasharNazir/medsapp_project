import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Your Mission',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '1:Our Mission: To provide essential medicines to those in need and make a positive impact on the health and well-being of communities.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '2:At Medicine Donation Mission,our goal is to bridge the gap in access to healthcare by collecting and distributing donated medicines to underserved areas.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '3:We believe that everyone should have access to life-saving medications. Our mission is to ensure that no one goes without essential medicines due to financial constraints',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Contact Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    'Email:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Email: engr.mubasharnazir@gmail.com'),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    'Phone:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '+92 3057923392',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text('Website:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('www.medicinedonationmission.org',
                      style: TextStyle(fontSize: 16)),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.topLeft,
              child: Text('Facebook: www.facebook.com/medicinedonationmission',
                  style: TextStyle(fontSize: 16))),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                  'Instagram: www.instagram.com medicinedonationmission',
                  style: TextStyle(fontSize: 16))),
        ]),
      ),
    );
  }
}
