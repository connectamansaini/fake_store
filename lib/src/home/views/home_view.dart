import 'package:fake_store/src/core/domain/enums.dart';
import 'package:fake_store/src/home/views/home_view_success.dart';
import 'package:fake_store/src/home/views/search_view.dart';
import 'package:fake_store/src/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake Store'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => const SearchView(),
                ),
              );
            },
          ),
          const SizedBox(
            width: 16,
          )
        ],
        centerTitle: true,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.productStatus == ProductStatus.failure) {
            return const Center(child: Text('Something went wrong'));
          }
          if (state.productStatus == ProductStatus.success) {
            return const HomeViewSuccess();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
