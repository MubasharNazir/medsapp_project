import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF50057),
        title: Text(
          'Contact Us',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'For any inquiries or support, please feel free to reach out to us:',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(
                'Email',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              subtitle: Text(
                'info@meddonationapp.com',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              onTap: () {
                // TODO: Implement email functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(
                'Phone',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              subtitle: Text(
                '+92 305-7923392',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              onTap: () {
                // TODO: Implement phone functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                'Address',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              subtitle: Text('223 Main Street, Gujranwala, Pakistan',
                  style: TextStyle(fontFamily: 'Poppins')),
              onTap: () {
                // TODO: Implement map integration
              },
            ),
          ],
        ),
      ),
    );
  }
}
