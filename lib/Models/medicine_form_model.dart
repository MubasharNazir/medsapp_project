// class DonationModel {
//   String? uid;
//   String? medicineName;
//   String? medicineType;
//   String? medicineExpiryDate;
//   String? medicineCondition;
//   String? medicineQuantity;
//   String? medicineDescription;
//   String? medicineAddress;
//   String? phoneNumber;
//   //String? ExpiryDate;
//   //String? MedicineQuantity;
//   DonationModel(
//       {this.uid,
//       this.medicineName,
//       this.medicineType,
//       this.medicineExpiryDate,
//       this.medicineCondition,
//       this.medicineAddress,
//       this.medicineDescription,
//       this.medicineQuantity,
//       this.phoneNumber});
//   factory DonationModel.fromMap(map) {
//     return DonationModel(
//         uid: map['uid'],
//         medicineName: map['medicineName'],
//         medicineType: map['medicineType'],
//         medicineExpiryDate: map['medicineExpiryDate'],
//         medicineCondition: map['medicineCondition'],
//         medicineAddress: map['medicineAddress'],
//         medicineDescription: map['medicineDescription'],
//         medicineQuantity: map['medicineQuantity'],
//         phoneNumber: map['phoneNumber']);
//   }
// // sending the data to firebase
//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
      
//       'medicineName': medicineName,
//       'medicineType': medicineType,
//       'medicineExpiryDate': medicineExpiryDate,
//       'medicineCondition': medicineCondition,
//       'medicineAddress': medicineAddress,
//       'medicineDescription': medicineDescription,
//       'medicineQuantity': medicineQuantity,
//       'phoneNumber': phoneNumber
//     };
//   }
// }
