import 'package:fake_store/src/core/domain/enums.dart';
import 'package:fake_store/src/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProductFilterView extends StatelessWidget {
  const ProductFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        elevation: 0,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    onTap: () {
                      context.read<ProductBloc>().add(
                            FilterViewChanged(
                              ProductFilterType.price,
                            ),
                          );
                    },
                    title: const Text('Price'),
                  ),
                ),
                Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    onTap: () {
                      context.read<ProductBloc>().add(
                            FilterViewChanged(
                              ProductFilterType.rating,
                            ),
                          );
                    },
                    title: const Text('Rating'),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state.productFilterType == ProductFilterType.price) {
                return const PriceFilterPage();
              }

              return const RatingFilterPage();
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            heroTag: 'clear',
            onPressed: () {
              context.read<ProductBloc>().add(FiltersRemoved());
            },
            label: const Text('Clear Filters'),
          ),
          SizedBox(
            width: 2.w,
          ),
          FloatingActionButton.extended(
            heroTag: 'submit',
            onPressed: () {
              context.read<ProductBloc>().add(ProductsFiltered());
              Navigator.pop(context);
            },
            label: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class PriceFilterPage extends StatefulWidget {
  const PriceFilterPage({
    super.key,
  });
  @override
  State<PriceFilterPage> createState() => _PriceFilterPageState();
}

class _PriceFilterPageState extends State<PriceFilterPage> {
  final choices = [
    20,
    100,
    500,
    1000,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 12),
        itemCount: choices.length,
        itemBuilder: (BuildContext context, int index) {
          final choice = choices[index];
          return BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.centerLeft,
                child: ChoiceChip(
                  label: Text('Under $choice'),
                  selected: state.priceFilter == choice,
                  selectedColor: Colors.lightBlue,
                  onSelected: (bool selected) {
                    context
                        .read<ProductBloc>()
                        .add(PriceFilterChanged(choices[index]));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class RatingFilterPage extends StatefulWidget {
  const RatingFilterPage({
    super.key,
  });
  @override
  State<RatingFilterPage> createState() => _RatingFilterPageState();
}

class _RatingFilterPageState extends State<RatingFilterPage> {
  final choices = [
    4,
    3,
    2,
    1,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 12),
        itemCount: choices.length,
        itemBuilder: (BuildContext context, int index) {
          final choice = choices[index];
          return BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.centerLeft,
                child: ChoiceChip(
                  label: Text('Rating $choice+'),
                  selected: state.ratingFilter == choice,
                  selectedColor: Colors.lightBlue,
                  onSelected: (bool selected) {
                    context
                        .read<ProductBloc>()
                        .add(RatingFilterChanged(choices[index]));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
