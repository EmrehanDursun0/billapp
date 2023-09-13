// ignore_for_file: use_build_context_synchronously

import 'package:billapp/menu_upgrade/dynamic_menu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Buttonmode { update, added }

Future<void> iconsUpdatePage(
  BuildContext context,
  String id,
  String name,
  String price,
  String liter,
  String categoryId,
  Buttonmode buttonMode,
) async {
  final TextEditingController nameController = buttonMode == Buttonmode.update
      ? TextEditingController(text: name)
      : TextEditingController();
  final TextEditingController priceController = buttonMode == Buttonmode.update
      ? TextEditingController(text: price)
      : TextEditingController();
  final TextEditingController literController = buttonMode == Buttonmode.update
      ? TextEditingController(text: liter)
      : TextEditingController();

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
                    controller: literController,
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
                    //Güncelleme kısmı ise burası çalışır
                    child: buttonMode == Buttonmode.update
                        ? Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  bool? confirmed =
                                      await showConfirmationDialog(context);

                                  if (confirmed != null && confirmed) {
                                    await mealupdate(
                                      nameController.text,
                                      priceController.text,
                                      literController.text,
                                      id,
                                      categoryId,
                                    );
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
                                  bool? confirmed =
                                      await showConfirmationDialog(context);
                                  if (confirmed != null && confirmed) {
                                    // Silme işlemi
                                    await mealDeletion(id);
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
                          )
                        // Yemek Ekle Kısmı ise burası çalışır
                        : ElevatedButton(
                            onPressed: () async {
                              await mealAddition(
                                nameController.text,
                                priceController.text,
                                literController.text,
                                categoryId,
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

Future<void> mealupdate(
  String name,
  String price,
  String liter,
  String id,
  String categoryId,
) async {
  try {
    final mealRef = FirebaseFirestore.instance.collection('products').doc(id);

    final updateData = {
      'name': name,
      'price': price,
      'liter': liter,
    };

    await mealRef.update(updateData);
    debugPrint('Yeni Yemek başarıyla eklendi.');
  } catch (error) {
    debugPrint('Bir hata oluştu: $error');
  }
}

Future<void> mealAddition(
  String name,
  String price,
  String liter,
  String categoryId,
) async {
  try {
    final firestoreInstance = FirebaseFirestore.instance;
    final mealRef = firestoreInstance.collection('products');
    final documentReference = mealRef.doc();
    final id = documentReference.id;

    final mealData = {
      'name': name,
      'price': price,
      'liter': liter,
      'categoryId': categoryId,
      'id': id,
    };
    await documentReference.set(mealData);

    debugPrint('Yeni Yemek başarıyla eklendi. ID: $id');
  } catch (error) {
    debugPrint('Bir hata oluştu: $error');
  }
}

Future<void> mealDeletion(String id) async {
  try {
    final mealRef = FirebaseFirestore.instance.collection('products').doc(id);

    // Belgeyi sil
    await mealRef.delete();

    debugPrint('Yemek başarıyla silindi.');
  } catch (error) {
    debugPrint('Bir hata oluştu: $error');
  }
}

Future<bool?> showConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Bunu yapmak  istediğinize emin misiniz?"),
        actions: <Widget>[
          TextButton(
            child: const Text("İptal"),
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // İptal düğmesine basıldığında false döner.
            },
          ),
          TextButton(
            child: const Text("Onayla"),
            onPressed: () {
              Navigator.of(context)
                  .pop(true); // Sil düğmesine basıldığında true döner.
            },
          ),
        ],
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
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DynamicMenuPage(),
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
