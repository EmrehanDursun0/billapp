// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class OrderProductsFirebase extends StatefulWidget {
//   @override
//   OrderProductsFirebaseState createState() => OrderProductsFirebaseState();
// }

// class OrderProductsFirebaseState extends State<OrderProductsFirebase> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('orderProducts').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasData && snapshot.data != null) {
//           final documents = snapshot.data!.docs;

//           return Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/menu/splash.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Container(
//               color: Colors.black.withOpacity(0.9),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   Expanded(
//                     child: ListView(
//                       children: documents.map((doc) {
//                         final data = doc.data() as Map<String, dynamic>;
//                         final productId = doc.id;
//                         final name = data['name'] ?? '';
//                         final price = data['price'].toString();
//                         final quantity = data['quantity'] ?? 0;

//                         String additionalInfo = '';
//                         if (data.containsKey('Liter')) {
//                           final liter = data['Liter'].toString();
//                           additionalInfo = '$liter Liter';
//                         }

//                         return ListTile(
//                           title: FittedBox(
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: 150,
//                                   height: 30,
//                                   child: Text(
//                                     name,
//                                     style: GoogleFonts.judson(
//                                       fontSize: 20,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 SizedBox(
//                                   width: 50,
//                                   height: 30,
//                                   child: Text(
//                                     "$price TL",
//                                     style: GoogleFonts.judson(
//                                       fontSize: 15,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 if (additionalInfo.isNotEmpty)
//                                   SizedBox(
//                                     width: 120,
//                                     height: 30,
//                                     child: Text(
//                                       additionalInfo,
//                                       style: GoogleFonts.judson(
//                                         fontSize: 15,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 if (additionalInfo.isEmpty)
//                                   SizedBox(
//                                     width: 120,
//                                     height: 30,
//                                     child: Text(
//                                       additionalInfo,
//                                       style: GoogleFonts.judson(
//                                         fontSize: 15,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   )
//                               ],
//                             ),
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.remove, color: Colors.white),
//                                 onPressed: () {
//                                   if (quantity > 0) {
//                                     updateProductQuantity(productId, quantity - 1);
//                                   }
//                                 },
//                               ),
//                               Text(quantity.toString(),
//                                   style: GoogleFonts.judson(
//                                     fontSize: 15,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               IconButton(
//                                 icon: const Icon(Icons.add, color: Colors.white),
//                                 onPressed: () {
//                                   updateProductQuantity(productId, quantity + 1);
//                                 },
//                               ),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Siparişi onaylama işlemleri burada yapılabilir
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       foregroundColor: Colors.black,
//                       backgroundColor: const Color(0xFFE0A66B),
//                       fixedSize: const Size(230, 60),
//                     ),
//                     child: Text(
//                       'Siparişe Devam Et',
//                       style: GoogleFonts.judson(
//                         fontSize: 24,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return const Center(
//             child: Text('Veri alınamadı.'),
//           );
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }

//   void updateProductQuantity(String productId, int newQuantity) {
//     try {
//       FirebaseFirestore.instance
//           .collection('orderProducts')
//           .doc(productId)
//           .update({'quantity': newQuantity})
//           .then((value) {
//         print('Ürün miktarı güncellendi.');
//       }).catchError((error) {
//         print('Ürün miktarı güncellenirken hata oluştu: $error');
//       });
//     } catch (error) {
//       print('Error updating product quantity: $error');
//     }
//   }
// }