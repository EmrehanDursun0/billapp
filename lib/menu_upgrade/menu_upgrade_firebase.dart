 

import 'package:billapp/menu_upgrade/MenuUpdatePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      stream: FirebaseFirestore.instance.collection(widget.collectionName).snapshots(),
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
                        final price = data['Price'];
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
                                onPressed: () {
                                  final productId = doc.id;
                                  iconsUpdatePage(
                                    context,
                                    widget.collectionName,
                                    name,
                                    price,
                                    additionalInfo,
                                    productId,
                                  );
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

 
Future<void> showMealAdditionDialog(BuildContext context, String collectionName) async {
  // Veri tabanından gelen değerin Türkçeye çevrilmesi
 
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController litercontroller = TextEditingController();

  String productId = '';
  // Veri tabanından gelen değerin Türkçeye çevrilmesi
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
        insetPadding: const EdgeInsets.all(20),
        backgroundColor: const Color(0xFFE0A66B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        content: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
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
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      labelText: 'Ürünün Adı',
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
                  const SizedBox(height: 10),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white),
                      labelText: 'Ürünün fiyatı',
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
                  const SizedBox(height: 10),
                  TextField(
                    controller: litercontroller,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white),
                      labelText: 'Ürünün Miktarı',
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
                  const SizedBox(height: 10),
                  FittedBox(
                    child: ElevatedButton(
                      onPressed: () async {
                        await mealaddition(
                          nameController.text,
                          int.parse(priceController.text),
                          litercontroller.text,
                          collectionName,
                          productId,
                        );
                        confrimScreen(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFF260900),
                        fixedSize: const Size(140, 40),
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
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}

Future<void> confrimScreen(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MenuUpdatePage(
              selectedtitle: '',
            ),
          ),
        );
      });

      return AlertDialog(
        backgroundColor: const Color(0xFFE0A66B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        content: Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
            color: const Color(0xFFE0A66B).withOpacity(0.6), // Add opacity for transparency
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ürün Eklenmiştir",
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
        ),
      );
    },
  );
}

Future<void> mealaddition(
  String name,
  int price,
  String liter,
  String collectionName,
  String productId,
) async {
  try {
    final orderRef = FirebaseFirestore.instance.collection(collectionName).doc();
    final newProductId = orderRef.id;

    final orderData = {
      'productId': newProductId,
      'Name': name,
      'Price': price,
      'Liter': liter,
    };

    await orderRef.set(orderData);
    debugPrint('Yeni Yemek başarıyla eklendi.');
  } catch (error) {
    debugPrint('Bir hata oluştu: $error');
  }
}

Future<void> iconsUpdatePage(
  BuildContext context,
  String collectionName,
  String name, // Ürün adı
  int price, // Ürün fiyatı
  String liter,
  String productId, // productId
) async {
 
  // Veri tabanından gelen değerin Türkçeye çevrilmesi
  final TextEditingController nameController = TextEditingController(text: name);
  final TextEditingController priceController = TextEditingController(text: price);
  final TextEditingController literController = TextEditingController(text: liter);
  // String documentId = '';
 
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        backgroundColor: const Color(0xFFE0A66B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        content: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: const Color(0xFF260900),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        //Category kısmı
                        'Güncelleme Sayfası',
                        style: GoogleFonts.judson(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      labelText: 'Ürünün Adı',
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
                  const SizedBox(height: 10),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white),
                      labelText: 'Ürünün fiyatı',
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
                  const SizedBox(height: 10),
                  TextField(
                    controller: literController, // Doğru denetleyiciyi kullanın
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white),
                      labelText: 'Ürünün Miktarı',
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
                  const SizedBox(height: 10),
                  FittedBox(
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await mealUpdate(
                              collectionName,
                              nameController.text,
 
                              int.parse(priceController.text),
                              literController.text, // Doğru denetleyiciyi kullanın
                              collectionName,
 
                              productId,
                            );
                            confrimScreen(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            foregroundColor: Colors.black,
                            backgroundColor: const Color(0xFF260900),
                            fixedSize: const Size(140, 40),
                          ),
                          child: Text(
                            'Güncelle',
                            style: GoogleFonts.judson(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
 
                            // Silme işlemini başlat
                            await mealDeletion(collectionName, productId); // documentId'i burada kullanabilirsiniz
 

                            if (confirm != null && confirm) {
                              // Silme işlemini başlat
                              await mealDeletion(collectionName, productId);

                              // Silme işlemi tamamlandıktan sonra bir ekranı görüntülemek için
                              confrimScreen(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            foregroundColor: Colors.black,
                            backgroundColor: const Color(0xFF260900),
                            fixedSize: const Size(140, 40),
                          ),
                          child: Text(
                            'Sil',
                            style: GoogleFonts.judson(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}

Future<void> mealDeletion(String collectionName, String productId) async {
  try {
    final mealRef = FirebaseFirestore.instance.collection(collectionName).doc(productId);

    // Belgeyi sil
    await mealRef.delete();

 
    debugPrint('Yemek başarıyla silindi.');
  } catch (error) {
    debugPrint('Bir hata oluştu: $error');
 
  }
}

Future<bool?> showConfirmationDialog(
    BuildContext context, String name, int price) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Bu öğeyi silmek istediğinize emin misiniz?'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Ürünün Adı: $name'),
            Text('Ürünün Fiyatı: $price'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // İptal'e basıldığında false döndür
            },
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(true); // Onayla'ya basıldığında true döndür
            },
            child: const Text('Onayla'),
          ),
        ],
      );
    },
  );
}

Future<void> mealUpdate(
  String collectionName,
  String name,
  String price,
  String liter,
  String productId,
) async {
  try {
    final updatedData = {
      'Name': name,
      'Price': int.parse(price),
      'Liter': liter,
      'productId': productId
    };
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(productId)
        .set(updatedData);
    ;

    print('Yemek başarıyla güncellendi.');
  } catch (error) {
    print('Güncelleme sırasında bir hata oluştu: $error');
  }
}
