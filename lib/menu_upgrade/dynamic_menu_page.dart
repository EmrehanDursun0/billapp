// ignore_for_file: file_names

import 'package:billapp/menu_upgrade/dynamic_categories_appbar.dart';
import 'package:billapp/menu_upgrade/dynamic_categories_page_button.dart';
import 'package:billapp/menu_upgrade/dynamic_custom_grid_tile.dart';
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 0.5),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: allCategories.length,
                      itemBuilder: ((context, index) {
                        if (index < allCategories.length) {
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
                  const SizedBox(height: 20),
                  const DynamicCategoriesPageButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
