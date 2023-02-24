import 'package:fake_store/src/core/domain/enums.dart';
import 'package:fake_store/src/product/bloc/product_bloc.dart';
import 'package:fake_store/src/product/views/widgets/products_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsByCategoryView extends StatelessWidget {
  const ProductsByCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.productStatus == ProductStatus.success) {
            return ProductsListWidget(products: state.products);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
