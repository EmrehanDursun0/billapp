import 'package:billapp/Page/menu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainFirebase extends StatefulWidget {
  final String collectionName;

  const MainFirebase(
      {super.key, required this.collectionName, required this.selectedTable});
  final String selectedTable;

  @override
  MainFirebaseState createState() => MainFirebaseState();
}

class MainFirebaseState extends State<MainFirebase> {
  Map<String, int> productQuantities = {}; // Ürün ID'si -> Miktar

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(widget.collectionName)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final documents = snapshot.data!.docs;

          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/menu/splash.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.9),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: documents.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final productId = doc.id;
                        final name = data['Name'] ?? '';
                        final price = data['Price'].toString();
                        final quantity = productQuantities[productId] ?? 0;
                        String additionalInfo = '';

                        if (data.containsKey('Liter')) {
                          final liter = data['Liter'].toString();
                          additionalInfo = '$liter Liter';
                        }

                        return ListTile(
                          title: FittedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 30,
                                  child: Text(
                                    name,
                                    style: GoogleFonts.judson(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 50,
                                  height: 30,
                                  child: Text(
                                    "$price TL",
                                    style: GoogleFonts.judson(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                if (additionalInfo.isNotEmpty)
                                  SizedBox(
                                    width: 120,
                                    height: 30,
                                    child: Text(
                                      additionalInfo,
                                      style: GoogleFonts.judson(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                if (additionalInfo.isEmpty)
                                  SizedBox(
                                    width: 120,
                                    height: 30,
                                    child: Text(
                                      additionalInfo,
                                      style: GoogleFonts.judson(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove,
                                    color: Colors.white),
                                onPressed: () {
                                  if (quantity > 0) {
                                    updateProductQuantity(
                                        productId, quantity - 1, name, price);
                                  }
                                },
                              ),
                              Text(quantity.toString(),
                                  style: GoogleFonts.judson(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              IconButton(
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  updateProductQuantity(
                                      productId, quantity + 1, name, price);
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuPage(
                            personelSelected: null,
                            selectedTable: widget.selectedTable,
                            selectedtitle: '',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFE0A66B),
                      fixedSize: const Size(230, 60),
                    ),
                    child: Text(
                      'Siparişe Devam Et',
                      style: GoogleFonts.judson(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Veri alınamadı.'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void updateProductQuantity(
      String productId, int newQuantity, String name, String price) {
    setState(() {
      productQuantities[productId] = newQuantity;
    });

    try {
      // Mevcut ürün miktarını güncelle
      FirebaseFirestore.instance
          .collection('Orders')
          .doc(widget.selectedTable)
          .collection('orders')
          .doc(productId)
          .update({'Quantity': newQuantity});

      // Siparişi seçilen masaya kaydetmek
      final selectedTable = widget.selectedTable; // Seçilen masa adı
      final orderData = {
        'productId': productId,
        'quantity': newQuantity,
        'name': name,
        'price': price,
        // Diğer sipariş bilgileri
      };

      FirebaseFirestore.instance
          .collection('Orders')
          .doc(selectedTable)
          .collection('orders')
          .add(orderData)
          .then((value) {
        print('Sipariş başarıyla kaydedildi.');
      }).catchError((error) {
        print('Sipariş kaydedilirken hata oluştu: $error');
      });
    } catch (error) {
      print('Error updating product quantity: $error');
    }
  }
}
