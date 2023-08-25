import 'package:billapp/Page/menu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuUpgrade extends StatefulWidget {
  final String collectionName;

  const MenuUpgrade({Key? key, required this.collectionName}) : super(key: key);

  @override
  MenuUpgradeState createState() => MenuUpgradeState();
}

class MenuUpgradeState extends State<MenuUpgrade> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(widget.collectionName)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
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
                      children: snapshot.data!.docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final name = data['Name'] ?? '';
                        final price = data['Price'].toString();
                        return ListTile(
                          title: FittedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 120,
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
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.upgrade_outlined,
                                color: Colors.white),
                            onPressed: () {
                              // Veri tabanı güncelleme buradan yapılacak
                            },
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
                          builder: (context) => const MenuPage(
                            personelSelected: null, selectedTable: '',
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
