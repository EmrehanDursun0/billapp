import 'package:billapp/case_menu/case_menu_page.dart';
import 'package:billapp/menu_upgrade/dynamic_menu_page.dart';
import 'package:billapp/models/table.dart';
import 'package:billapp/providers/bill_app_provider.dart';
import 'package:billapp/providers/table_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  bool personelSelected = false;
  String selectedTable = '';

  Future<void> tableSelection(BuildContext context) async {
 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TableProvider tableProvider = context.read<TableProvider>();
        final List<TableModel> allTables = tableProvider.allTables;
        return AlertDialog(
          backgroundColor: const Color(0xFFE0A66B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
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
                    "Masa Seçimi",
                    style: GoogleFonts.judson(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 12),
                height: 340,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: allTables.length,
                  itemBuilder: (BuildContext context, int index) {
                    final table = allTables[index];
                    return ListTile(
                      onTap: () {
                        tableProvider.selectTable(table);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DynamicMenuPage(),
                          ),
                        );
                      },
                      title: Text(
                        table.name,
                        style: GoogleFonts.judson(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
                'Overtech',
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
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
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
                          billAppProvider.setMenuModeToCustomer();
                          tableSelection(context);
                          setState(() {
                            personelSelected = false;
                          });
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
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                          child: Center(
                            child: Text(
                              'Müşteri',
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
                          setState(() {
                            personelSelected = true;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CaseHomePage(
                                      selectedTable: '',
                                    )),
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
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                          child: Center(
                            child: Text(
                              'Personel',
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
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                          child: Center(
                            child: Text(
                              'Çıkış',
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
