import 'package:billapp/Page/HomePage.dart';
import 'package:flutter/material.dart';

class CashHomePage extends StatelessWidget {
  const CashHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Arka plan resmini ekleyelim
            Positioned.fill(
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  'assets/menu/splash.png', // Arka plan resminin yolu
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Diğer widget'ları ekleyelim
            Column(
              children: [
                Container(
                  height: 150,
                ),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 30, left: 10, right: 10),
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
                                    builder: (context) => const HomePage()),
                              );
                            },
                            //Menü  Container
                            child: AnimatedContainer(
                              width: 243,
                              height: 99,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
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
                            //Sipariş  Container
                            child: AnimatedContainer(
                              width: 243,
                              height: 99,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
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
                        //  Column(children: [
                        //      Container(
                        //      child:  const Divider(
                        //     color: Colors.white,
                        //     thickness: 4,
                        //     indent: 10,
                        //     endIndent: 10,
                        //   ),
                        // ]),
                        // )
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // Üçüncü Container'a tıklanınca yapılacak işlemler buraya gelecek
                            },
                            //Sipariş Düzelt Container
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
          ],
        ),
      ),
    );
  }
}
