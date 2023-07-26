import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  final String? id;
  final String name;
  final String activeIngredient;

  Medicine({
    this.id,
    required this.name,
    required this.activeIngredient,
  });

  factory Medicine.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Medicine(
      id: document.id,
      name: data['name'],
      activeIngredient: data['activeIngredient'],
    );
  }
}

class MedicineSearchScreen extends StatefulWidget {
  @override
  _MedicineSearchScreenState createState() => _MedicineSearchScreenState();
}

class _MedicineSearchScreenState extends State<MedicineSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Medicine> _alternativeMedicines = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _searchMedicine(_searchController.text.trim().toLowerCase());
  }

  Future<void> _searchMedicine(String searchTerm) async {
    if (searchTerm.isNotEmpty) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('medicines')
            .where('name', isGreaterThanOrEqualTo: searchTerm.toLowerCase())
            .where('name', isLessThan: searchTerm + 'z')
            //.where('name', isEqualTo: searchTerm)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          String activeIngredient =
              querySnapshot.docs.first['activeIngredient'];

          QuerySnapshot alternativeSnapshot = await FirebaseFirestore.instance
              .collection('medicines')
              .where('activeIngredient', isEqualTo: activeIngredient)
              .get();

          setState(() {
            _alternativeMedicines = alternativeSnapshot.docs
                .map((data) => Medicine.fromSnapshot(
                    data as DocumentSnapshot<Map<String, dynamic>>))
                .toList();
            _alternativeMedicines.removeWhere(
                (medicine) => medicine.name == searchTerm.toLowerCase().trim());
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

  void _selectSuggestion(Medicine medicine) {
    setState(() {
      _searchController.text = medicine.name.toLowerCase().trim();
      _alternativeMedicines
          .clear(); // Clear the suggestion list when a suggestion is selected.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF50057),
        title: Text(
          'Check Alternative Here',
          style: TextStyle(fontFamily: 'Poppins'
              // color: Colors.white,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: TextField(
                style: TextStyle(fontFamily: 'Poppins'),
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Find Alternative',
                  // filled: true,
                  //fillColor: Colors.grey.shade100,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _searchMedicine(
                          _searchController.text.trim().toLowerCase());
                    },
                  ),
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  //   borderSide: BorderSide.none,
                  // ),
                ),
              ),
            ),
            SizedBox(height: 5),
            // Text(
            //   'Alternative Medicines:',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //     //color: Colors.black87,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Important Note:',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Before Using Any Alternative,\nFirst Concerned with Doctors',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: _alternativeMedicines.map((medicine) {
                  return InkWell(
                    onTap: () {
                      _selectSuggestion(medicine);
                      // Implement the action you want to perform when the suggestion is selected
                      print('Selected: ${medicine.name}');
                      // You can use the selected medicine as needed.
                    },
                    child: ListTile(
                      title: Text(
                        medicine.name,
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                          'activeIngredient:  ${medicine.activeIngredient}'),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
