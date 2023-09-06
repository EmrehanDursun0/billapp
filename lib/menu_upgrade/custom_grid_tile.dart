import 'package:billapp/menu_upgrade/product_update_page.dart';
import 'package:flutter/material.dart';

class CustomGridTile extends StatelessWidget {
  const CustomGridTile({
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
            child: Image.asset(imagePath),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductUpdatePage(
                          collectionName: title,
                          id: id,
                        )),
              );
            }),
      ),
    );
  }
}
