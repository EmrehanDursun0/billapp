import 'package:billapp/menu_upgrade/dynamic_category_meal_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DynamicCustomGridTile extends StatelessWidget {
  const DynamicCustomGridTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.id,
  });
  final String imagePath;
  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
        child: AspectRatio(
          aspectRatio: 1.0, //kare boyutu
          child: FittedBox(
            fit: BoxFit.cover,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // Görüntüyü ekrana sığdırma
                  width: 100,
                  height: 80,
                ),
                Container(
                  color: const Color.fromARGB(150, 0, 0, 0),
                  height: 17,
                  width: 100,
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: GoogleFonts.judson(
                      color: Colors.white,
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DynamicCategoryItemsPage(
                collectionName: title,
                categoryId: id,
              ),
            ),
          );
        },
      )),
    );
  }
}
