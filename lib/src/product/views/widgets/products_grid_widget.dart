import 'package:fake_store/src/product/models/product.dart';
import 'package:fake_store/src/product/views/product_view.dart';
import 'package:flutter/material.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({
    required this.products,
    super.key,
  });
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => ProductView(
                  product: products[index],
                ),
              ),
            ),
            child: GridTile(
              footer: Text(
                products[index].title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 32,
                  left: 16,
                  right: 16,
                  top: 8,
                ),
                child: Image(
                  image: NetworkImage(products[index].image),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
