import 'package:billapp/Page/menu_page.dart';
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
  String selectedTable = '';

  Future<void> tableSelection(BuildContext context) async {
    final tableList = await fetchTableList();

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFE0A66B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
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
                    "Masa Seçimi",
                    style: GoogleFonts.judson(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ...tableList
                  .map((tableName) => buildTableTile(context, tableName))
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  Future<List<String>> fetchTableList() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("tables")
        .orderBy("name")
        .get();
    List<String> tableList =
        snapshot.docs.map((doc) => doc['name'].toString()).toList();
    return tableList;
  }

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
                                builder: (context) => const CaseHomePage(
                                      selectedTable: '',
                                    )),
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

  Widget buildTableTile(BuildContext context, String tableName) {
    return ListTile(
      title: Text(
        tableName,
        style: GoogleFonts.judson(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        setState(() {
          selectedTable = tableName;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuPage(
              selectedTable: selectedTable,
              personelSelected: null,
              selectedtitle: '',
            ),
          ),
        );
      },
    );
  }
/*
  void addTableToFirestore(String tableName) {
    FirebaseFirestore.instance.collection('tables').doc(tableName).set({
      'name': tableName,
      'masaId': "masa" // Masa durumu gibi örnek bir veri
      // Diğer gerekli verileri ekleyebilirsiniz
    }).then((_) {
      print('Masa eklendi: $tableName');
    }).catchError((error) {
      print('Hata oluştu: $error');
    });
  }*/
}
