//import 'package:billapp/MainFood/burgers_page.dart';
//import 'package:billapp/MainFood/cold_drinks_page.dart';
//import 'package:billapp/MainFood/main_food_page.dart';
import 'package:billapp/MainFood/main_page.dart';
import 'package:billapp/MainFood/orders_page.dart';
//import 'package:billapp/MainFood/pizzas_page.dart';
import 'package:billapp/Page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPage extends StatefulWidget {
  final dynamic personelSelected;

  const MenuPage(
      {super.key,
      required this.personelSelected,
      required this.selectedTable,
      required this.selectedtitle});
  final String selectedTable;
  final String selectedtitle;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF260900),
        leading: widget.personelSelected == true
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              )
            : GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF260900),
                ),
              ),
        title: FittedBox(
          child: Row(
            children: [
              Text(
                'Menü',
                style: GoogleFonts.judson(
                  fontSize: 33,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 150),
              (Text(
                ' ${widget.selectedTable}',
                style: GoogleFonts.judson(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ],
          ),
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
          FittedBox(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderPage(
                                    selectedTable: widget.selectedTable,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFE0A66B),
                      fixedSize: const Size(230, 60),
                    ),
                    child: Text('Siparişlerim',
                        style: GoogleFonts.judson(
                          fontSize: 27,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryButton(
      BuildContext context, String title, String imagePath) {
    String selectedCategory = ''; // Başlangıçta boş bir değer
    // Daha önceki kodların altına selectedCategory'yi belirleyen kodu ekleyin
    if (title == 'Ana Yemekler') {
      selectedCategory = 'MainFood';
    } else if (title == 'Pide-Lahmacun') {
      selectedCategory = 'PitaLahmacun';
    } else if (title == 'Soğuk İçecekler') {
      selectedCategory = 'ColdDrinks';
    } else if (title == 'Pizzalar') {
      selectedCategory = 'Pizzas';
    } else if (title == 'Burgerler') {
      selectedCategory = 'Burgers';
    } else if (title == 'Sıcak İçecekler') {
      selectedCategory = 'HotDrinks';
    } else if (title == 'Salatalar') {
      selectedCategory = 'Salads';
    } else if (title == 'Çorbalar') {
      selectedCategory = 'Soups';
    }
    return GestureDetector(
      onTap: () {
        if (title == 'Ana Yemekler') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      selectedTable: widget.selectedTable,
                      title: title,
                      selectedCategory: selectedCategory,
                    )),
          );
        } else if (title == 'Pide-Lahmacun') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      selectedTable: widget.selectedTable,
                      title: title,
                      selectedCategory: selectedCategory,
                    )),
          );
        } else if (title == 'Soğuk İçecekler') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      selectedTable: widget.selectedTable,
                      title: title,
                      selectedCategory: selectedCategory,
                    )),
          );
        } else if (title == 'Pizzalar') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      selectedTable: widget.selectedTable,
                      title: title,
                      selectedCategory: selectedCategory,
                    )),
          );
        } else if (title == 'Burgerler') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      selectedTable: widget.selectedTable,
                      title: title,
                      selectedCategory: selectedCategory,
                    )),
          );
        } else if (title == 'Çorbalar') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      selectedTable: widget.selectedTable,
                      title: title,
                      selectedCategory: selectedCategory,
                    )),
          );
        } else if (title == 'Salatalar') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      selectedTable: widget.selectedTable,
                      title: title,
                      selectedCategory: selectedCategory,
                    )),
          );
        } else if (title == 'Sıcak İçecekler') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      selectedTable: widget.selectedTable,
                      title: title,
                      selectedCategory: selectedCategory,
                    )),
          );
        }
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
                      width: 160,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16)),
                    ),
                    child: Container(
                      width: 160,
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          title,
                          style: GoogleFonts.judson(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
    );
  }
}
