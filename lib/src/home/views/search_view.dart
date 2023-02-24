import 'package:fake_store/src/product/bloc/product_bloc.dart';
import 'package:fake_store/src/product/views/widgets/products_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Search',
          ),
          onChanged: (value) =>
              context.read<ProductBloc>().add(ProductSearched(value)),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return ProductsListWidget(
            products: state.searchedList,
          );
        },
      ),
    );
  }
}
