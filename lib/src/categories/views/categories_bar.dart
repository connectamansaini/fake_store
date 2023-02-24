import 'package:fake_store/src/categories/bloc/category_bloc.dart';
import 'package:fake_store/src/core/domain/enums.dart';
import 'package:fake_store/src/product/bloc/product_bloc.dart';
import 'package:fake_store/src/product/repository/product_repository.dart';
import 'package:fake_store/src/product/views/product_by_category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CategoriesBar extends StatelessWidget {
  const CategoriesBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state.categoryStatus == CategoryStatus.failure) {
            return const Text('Failed');
          }
          if (state.categoryStatus == CategoryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: state.categories.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => ProductBloc(
                            context.read<ProductRepository>(),
                          )..add(
                              ProductByCategoryRequested(
                                state.categories[index],
                              ),
                            ),
                          child: const ProductsByCategoryView(),
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 5.h,
                    child: Text(
                      state.categories[index],
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
