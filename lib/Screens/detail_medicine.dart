import 'package:flutter/material.dart';
import 'package:medsapp_project/Screens/dashbored.dart';
//import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:medsapp_project/Screens/search_donations_here.dart';
import 'package:medsapp_project/widgets/custom_button.dart';

class MedicineDetailsScreen extends StatelessWidget {
  final Medicine medicine;

  MedicineDetailsScreen({required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('Medicine Details',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xffF50057),
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Medicine Name:',
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                      SizedBox(width: 30.0), // Adjust the spacing as needed
                      Text(
                        medicine.medicineName,
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Medicine Type:',
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                      SizedBox(width: 30.0), // Adjust the spacing as needed
                      Text(
                        medicine.medicineType.toString().trim(),
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Medicine Expiry Date:',
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                      SizedBox(width: 30.0), // Adjust the spacing as needed
                      Text(
                        medicine.medicineExpiryDate.toString(),
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Medicine Condition:',
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                      SizedBox(width: 30.0), // Adjust the spacing as needed
                      Text(
                        medicine.medicineCondition.toString(),
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Medicine Quantity:',
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                      SizedBox(width: 30.0), // Adjust the spacing as needed
                      Text(
                        medicine.medicineQuantity.toString(),
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Size in mg/ml:',
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                      SizedBox(width: 30.0), // Adjust the spacing as needed
                      Text(
                        medicine.medicineDescription.toString(),
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address :',
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                      //SizedBox(width: 30.0), // Adjust the spacing as needed
                      Text(
                        medicine.medicineAddress.toString(),
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Contact No:',
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                      SizedBox(width: 30.0), // Adjust the spacing as needed
                      Text(
                        medicine.phoneNumber.toString(),
                        style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  child: CustomButton(
                      text: 'Go BacK',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Dashbored();
                        }));
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
