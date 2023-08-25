import 'package:billapp/MainFood/firebase/main_firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     const MaterialApp(
//       home: ColdDrinksPage(),
//     ),
//   );
// }

class ColdDrinksPage extends StatefulWidget {
  const ColdDrinksPage({super.key, required this.selectedTable});
  final String selectedTable;
  @override
  ColdDrinksPageState createState() => ColdDrinksPageState();
}

class ColdDrinksPageState extends State<ColdDrinksPage> {
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
        title: FittedBox(
          child: Row(
            children: [
              Text(
                'Soğuk İçecekler',
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 100),
              Text(
                 widget.selectedTable,
                style: GoogleFonts.judson(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: const MainFirebase(
        collectionName: 'ColdDrinks',
      ),
    );
  }
}
