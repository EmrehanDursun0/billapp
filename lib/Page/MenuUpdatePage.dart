// ignore_for_file: file_names

import 'package:billapp/Page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../case_menu/case_menu_page.dart';

class MenuUpdatePage extends StatelessWidget {
  const MenuUpdatePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF260900),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: [
            Text(
              'Menü Güncelle',
              style: GoogleFonts.judson(
                fontSize: 33,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildCategoryButton(context, 'Ana Yemekler',
                        'assets/menu/ana_yemekler.png'),
                    buildCategoryButton(
                        context, 'Pide-Lahmacun', 'assets/menu/lahmacun.png'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildCategoryButton(
                        context, 'Burgerler', 'assets/menu/burger.png'),
                    buildCategoryButton(
                        context, 'Pizzalar', 'assets/menu/pizza.png'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildCategoryButton(
                        context, 'Çorbalar', 'assets/menu/corbalar.png'),
                    buildCategoryButton(
                        context, 'Salatalar', 'assets/menu/salatalar.png'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildCategoryButton(context, 'Sıcak İçecekler',
                        'assets/menu/hot_drinks.png'),
                    buildCategoryButton(
                        context, 'Soğuk İçecekler', 'assets/menu/drinks.png'),
                  ],
                ),
                // Diğer sıralar...
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryButton(
      BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        // İlgili sayfaya yönlendirme kodları burada olmalı
        if (title == 'Ana Yemekler') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CaseHomePage()),
          );
        } else if (title == 'Pide-Lahmacun') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
        // Diğer sayfalar için benzer şekilde eklenebilir
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent,
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imagePath,
                      width: 160, // Ölçüleri ihtiyaca göre ayarlayabilirsiniz
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
    );
  }
}
