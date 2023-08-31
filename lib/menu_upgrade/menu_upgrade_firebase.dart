import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuUpgradeFirebase extends StatefulWidget {
  final String collectionName;
  const MenuUpgradeFirebase({
    Key? key,
    required this.collectionName,
  }) : super(key: key);

  @override
  MenuUpgradeFirebaseState createState() => MenuUpgradeFirebaseState();
}

class MenuUpgradeFirebaseState extends State<MenuUpgradeFirebase> {
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
                        final name = data['Name'] ?? '';
                        final price = data['Price'].toString();
                        String additionalInfo = '';

                        if (data.containsKey('Liter')) {
                          final liter = data['Liter'].toString();
                          additionalInfo = '$liter  ';
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
                                icon: const Icon(
                                  IconData(0xe7f7, fontFamily: 'MaterialIcons'),
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showMealAdditionDialog(context, widget.collectionName);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color(0xFFE0A66B),
                      fixedSize: const Size(230, 60),
                    ),
                    child: Text(
                      'Yemek Ekle',
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
}

Future<void> showMealAdditionDialog(
    BuildContext context, String collectionName) async {
  // Veri tabanından gelen değerin Türkçeye çevrilmesi
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String name = '';
  int price = 0;
  int liter = 0;
  String productId = '';
  String collectionDisplayName = collectionName == 'MainFood'
      ? 'Ana Yemekler'
      : collectionName == 'ColdDrinks'
          ? 'Soğuk İçecekler'
          : collectionName == 'HotDrinks'
              ? 'Sıcak İçecekler'
              : collectionName == 'Burgers'
                  ? 'Burgerler'
                  : collectionName == 'Pizzas'
                      ? 'Pizzalar'
                      : collectionName == 'PitaLahmacun'
                          ? 'Pide-Lahmacun'
                          : collectionName == 'Salads'
                              ? 'Salatalar'
                              : collectionName == 'Soups'
                                  ? 'Çorbalar'
                                  : collectionName;

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFFE0A66B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: const Color(0xFF260900),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  //Category kısmı
                  collectionDisplayName,
                  style: GoogleFonts.judson(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.white),
                labelText: "Yemeğin Adı",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.white),
                labelText: name,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                mealaddition(
                    nameController.text,
                    int.parse(priceController.text),
                    /*liter*/ collectionName,
                    productId);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFF260900),
                fixedSize: const Size(180, 50),
              ),
              child: Text(
                'Ekle',
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.all(20),
      );
    },
  );
}

void mealaddition(
  String name,
  int price,
  // int liter,
  String collectionName,
  String productId,
) {
  try {
    final orderRef =
        FirebaseFirestore.instance.collection(collectionName).doc();
    final newProductId = orderRef.id;

    final orderData = {
      'productId': newProductId,
      'Name': name,
      'Price': price,
      // 'Liter': liter,
    };

    orderRef.set(orderData).then((value) {
      print('Yeni Yemek başarıyla eklendi.');
    }).catchError((error) {
      print('Sipariş eklenirken hata oluştu: $error');
    });
  } catch (error) {
    print('Bir hata oluştu: $error');
  }
}
