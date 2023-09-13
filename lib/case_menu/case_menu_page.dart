// ignore_for_file: use_build_context_synchronously

import 'package:billapp/MainFood/orders_product.dart';
import 'package:billapp/case_menu/table_control.dart';
import 'package:billapp/menu_upgrade/dynamic_menu_page.dart';
import 'package:billapp/providers/bill_app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CaseHomePage extends StatefulWidget {
  const CaseHomePage({Key? key, required String selectedTable})
      : super(key: key);

  @override
  State<CaseHomePage> createState() => _CaseHomePageState();
}

class _CaseHomePageState extends State<CaseHomePage> {
  @override
  Widget build(BuildContext context) {
    final BillAppProvider billAppProvider = context.watch<BillAppProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF260900),
          title: Row(
            children: [
              Text(
                'Menü',
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
                width: MediaQuery.of(context).size.width *
                    0.9, // Ekran genişliğinin %90'ı kadar
                height: MediaQuery.of(context).size.height *
                    0.7, // Ekran yüksekliğinin %70'i kadar
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
                          tablecontrol(context, '');
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
                              'Masa Düzenle',
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderProductsPage()));
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
                              'Siparişler',
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
                          billAppProvider.setMenuModeToEmployee();
                          _showUpdateMenuDialog(
                              context); // Menü güncelleme dialogunu gösterme işlemi
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
                              'Menü Güncelle',
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
                              'Personel Çıkış',
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

  void _showUpdateMenuDialog(BuildContext context) {
    String username = ""; // Kullanıcı adı alanı
    String password =
        ""; // Şifre alanıfinal BillAppProvider billAppProvider = context.watch<BillAppProvider>();

    showDialog(
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
                    "Admin Giriş",
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
                onChanged: (value) {
                  username = value; // Kullanıcı adını güncelle
                },
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  password = value; // Şifreyi güncelle
                },
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email:
                              username, // Kullanıcı adını e-posta olarak kullanabilirsiniz
                          password: password,
                        );

                        // Kullanıcı başarıyla giriş yaptıysa
                        if (userCredential.user != null) {
                          Navigator.of(context).pop(); // Dialog'u kapat

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const DynamicMenuPage(),
                          ));
                        }
                      } catch (e) {
                        // Hata durumunda
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Kullanıcı adı veya şifre hatalı"),
                        ));
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF260900),
                    ),
                    child: Text(
                      'Giriş yap',
                      style: GoogleFonts.judson(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Dialog'u kapat
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF260900),
                    ),
                    child: Text(
                      'İptal',
                      style: GoogleFonts.judson(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
