// import 'package:billapp/Page/menu_page.dart';
// import 'package:billapp/providers/order_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class OrdersFirebase extends StatefulWidget {
//   final String collectionName;

//   const OrdersFirebase({
//     Key? key,
//     required this.collectionName,
//     required this.selectedTable,
//   }) : super(key: key);

//   final String selectedTable;

//   @override
//   OrdersFirebaseState createState() => OrdersFirebaseState();
// }

// class OrdersFirebaseState extends State<OrdersFirebase> {
//   Map<String, int> productQuantities = {};

//   final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('Orders').doc(widget.selectedTable).collection('orders').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasData && snapshot.data != null) {
//           final documents = snapshot.data!.docs;
//           double totalCost = 0.0;

//           return Scaffold(
//             body: Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/menu/splash.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Container(
//                 color: Colors.black.withOpacity(0.9),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     Expanded(
//                       child: ListView(
//                         children: documents.map((doc) {
//                           final data = doc.data() as Map<String, dynamic>;
//                           final productId = doc.id;
//                           final name = data['name'] ?? '';
//                           final price = data['price'].toString();
//                           final quantity = data['quantity'] ?? 0;
//                           totalCost += double.parse(price) * quantity;

//                           String additionalInfo = '';
//                           if (data.containsKey('Liter')) {
//                             final liter = data['Liter'].toString();
//                             additionalInfo = '$liter Liter';
//                           }

//                           return ListTile(
//                             title: FittedBox(
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 150,
//                                     height: 30,
//                                     child: Text(
//                                       name,
//                                       style: GoogleFonts.judson(
//                                         fontSize: 20,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   SizedBox(
//                                     width: 50,
//                                     height: 30,
//                                     child: Text(
//                                       "$price TL",
//                                       style: GoogleFonts.judson(
//                                         fontSize: 15,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   if (additionalInfo.isNotEmpty)
//                                     SizedBox(
//                                       width: 120,
//                                       height: 30,
//                                       child: Text(
//                                         additionalInfo,
//                                         style: GoogleFonts.judson(
//                                           fontSize: 15,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(Icons.remove, color: Colors.white),
//                                   onPressed: () {
//                                     if (quantity > 0) {
//                                       updateProductQuantity(productId, quantity - 1, name, price);
//                                     }
//                                   },
//                                 ),
//                                 Text(
//                                   quantity.toString(),
//                                   style: GoogleFonts.judson(
//                                     fontSize: 15,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.add, color: Colors.white),
//                                   onPressed: () {
//                                     updateProductQuantity(productId, quantity + 1, name, price);
//                                   },
//                                 ),
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     FittedBox(
//                       child: Row(
//                         children: [
//                           Text(
//                             'Toplam Ücret:',
//                             style: GoogleFonts.judson(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(width: 150),
//                           Text(
//                             '$totalCost  TL',
//                             style: GoogleFonts.judson(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () async {
//                         final OrderProvider orderProvider = context.read<OrderProvider>();
//                         await orderProvider.orderTableList();
//                         // ordersSelection(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         foregroundColor: Colors.black,
//                         backgroundColor: const Color(0xFFE0A66B),
//                         fixedSize: const Size(230, 60),
//                       ),
//                       child: Text(
//                         'Siparişi Onayla',
//                         style: GoogleFonts.judson(
//                           fontSize: 24,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                   ],
//                 ),
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

//   Future<void> ordersSelection(BuildContext context) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: const Color(0xFFE0A66B),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           content: StatefulBuilder(
//             builder: (BuildContext context, setState) {
//               Future.delayed(const Duration(seconds: 3), () {
//                 Navigator.of(context).pop(); // Dialog kapat
//                 orderUpdate(); // Siparişi güncelle
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const MenuPage(
//                       personelSelected: null,
//                       selectedtitle: '',
//                     ),
//                   ),
//                 );
//               });

//               return Container(
//                 height: 300,
//                 width: 200,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE0A66B).withOpacity(0.6),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Şiparişiniz Alınmıştır",
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.judson(
//                             fontSize: 30,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 25),
//                         Image.asset(
//                           'assets/check.png',
//                           height: 60,
//                           width: 60,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   void updateProductQuantity(
//     String productId,
//     int newQuantity,
//     String name,
//     String price,
//   ) {
//     final selectedTable = widget.selectedTable;
//     final orderRef = FirebaseFirestore.instance.collection('Orders').doc(selectedTable).collection('orders').doc(productId);

//     final currentTime = DateTime.now();
//     final currentHour = currentTime.hour;
//     final currentMinute = currentTime.minute;

//     setState(() {
//       if (newQuantity <= 0) {
//         // Yeni miktar 0 veya daha azsa, siparişi sil
//         orderRef.delete().then((_) {
//           setState(() {
//             productQuantities.remove(productId);
//             debugPrint('Sipariş silindi.');
//           });
//         }).catchError((error) {
//           debugPrint('Sipariş silinirken hata oluştu: $error');
//         });
//       } else {
//         // Yeni miktar 0'dan büyükse, miktarı güncelle veya yeni sipariş ekle
//         setState(() {
//           productQuantities[productId] = newQuantity;
//         });

//         orderRef.get().then((docSnapshot) {
//           if (docSnapshot.exists) {
//             // Sipariş zaten varsa miktarı güncelle
//             orderRef.update({
//               'quantity': newQuantity,
//               'timestamp': '$currentHour:$currentMinute',
//             });
//             debugPrint('Sipariş miktarı güncellendi.');
//           } else {
//             // Sipariş veritabanında yoksa yeni sipariş ekle
//             final orderData = {
//               'productId': productId,
//               'quantity': newQuantity,
//               'name': name,
//               'price': price,
//               'timestamp': '$currentHour:$currentMinute',
//             };

//             orderRef.set(orderData).then((value) {
//               debugPrint('Yeni sipariş başarıyla eklendi.');
//             }).catchError((error) {
//               debugPrint('Sipariş eklenirken hata oluştu: $error');
//             });
//           }
//         }).catchError((error) {
//           debugPrint('Veritabanı hatası: $error');
//         });
//       }
//     });
//   }

//   void orderUpdate() {
//     final selectedTable = widget.selectedTable; // Seçili masa adı
//     final currentTime = DateTime.now();
//     final currentHour = currentTime.hour;
//     final currentMinute = currentTime.minute;

//     // Ürün miktarları eklendi
//     final orderData = {
//       'products': productQuantities,
//       'timestamp': '$currentHour:$currentMinute',
//     };

//     // Seçili masaya ait bir belge oluştur
//     FirebaseFirestore.instance.collection('OrderProducts').doc(selectedTable).collection('orders').add(orderData).then((value) {
//       debugPrint('Sipariş başarıyla kaydedildi.');
//     });
//   }
// }
