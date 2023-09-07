// ignore_for_file: file_names
import 'package:billapp/menu_update/dynamic_custom_grid_tile.dart';
import 'package:billapp/menu_update/dynamic_categories_appbar.dart';
import 'package:billapp/models/category.dart';
import 'package:billapp/providers/categoires_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DynamicMenuPage extends StatelessWidget {
  const DynamicMenuPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    categoryProvider.fetchAllCategories();
    final List<CategoryModel> allCategories = categoryProvider.allCategories;
    return Scaffold(
      appBar: const DynamicCategoriesAppbar(),
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
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 50,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: allCategories.length,
                    itemBuilder: ((context, index) {
                      if (index <= allCategories.length) {
                        return DynamicCustomGridTile(
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
            ),
          ],
        ),
      ),
    );
  }
}
