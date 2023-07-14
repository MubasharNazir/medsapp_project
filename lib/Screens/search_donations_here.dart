import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;

class FindDonationScreen extends StatefulWidget {
  @override
  _FindDonationScreenState createState() => _FindDonationScreenState();
}

class _FindDonationScreenState extends State<FindDonationScreen> {
  String searchQuery = '';
  List<Medicine> medicines = [];
  Position? userPosition;

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
        .where('medicineName', isEqualTo: searchQuery)
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
      matchingMedicines.sort((a, b) => a.distance!.compareTo(b.distance!));
      setState(() {
        medicines = matchingMedicines;
      });
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
      appBar: AppBar(
        title: Text('Find Donation'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search Medicine',
            ),
          ),
          ElevatedButton(
            onPressed: _searchMedicine,
            child: Text('Search'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                Medicine medicine = medicines[index];
                return ListTile(
                  title: Text(medicine.medicineName),
                  subtitle: Text('Distance: ${medicine.distance} km'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Medicine {
  final String medicineName;
  final double? latitude;
  final double? longitude;
  double? distance;

  Medicine({
    required this.medicineName,
    this.latitude,
    this.longitude,
    this.distance,
  });

  factory Medicine.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Medicine(
      medicineName: data['medicineName'],
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  }
}
