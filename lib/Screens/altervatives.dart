import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine1 {
  final String? id;
  String? name;
  String? activeIngredient;
  //final String size;

  Medicine1({
    this.id,
    this.name,
    this.activeIngredient,
    //required this.size,
  });

  factory Medicine1.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Medicine1(
      id: document.id,
      name: data['name'],
      activeIngredient: data['activeIngredient'],
      // size: data['size'],
    );
  }
}

class MedicineSearchScreen extends StatefulWidget {
  @override
  _MedicineSearchScreenState createState() => _MedicineSearchScreenState();
}

class _MedicineSearchScreenState extends State<MedicineSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Medicine1> _alternativeMedicines = [];

  Future<void> _searchMedicine() async {
    String searchedMedicineName = _searchController.text.trim().toLowerCase();

    if (searchedMedicineName.isNotEmpty) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('medicines')
            .where('name', isEqualTo: searchedMedicineName)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          String activeIngredient =
              querySnapshot.docs.first['activeIngredient'];

          QuerySnapshot alternativeSnapshot = await FirebaseFirestore.instance
              .collection('medicines')
              //.where('name', isNotEqualTo: searchedMedicineName)
              .where('activeIngredient', isEqualTo: activeIngredient)
              .get();

          setState(() {
            // _alternativeMedicines = alternativeSnapshot.docs.map((data) {
            //   return Medicine.fromSnapshot(
            //       data as DocumentSnapshot<Map<String, dynamic>>);
            // }).toList();
            _alternativeMedicines = alternativeSnapshot.docs
                .map((data) => Medicine1.fromSnapshot(
                    data as DocumentSnapshot<Map<String, dynamic>>))
                .toList();
            _alternativeMedicines.removeWhere(
                (medicine) => medicine.name == searchedMedicineName);
          });
        } else {
          setState(() {
            _alternativeMedicines = [];
          });
        }
      } catch (e) {
        print('Error: something went wrong ${e.toString()}');
      }
    } else {
      setState(() {
        _alternativeMedicines = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
        title: Text(
          'Check Alternative Here',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: 'Search Medicine',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _searchMedicine,
                    // color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none)),
            ),
            SizedBox(height: 16),
            Text(
              'Alternative Medicines:',
              //textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _alternativeMedicines.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_alternativeMedicines[index].name.toString()),
                    subtitle: Text(_alternativeMedicines[index]
                        .activeIngredient
                        .toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
