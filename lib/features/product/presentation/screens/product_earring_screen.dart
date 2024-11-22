import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_todo/features/product/presentation/bloc/search_product_bloc/search_product_bloc.dart';
import 'package:product_todo/features/product/presentation/widgets/product_card.dart';

class ProductEarringScreen extends StatelessWidget {
  const ProductEarringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchProductBloc>(context).add(OnGetProducts());
    return BlocBuilder<SearchProductBloc, SearchProductState>(
      builder: (context, state) {
        switch (state) {
          case SearchProductInitial():
            return const Center(child: Text('No hay productos por revisar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
          case SearchProductLoading():
            return const Center(child: CircularProgressIndicator()); 
          case SearchProductList():
            return state.products.isNotEmpty ?
            SizedBox.expand(
              child: ListView(
                shrinkWrap: true,
                children:
                    state.products.map((p) => ProductCard(product: p)).toList(),
              ),
            ) : const Center(
                child: Text(
              'No hay productos por revisar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
          case SearchProductFailure():
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                      'A ocurrido un error, que te parece si lo intentamos nuevamente'),
                  TextButton(
                      onPressed: () =>
                          BlocProvider.of<SearchProductBloc>(context)
                              .add(OnGetProducts()),
                      child: const Text('Cargar lista de productos'))
                ],
              ),
            );
        }
      },
    );
  }
}
