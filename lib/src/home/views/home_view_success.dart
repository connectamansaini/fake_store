import 'package:fake_store/src/categories/views/categories_bar.dart';
import 'package:fake_store/src/product/bloc/product_bloc.dart';
import 'package:fake_store/src/product/views/widgets/product_filter_view.dart';
import 'package:fake_store/src/product/views/widgets/products_grid_widget.dart';
import 'package:fake_store/src/product/views/widgets/products_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeViewSuccess extends StatelessWidget {
  const HomeViewSuccess({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 1.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'CATEGORIES',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.apps))
            ],
          ),
        ),
        SizedBox(
          height: 1.5.h,
        ),
        const CategoriesBar(),
        SizedBox(
          height: 2.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'PRODUCTS',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (context) => const ProductFilterView(),
                  ),
                ),
                icon: const Icon(Icons.filter_list),
              ),
              IconButton(
                onPressed: () {
                  context.read<ProductBloc>().add(ProductViewChanged());
                },
                icon: const Icon(Icons.apps),
              )
            ],
          ),
        ),
        Flexible(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              final list = state.filteredList.isEmpty
                  ? state.products
                  : state.filteredList;
              if (state.isListView) {
                return ProductsListWidget(products: list);
              }

              return ProductGridWidget(products: list);
            },
          ),
        ),
      ],
    );
  }
}
