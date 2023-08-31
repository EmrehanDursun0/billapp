import 'package:billapp/Page/menu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderFirebase extends StatefulWidget {
  final String collectionName;

  const OrderFirebase({
    Key? key,
    required this.collectionName,
    required this.selectedTable,
  }) : super(key: key);

  final String selectedTable;

  @override
  OrderFirebaseState createState() => OrderFirebaseState();
}

class OrderFirebaseState extends State<OrderFirebase> {
  Map<String, int> productquantities = {}; // Ürün ID'si -> Miktar
  double totalCost = 0.0; // Toplam ücret
  double initialTotalCost = 0.0; // İlk açıldığında güncellenmiş toplam ücret
  bool isFirstBuild = true; // İlk build mi kontrolü
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Orders')
          .doc(widget.selectedTable)
          .collection('orders')
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
                        final name =
                            data['name'] ?? ''; // 'name' sütunundan ismi alın
                        final price = data['price']
                            .toString(); // 'price' sütunundan fiyatı alın
                        final quantity = data['quantity'] ?? 0;
                        totalCost += double.parse(price) * quantity;

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
                              Text(
                                quantity.toString(),
                                style: GoogleFonts.judson(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                  FittedBox(
                    child: Row(
                      children: [
                        Text(
                          'Toplam Ücret:',
                          style: GoogleFonts.judson(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 150),
                        Text(
                          '$totalCost  TL',
                          style: GoogleFonts.judson(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        ordersSelection(context) as BuildContext,
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
                      'Siparişi Onayla',
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

  Future<void> ordersSelection(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFE0A66B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, setState) {
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.of(context).pop(); // Close the dialog
                orderUpdate(); // orderUpdate fonksiyonunu çağır
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuPage(
                      selectedTable: widget.selectedTable,
                      personelSelected: null,
                      selectedtitle: '',
                    ),
                  ),
                );
              });

              return Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0A66B)
                      .withOpacity(0.6), // Add opacity for transparency
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Şiparişiniz Alınmıştır",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.judson(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Image.asset(
                          'assets/check.png',
                          height: 60,
                          width: 60,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void orderUpdate() {
    final selectedTable = widget.selectedTable; // Seçilen masa adı
    final currentTime = DateTime.now();
    final currentHour = currentTime.hour;
    final currentMinute = currentTime.minute;

    // Ürün miktarları eklendi
    final orderData = {
      'products': productquantities,
      'timestamp': '$currentHour:$currentMinute',
      'totalCost': totalCost,
      

      // Diğer sipariş bilgileri
    };

    // Seçili masaya ait bir belge oluştur
    FirebaseFirestore.instance
        .collection('OrderProducts')
        .doc(selectedTable)
        .collection('orders')
        .add(orderData)
        .then((value) {
      print('Sipariş başarıyla kaydedildi.');
    });
  }

  void updateProductQuantity(
    String productId,
    int newQuantity,
    String name,
    String price,
  ) {
    final selectedTable = widget.selectedTable;
    final orderRef = FirebaseFirestore.instance
        .collection('Orders')
        .doc(selectedTable)
        .collection('orders')
        .doc(productId);

    final currentTime = DateTime.now();
    final currentHour = currentTime.hour;
    final currentMinute = currentTime.minute;
    final orderData = {
      'productId': productId,
      'quantity': newQuantity,
      'name': name,
      'price': price,
      'timestamp': '$currentHour:$currentMinute',
      
    };

    if (newQuantity <= 0) {
      // Yeni miktar 0 veya daha azsa, siparişi sil
      orderRef.delete().then((_) {
        setState(() {
          productquantities.remove(productId);
          print('Sipariş silindi.');
        });
      }).catchError((error) {
        print('Sipariş silinirken hata oluştu: $error');
      });
    } else {
      // Yeni miktar 0'dan büyükse, miktarı güncelle veya yeni sipariş ekle
      setState(() {
        productquantities[productId] = newQuantity;
      });

      orderRef.get().then((docSnapshot) {
        if (docSnapshot.exists) {
          // Sipariş zaten varsa miktarı güncelle
          orderRef.update({
            'quantity': newQuantity,
            'timestamp': '$currentHour:$currentMinute'
          });
          print('Sipariş miktarı güncellendi.');
        } else {
          // Sipariş veritabanında yoksa yeni sipariş ekle
          orderRef.set(orderData).then((value) {
            print('Yeni sipariş başarıyla eklendi.');
          }).catchError((error) {
            print('Sipariş eklenirken hata oluştu: $error');
          });
        }
      }).catchError((error) {
        print('Veritabanı hatası: $error');
      });
    }
  }

  
}

