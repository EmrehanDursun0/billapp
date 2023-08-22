import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:billapp/MainFood/food_firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:billapp/firebase_options.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
          title: const Row(children: [Text('Ana yemekler')]),
        ),

        body: const FoodFirebase(),

        // body: Stack(
        //   fit: StackFit.expand,
        //   children: [
        //     Positioned.fill(
        //       child: Opacity(
        //         opacity: 0.6,
        //         child: Image.asset(
        //           'assets/menu/splash.png', // Arka plan resminin yolu
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //     ),

        //     Center(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.end, // En altta hizalama
        //         children: [
        //           ElevatedButton(
        //             onPressed: () {},
        //             style: ElevatedButton.styleFrom(
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(30),
        //               ),
        //               foregroundColor: Colors.black,
        //               backgroundColor: const Color(0xFFE0A66B),
        //               fixedSize: const Size(230, 60),
        //             ),
        //             child: Text(
        //               'Siparişe Devam Et ',
        //               style: GoogleFonts.judson(
        //                 fontSize: 25,
        //                 color: Colors.black,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     //FoodFirebase()
        //   ],
        // ),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainFoodPage());
}
