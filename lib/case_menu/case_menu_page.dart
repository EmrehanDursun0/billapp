// ignore_for_file: use_build_context_synchronously
import 'package:billapp/menu_update/dynamic_menu_page.dart';
import 'package:billapp/pages/order_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:billapp/providers/bill_app_provider.dart';
import 'package:provider/provider.dart';

class CaseHomePage extends StatefulWidget {
  const CaseHomePage({Key? key, required}) : super(key: key);

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
                              horizontal: 25, vertical: 50),
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const DynamicMenuPage(),
                            ),
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
                              horizontal: 25, vertical: 50),
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
                              horizontal: 25, vertical: 50),
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
}
