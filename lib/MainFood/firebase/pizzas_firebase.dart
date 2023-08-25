// import 'package:billapp/Page/menu_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class PizzasFirebase extends StatefulWidget {
//   const PizzasFirebase({Key? key}) : super(key: key);
//   @override
//   PizzasFirebaseState createState() => PizzasFirebaseState();
// }

// class PizzasFirebaseState extends State<PizzasFirebase> {
//   Map<String, int> productQuantities = {}; // Ürün ID'si -> Miktar
//   Map<String, bool> selectedProducts = {};
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('Pizza').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasData && snapshot.data != null) {
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
//                       children: snapshot.data!.docs.map((doc) {
//                         final data = doc.data() as Map<String, dynamic>;
//                         final productId = doc.id;
//                         final name = data['Name'] ?? '';
//                         final price = data['Price'].toString();
//                         final quantity = productQuantities[productId] ?? 0;

//                         return ListTile(
//                           title: FittedBox(
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: 120,
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
//                                 const SizedBox(
//                                   width: 60,
//                                   height: 30,
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
//                               ],
//                             ),
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.remove,
//                                     color: Colors.white),
//                                 onPressed: () {
//                                   if (quantity > 0) {
//                                     // Eğer miktar 0'dan büyükse azalt
//                                     updateProductQuantity(
//                                         productId, quantity - 1);
//                                   }
//                                 },
//                               ),
//                               Text(quantity.toString(),
//                                   style: GoogleFonts.judson(
//                                     fontSize: 15,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   )), // Ürün miktarını göster
//                               IconButton(
//                                 icon:
//                                     const Icon(Icons.add, color: Colors.white),
//                                 onPressed: () {
//                                   updateProductQuantity(
//                                       productId, quantity + 1);
//                                 },
//                               ),
//                             ],
//                           ),
//                           onTap: () {
//                             setState(() {
//                               if (selectedProducts.containsKey(productId)) {
//                                 selectedProducts.remove(productId);
//                               } else {
//                                 selectedProducts[productId] = true;
//                               }
//                             });
//                           },
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const MenuPage(
//                                     personelSelected: null,
//                                   )));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       foregroundColor: Colors.black,
//                       backgroundColor: const Color(0xFFE0A66B),
//                       fixedSize: const Size(230, 60),
//                     ),
//                     child: Text('Siparişe Devam Et',
//                         style: GoogleFonts.judson(
//                           fontSize: 24,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         )),
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

//   // void main() async {
//   //   WidgetsFlutterBinding.ensureInitialized();
//   //   await Firebase.initializeApp();
//   //   runApp(const PizzasFirebase());
//   // }

//   void updateProductQuantity(String productId, int newQuantity) {
//     setState(() {
//       productQuantities[productId] = newQuantity;
//     });

//     try {
//       FirebaseFirestore.instance
//           .collection('Pizza')
//           .doc(productId)
//           .update({'Quantity': newQuantity});
//     } catch (error) {
//       print('Error updating product quantity: $error');
//     }
//   }
// }
