import 'package:fake_store/src/categories/bloc/category_bloc.dart';
import 'package:fake_store/src/categories/repository/category_repository.dart';
import 'package:fake_store/src/core/presentation/theme.dart';
import 'package:fake_store/src/home/views/home_view.dart';
import 'package:fake_store/src/product/bloc/product_bloc.dart';
import 'package:fake_store/src/product/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => ProductRepository(),
            ),
            RepositoryProvider(
              create: (context) => CategoryRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    ProductBloc(context.read<ProductRepository>())
                      ..add(ProductRequested()),
              ),
              BlocProvider(
                create: (context) =>
                    CategoryBloc(context.read<CategoryRepository>())
                      ..add(CategoryRequested()),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppThemes.lightTheme,
              // darkTheme: AppThemes.darkTheme,
              home: const HomeView(),
            ),
          ),
        );
      },
    );
  }
}
