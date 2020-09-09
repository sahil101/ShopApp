import 'package:flutter/material.dart';
import 'product_item.dart';
import 'package:shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final showfavs;
  ProductGrid(this.showfavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showfavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
              // create: (c) => products[index],
              value: products[index],
              child: ProductItem(),
            ));
  }
}
