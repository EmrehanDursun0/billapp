// ignore_for_file: file_names
import 'package:billapp/menu_upgrade/custom_grid_tile.dart';
import 'package:billapp/models/category.dart';
import 'package:billapp/providers/categoires_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuUpdatePage extends StatelessWidget {
  const MenuUpdatePage({super.key, required this.selectedtitle});
  final String selectedtitle;

  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    categoryProvider.fetchAllCategories();
    final List<CategoryModel> allCategories = categoryProvider.allCategories;
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
        title: Text(
          'Menü Güncelle',
          style: GoogleFonts.judson(
            fontSize: 33,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            FittedBox(
              fit: BoxFit.cover,
              child: Image.asset('assets/menu/splash.png'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: allCategories.length,
                  itemBuilder: ((context, index) {
                    if (index <= allCategories.length) {
                      return CustomGridTile(
                        imagePath: allCategories[index].imagePath!,
                        title: allCategories[index].name!,
                        id: allCategories[index].id!,
                      );
                    }
                    return null;
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
