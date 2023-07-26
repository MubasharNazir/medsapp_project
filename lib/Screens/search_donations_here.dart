// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:math' as math;

// import 'package:medsapp_project/Screens/detail_medicine.dart';
// import 'package:medsapp_project/widgets/custom_button.dart';

// class FindDonationScreen extends StatefulWidget {
//   @override
//   _FindDonationScreenState createState() => _FindDonationScreenState();
// }

// class _FindDonationScreenState extends State<FindDonationScreen> {
//   String searchQuery = '';
//   List<Medicine> medicines = [];
//   Position? userPosition;
//   // List<String> searchSuggestions = [];

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   void _getCurrentLocation() async {
//     final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
//     LocationPermission permission = await geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await geolocator.requestPermission();
//     }
//     if (permission == LocationPermission.whileInUse ||
//         permission == LocationPermission.always) {
//       Position position = await geolocator.getCurrentPosition();
//       setState(() {
//         userPosition = position;
//       });
//     }
//   }

//   // List<String> getSuggestions(String query) {
//   //   List<String> suggestions = [];
//   //   for (Medicine medicine in medicines) {
//   //     if (medicine.medicineName.toLowerCase().contains(query.toLowerCase())) {
//   //       suggestions.add(medicine.medicineName);
//   //     }
//   //   }
//   //   return suggestions;
//   // }

//   void _searchMedicine() {
//     print('Search query: $searchQuery');
//     FirebaseFirestore.instance
//         .collection('medicineinfo')
//         .where('medicineName', isEqualTo: searchQuery)
//         .get()
//         .then((snapshot) {
//       print('Firestore query executed successfully!');
//       print('Number of matching documents: ${snapshot.size}');
//       List<Medicine> matchingMedicines = [];
//       for (var doc in snapshot.docs) {
//         Medicine medicine = Medicine.fromFirestore(doc);
//         if (userPosition != null &&
//             medicine.latitude != null &&
//             medicine.longitude != null) {
//           double distance = calculateDistance(userPosition!.latitude,
//               userPosition!.longitude, medicine.latitude!, medicine.longitude!);
//           medicine.distance = distance;
//         }
//         matchingMedicines.add(medicine);
//         print('Matching medicines: $matchingMedicines');
//       }
//       print('Matching medicines: $matchingMedicines');
//       matchingMedicines
//           .sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

//       setState(() {
//         medicines = matchingMedicines;
//       });
//       // if (searchQuery.length >= 2 && searchQuery.length <= 3) {
//       //   List<String> suggestions = getSuggestions(searchQuery);
//       //   setState(() {
//       //     searchSuggestions = suggestions;
//       //   });
//       //}
//     });
//   }

//   double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
//     const int earthRadius = 6371; // in kilometers
//     double dLat = _toRadians(lat2 - lat1);
//     double dLon = _toRadians(lon2 - lon1);
//     double a = (math.sin(dLat / 2) * math.sin(dLat / 2)) +
//         (math.cos(_toRadians(lat1)) *
//             math.cos(_toRadians(lat2)) *
//             math.sin(dLon / 2) *
//             math.sin(dLon / 2));
//     double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
//     double distance = earthRadius * c;
//     return distance;
//   }

//   double _toRadians(double degrees) {
//     return degrees * (math.pi / 180);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       appBar: AppBar(
//         backgroundColor: Color(0xffF50057),
//         title: Text('Find Donation Here',
//             style: TextStyle(
//               fontFamily: 'Poppins',
//               color: Colors.white,
//             )),
//       ),
//       body: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               TextField(
//                 style: TextStyle(fontFamily: 'Poppins'),
//                 onChanged: (value) {
//                   setState(() {
//                     searchQuery = value;
//                   });
//                   // if (value.length >= 2 && value.length <= 3) {
//                   //   setState(() {
//                   //     searchQuery = value;
//                   //   });
//                   //}
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Search Medicine',
//                 ),
//               ),
//               Container(
//                 height: 50,
//                 width: double.infinity,
//                 child: CustomButton(
//                   onPressed: _searchMedicine,
//                   text: 'Search Donations',
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: medicines.length,
//                   itemBuilder: (context, index) {
//                     Medicine medicine = medicines[index];
//                     return ListTile(
//                       title: Text(medicine.medicineName),
//                       subtitle: Text('Distance: ${medicine.distance} km',
//                           style: TextStyle(fontFamily: 'Poppins')),
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return MedicineDetailsScreen(medicine: medicine);
//                         }));
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Medicine {
//   final String medicineName;
//   String? medicineType;
//   String? medicineCondition;
//   String? medicineExpiryDate;
//   String? medicineDescription;
//   String? medicineAddress;
//   String? phoneNumber;
//   String? medicineQuantity;

//   final double? latitude;
//   final double? longitude;
//   double? distance;

//   Medicine(
//       {required this.medicineName,
//       this.medicineType,
//       this.latitude,
//       this.longitude,
//       this.distance,
//       this.medicineAddress,
//       this.medicineCondition,
//       this.medicineDescription,
//       this.medicineExpiryDate,
//       this.medicineQuantity,
//       this.phoneNumber});
//   factory Medicine.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return Medicine(
//       medicineName: data['medicineName'],
//       latitude: (data['latitude'] is num)
//           ? (data['latitude'] as num).toDouble()
//           : null,
//       longitude: (data['longitude'] is num)
//           ? (data['longitude'] as num).toDouble()
//           : null,
//       medicineType: data['medicineType'],
//       medicineAddress: data['medicineAddress'],
//       medicineCondition: data['medicineCondition'],
//       medicineDescription: data['medicineDescription'],
//       medicineExpiryDate: data['medicineExpiryDate'],
//       medicineQuantity: data['medicineQuantity'],
//       phoneNumber: data['phoneNumber'],
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;

import 'package:medsapp_project/Screens/detail_medicine.dart';
import 'package:medsapp_project/widgets/custom_button.dart';
//import 'package:medsapp_project/widgets/custom_button.dart';

class FindDonationScreen extends StatefulWidget {
  @override
  _FindDonationScreenState createState() => _FindDonationScreenState();
}

class _FindDonationScreenState extends State<FindDonationScreen> {
  String searchQuery = '';
  List<Medicine> medicines = [];
  Position? userPosition;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
    LocationPermission permission = await geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await geolocator.getCurrentPosition();
      setState(() {
        userPosition = position;
      });
    }
  }

  void _searchMedicine() {
    print('Search query: $searchQuery');
    FirebaseFirestore.instance
        .collection('medicineinfo')
        .where('medicineName', isGreaterThanOrEqualTo: searchQuery)
        .where('medicineName', isLessThanOrEqualTo: searchQuery + '\uf8ff')
        .get()
        .then((snapshot) {
      print('Firestore query executed successfully!');
      print('Number of matching documents: ${snapshot.size}');
      List<Medicine> matchingMedicines = [];
      for (var doc in snapshot.docs) {
        Medicine medicine = Medicine.fromFirestore(doc);
        if (userPosition != null &&
            medicine.latitude != null &&
            medicine.longitude != null) {
          double distance = calculateDistance(userPosition!.latitude,
              userPosition!.longitude, medicine.latitude!, medicine.longitude!);
          medicine.distance = distance;
        }
        matchingMedicines.add(medicine);
      }
      matchingMedicines
          .sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

      setState(() {
        medicines = matchingMedicines;
      });
    });
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        searchQuery = value.toLowerCase();
      });
      if (value.length >= 2 && value.length <= 5) {
        _searchMedicine();
      }
    });
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const int earthRadius = 6371; // in kilometers
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    double a = (math.sin(dLat / 2) * math.sin(dLat / 2)) +
        (math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2));
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    double distance = earthRadius * c;
    return distance;
  }

  double _toRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0xffF50057),
        title: Text(
          'Find Donation Here',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16),
                child: TextField(
                  style: TextStyle(fontFamily: 'Poppins'),
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search Medicine',
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: CustomButton(
                  onPressed: _searchMedicine,
                  text: 'Search Donations',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                  child: medicines.isNotEmpty
                      ? ListView.builder(
                          itemCount: medicines.length,
                          itemBuilder: (context, index) {
                            Medicine medicine = medicines[index];
                            return ListTile(
                              title: Text(medicine.medicineName),
                              subtitle: Text(
                                  'Distance: ${medicine.distance} km',
                                  style: TextStyle(fontFamily: 'Poppins')),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return MedicineDetailsScreen(
                                      medicine: medicine);
                                }));
                              },
                            );
                          },
                        )
                      : Center(
                          child: Text(
                          'No Donation Available Regarding Search',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ))),
            ],
          ),
        ),
      ),
    );
  }
}

class Medicine {
  final String medicineName;
  String? medicineType;
  String? medicineCondition;
  String? medicineExpiryDate;
  String? medicineDescription;
  String? medicineAddress;
  String? phoneNumber;
  String? medicineQuantity;

  final double? latitude;
  final double? longitude;
  double? distance;

  Medicine(
      {required this.medicineName,
      this.medicineType,
      this.latitude,
      this.longitude,
      this.distance,
      this.medicineAddress,
      this.medicineCondition,
      this.medicineDescription,
      this.medicineExpiryDate,
      this.medicineQuantity,
      this.phoneNumber});
  factory Medicine.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Medicine(
      medicineName: data['medicineName'],
      latitude: (data['latitude'] is num)
          ? (data['latitude'] as num).toDouble()
          : null,
      longitude: (data['longitude'] is num)
          ? (data['longitude'] as num).toDouble()
          : null,
      medicineType: data['medicineType'],
      medicineAddress: data['medicineAddress'],
      medicineCondition: data['medicineCondition'],
      medicineDescription: data['medicineDescription'],
      medicineExpiryDate: data['medicineExpiryDate'],
      medicineQuantity: data['medicineQuantity'],
      phoneNumber: data['phoneNumber'],
    );
  }
}
