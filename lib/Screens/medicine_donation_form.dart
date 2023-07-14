import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
//import 'package:medsapp_project/Screens/dashbored.dart';
//import 'package:medsapp_project/Models/medicine_form_model.dart';
//import 'package:medsapp_project/Screens/login_screen1.dart';
//import 'package:medsapp_project/Models/medicine_form_model.dart';
import 'package:medsapp_project/widgets/custom_button.dart';

//import '../Models/medicine_form_model.dart';

class DonationForm extends StatefulWidget {
  const DonationForm({super.key});

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  String? _currentAddress;
  Position? _currentPosition;

  final medicineName = TextEditingController();
  final medicineType = TextEditingController();
  final medicineAddress = TextEditingController();
  final medicineExpiryDate = TextEditingController();
  final medicineQuantity = TextEditingController();
  final phoneNumber = TextEditingController();
  final medicineDescription = TextEditingController();
  final medicineCondition = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  /// final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  String? _selectedValue;
  List<String> listOfValue = [
    'above 6 months',
    'above 1 year',
    'above 2 years'
  ];
  String? _selectedValue2;
  List<String> listOfValue2 = ['New', 'Good', 'old but able to use'];
  String? _selectedValue1;
  List<String> listOfValue1 = [
    'Syrup',
    'Tablet',
    'Injection',
    'Capsule',
    'Inhalers',
    'Creams and Ointments',
    'others'
  ];
  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Donation Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: medicineName,
                      decoration: InputDecoration(
                        labelText: 'Medicine Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "can't empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      color: Colors.white,
                      child: DropdownButtonFormField(
                        value: _selectedValue1,
                        hint: Text(
                          'Medicine Type',
                        ),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue1 = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            _selectedValue1 = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "can't empty";
                          } else {
                            return null;
                          }
                        },
                        items: listOfValue1.map((String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                            ),
                          );
                        }).toList(),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      color: Colors.white,
                      child: DropdownButtonFormField(
                        value: _selectedValue,
                        hint: Text(
                          'Medicine Expiry Date',
                        ),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "can't empty";
                          } else {
                            return null;
                          }
                        },
                        items: listOfValue.map((String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                            ),
                          );
                        }).toList(),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      color: Colors.white,
                      child: DropdownButtonFormField(
                        value: _selectedValue2,
                        hint: Text(
                          'Medicine condition',
                        ),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue2 = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            _selectedValue2 = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "can't empty";
                          } else {
                            return null;
                          }
                        },
                        items: listOfValue2.map((String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                            ),
                          );
                        }).toList(),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: medicineQuantity,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Medicine Quantity',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "can't empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: medicineDescription,
                      decoration: InputDecoration(
                          hintText: 'enter medicine size in mg/ml',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "can't empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      minLines: 3,
                      controller: medicineAddress,
                      maxLines: 4,
                      // keyboardType: TextInputType.number,
                      //inputFormatters: [
                      // FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      //],
                      decoration: InputDecoration(
                        hintText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "can't empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: IntlPhoneField(
                      controller: phoneNumber,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      initialCountryCode: 'PK',
                      validator: (value) {
                        if (value == null) {
                          return "can't empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: CustomButton(
                          text: 'Submit Form',
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              _getCurrentPosition();
                              Map<String, dynamic> donationmodel = {
                                //'uid': uid,
                                'userID': user?.uid,
                                'medicineName':
                                    medicineName.text.toString().trim(),
                                'medicineType':
                                    _selectedValue1.toString().trim(),
                                'medicineExpiryDate':
                                    _selectedValue.toString().trim(),
                                'medicineCondition':
                                    _selectedValue2.toString().trim(),
                                'medicineAddress':
                                    medicineAddress.text.toString().trim(),
                                'medicineDescription':
                                    medicineDescription.text.toString().trim(),
                                'medicineQuantity':
                                    medicineQuantity.text.toString().trim(),
                                'phoneNumber':
                                    phoneNumber.text.toString().trim(),
                                'latitude':
                                    _currentPosition!.latitude.toDouble(),

                                'longitude':
                                    _currentPosition!.longitude.toDouble(),

                                'address': _currentAddress.toString().trim(),
                              };

                              await FirebaseFirestore.instance
                                  .collection('medicineinfo')
                                  .doc()
                                  .set(donationmodel);
                              //
                              //
                              //

                              setState(() {});
                            }
                          }))
                ],
              )),
        ),
      ),
    );
  }

  //Future<void> postMedicinesDetail() async {
  //_getCurrentPosition();
  //final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //User? user = _auth.currentUser;
  // DonationModel donationModel = DonationModel();
  // donationModel.medicineName = medicineName.text.toString().trim();
  // donationModel.medicineType = _selectedValue1?.trim().toString();
  // donationModel.medicineExpiryDate = _selectedValue?.trim().toString();
  // donationModel.medicineQuantity = medicineQuantity.text.trim().toString();
  // donationModel.medicineDescription =
  //     medicineDescription.text.trim().toString();
  // donationModel.medicineAddress = medicineAddress.text.trim().toString();
  // donationModel.medicineCondition = _selectedValue2?.trim().toString();
  // donationModel.phoneNumber = phoneNumber.text.trim().toString();

  // donationModel.uid = user?.uid;
  //_getCurrentPosition();
  // Map<String, dynamic> donationmodel = {
  //   //'uid': uid,

  //   'medicineName': medicineName,
  //   'medicineType': medicineType,
  //   'medicineExpiryDate': medicineExpiryDate,
  //   'medicineCondition': medicineCondition,
  //   'medicineAddress': medicineAddress,
  //   'medicineDescription': medicineDescription,
  //   'medicineQuantity': medicineQuantity,
  //   'phoneNumber': phoneNumber,
  //   'latitude': _currentPosition!.latitude.toString().trim(),
  //   'longitude': _currentPosition!.longitude.toString().trim(),
  //   //'address': _currentAddress.toString().trim(),
  // };

  // await FirebaseFirestore.instance
  //     .collection('medicineData')
  //     .doc()
  //     .set(donationmodel);
  // setState(() {});

  // Navigator.push(
  //     context, MaterialPageRoute(builder: (context) => Dashbored()));
  // }
}
