import 'package:billapp/Page/MenuPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CaseHomePage extends StatelessWidget {
  const CaseHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  'assets/menu/splash.png', // Arka plan resminin yolu
                  fit: BoxFit.cover,
                ),
              ),
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
                                    const MenuPage()), // HomeMenu sayfasına geçiş
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
                          child:  Center(
                            child: Text(
                              'Menü',
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
                          // Üçüncü Container'a tıklanınca yapılacak işlemler buraya gelecek
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
                          // Dördüncü Container'a tıklanınca yapılacak işlemler buraya gelecek
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
                          child:  Center(
                            child: Text(
                              'Siparişi Düzelt',
                              style: GoogleFonts.judson(
                                              fontSize: 26,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                            ),              ),
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
