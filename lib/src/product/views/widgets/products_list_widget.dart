import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store/src/product/models/product.dart';
import 'package:fake_store/src/product/views/product_view.dart';
import 'package:flutter/material.dart';

class ProductsListWidget extends StatelessWidget {
  const ProductsListWidget({
    required this.products,
    super.key,
  });
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: products.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            tileColor: Colors.white,
            iconColor: Colors.black,
            textColor: Colors.black,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            onTap: () => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => ProductView(
                  product: products[index],
                ),
              ),
            ),
            leading: Image(
              image: CachedNetworkImageProvider(products[index].image),
            ),
            title: Text(products[index].title),
            //This is too delete one product item

            // trailing: IconButton(
            //   onPressed: () {
            //     context.read<ProductBloc>().add(ProductDeleted(index));
            //   },
            //   icon: const Icon(Icons.delete_forever),
            // ),
            // isThreeLine: true,
          ),
        );
      },
    );
  }
}
