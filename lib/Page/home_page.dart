import 'package:billapp/Page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/bill_app_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeApplication(context));
  }

  Future _initializeApplication(BuildContext context) async {
    final billAppProvider = context.read<BillAppProvider>();
      await billAppProvider.initializeApplication(context);
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: screenHeight * 0.2),
                Text('Overtech Restorant',
                    style: GoogleFonts.judson(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 20),
                Text('Hoş Geldiniz',
                    style: GoogleFonts.judson(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: screenHeight * 0.1),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.08),
                    ),
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFE0A66B),
                    fixedSize: const Size(180, 50),
                  ),
                  child: Text('Giriş Yapınız',
                      style: GoogleFonts.judson(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
