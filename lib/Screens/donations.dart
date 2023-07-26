import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDonationsScreen extends StatefulWidget {
  @override
  State<UserDonationsScreen> createState() => _UserDonationsScreenState();
}

class _UserDonationsScreenState extends State<UserDonationsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print('User ID: ${user?.uid}');
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF50057),
          title:
              Text('Your Donations', style: TextStyle(fontFamily: 'Poppins')),
        ),
        body: Center(
          child: Text('Please login to view your donations.',
              style: TextStyle(fontFamily: 'Poppins')),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      //backgroundColor: Color(0xffF50057),
      appBar: AppBar(
        backgroundColor: Color(0xffF50057),
        title: Text('Your Donations', style: TextStyle(fontFamily: 'Poppins')),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('medicineinfo')
            .where('userID', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('Error: ${snapshot.error}');
            print('hello');
            final donations = snapshot.data!.docs;
            if (donations.isEmpty) {
              print('Error: ${snapshot.error}');
              print('hello');
              return Center(
                child: Text('No donations found.',
                    style: TextStyle(fontFamily: 'Poppins')),
              );
            }
            return ListView.builder(
              itemCount: donations.length,
              itemBuilder: (context, index) {
                final donation =
                    donations[index].data() as Map<String, dynamic>;
                final donationId = donations[index].id;
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    //margin: EdgeInsets.all(20),

                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Medicine Name:',
                                    style: TextStyle(
                                      //  fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    )),
                                Text(donation['medicineName'],
                                    style: TextStyle(
                                      //  fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    )),
                              ],
                            )),
                        SizedBox(height: 0),
                        Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Medicine Type:',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      //  fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    )),
                                Text(donation['medicineType'],
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      //  fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    )),
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                'Remove Donation:',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(

                                // width: 10.0,
                                ),
                            Container(
                              padding: EdgeInsets.only(left: 10, bottom: 10),
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Delete Donation',
                                          style:
                                              TextStyle(fontFamily: 'Poppins'),
                                        ),
                                        content: Text(
                                            'Are you sure you want to delete this donation?',
                                            style: TextStyle(
                                                fontFamily: 'Poppins')),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins')),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Delete',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins')),
                                            onPressed: () async {
                                              // Delete the donation from Firestore
                                              await FirebaseFirestore.instance
                                                  .collection('medicineinfo')
                                                  .doc(donationId)
                                                  .delete();

                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    // Display other fields...
                  ),
                );
              },
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading donations.',
                  style: TextStyle(fontFamily: 'Poppins')),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
