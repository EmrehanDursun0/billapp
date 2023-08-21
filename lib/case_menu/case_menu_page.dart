import 'package:flutter/material.dart';

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
                opacity: 0.8,
                child: Image.asset(
                  'assets/menu/splash.png', // Arka plan resminin yolu
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9, // Ekran genişliğinin %90'ı kadar
                height: MediaQuery.of(context).size.height * 0.7, // Ekran yüksekliğinin %70'i kadar
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
                          // İkinci Container'a tıklanınca yapılacak işlemler buraya gelecek
                        },
                        child: Container(
                          width: 243,
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
                          child: const Center(
                            child: Text(
                              'Menu',
                              style: TextStyle(
                                  fontSize: 27, color: Colors.white),
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
                          width: 243,
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
                          child: const Center(
                            child: Text(
                              'Siparişler',
                              style: TextStyle(
                                  fontSize: 27, color: Colors.white),
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
                          width: 243,
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
                          child: const Center(
                            child: Text(
                              'Siparişi Düzelt',
                              style: TextStyle(
                                  fontSize: 27, color: Colors.white),
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
