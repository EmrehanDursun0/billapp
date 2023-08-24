import 'package:billapp/case_menu/case_menu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  bool personelSelected = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF260900),
          title: Row(
            children: [
              Text(
                'Overtech',
                style: GoogleFonts.judson(
                  fontSize: 33,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 170),
            ],
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/menu/splash.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.6),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          tableSelection(context);
                          setState(() {
                            personelSelected = false;
                          });
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuPage(
                                    personelSelected: personelSelected)),
                          );*/
                        },
                        child: Container(
                          width: 270,
                          height: 99,
                          decoration: BoxDecoration(
                            color: const Color(0xFF260900),
                            border: Border.all(
                              color: const Color(0xFF000000),
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 30),
                          child: Center(
                            child: Text(
                              'Müşteri',
                              style: GoogleFonts.judson(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            personelSelected = true;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CaseHomePage()),
                          );
                        },
                        child: Container(
                          width: 270,
                          height: 99,
                          decoration: BoxDecoration(
                            color: const Color(0xFF260900),
                            border: Border.all(
                              color: const Color(0xFF000000),
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 30),
                          child: Center(
                            child: Text(
                              'Personel',
                              style: GoogleFonts.judson(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          FirebaseAuth.instance.signOut();
                        },
                        child: Container(
                          width: 270,
                          height: 99,
                          decoration: BoxDecoration(
                            color: const Color(0xFF260900),
                            border: Border.all(
                              color: const Color(0xFF000000),
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 30),
                          child: Center(
                            child: Text(
                              'Çıkış',
                              style: GoogleFonts.judson(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



void tableSelection(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFFE0A66B), // Arka plan rengi
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Köşe yuvarlatma
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: const Color(0xFF260900),
                borderRadius:
                    BorderRadius.circular(15), // Kenar yuvarlatma değeri
              ),
              child: Center(
                child: Text(
                  "Masa Seçimi",
                  style: GoogleFonts.judson(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Masa 1",
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                _addTableToFirestore(
                    'masa1'); // Masa ID'si buraya göre değişebilir
                Navigator.pop(context); // Dialog kapat
              },
            ),
            ListTile(
              title: Text(
                "Masa 2",
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Masa 2 seçildiğinde yapılacak işlemler
                Navigator.pop(context); // Dialog kapat
              },
            ),
            ListTile(
              title: Text(
                "Masa 3",
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Masa 1 seçildiğinde yapılacak işlemler
                Navigator.pop(context); // Dialog kapat
              },
            ),
            ListTile(
              title: Text(
                "Masa 4",
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Masa 1 seçildiğinde yapılacak işlemler
                Navigator.pop(context); // Dialog kapat
              },
            ),
            ListTile(
              title: Text(
                "Masa 5",
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Masa 1 seçildiğinde yapılacak işlemler
                Navigator.pop(context); // Dialog kapat
              },
            ),
            ListTile(
              title: Text(
                "Masa 6",
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Masa 1 seçildiğinde yapılacak işlemler
                Navigator.pop(context); // Dialog kapat
              },
            ),
          ],
        ),
      );
    },
  );
}

void _addTableToFirestore(String tableId) {
  FirebaseFirestore.instance.collection('tables').doc(tableId).set({
    'status': 'occupied', // Örnek olarak masa durumu
    // Diğer gerekli verileri ekleyebilirsiniz
  }).then((_) {
    print('Masa eklendi: $tableId');
  }).catchError((error) {
    print('Hata oluştu: $error');
  });
}