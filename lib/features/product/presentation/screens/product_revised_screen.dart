import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_todo/features/product/presentation/bloc/revised_product_bloc/revised_product_bloc.dart';
import 'package:product_todo/features/product/presentation/widgets/product_card_revised.dart';

class ProductRevisedScreen extends StatefulWidget {
  const ProductRevisedScreen({super.key});

  @override
  State<ProductRevisedScreen> createState() => _ProductRevisedScreenState();
}

class _ProductRevisedScreenState extends State<ProductRevisedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RevisedProductBloc>(context);
    bloc.add(OnGetLocalProducts());
    
    return BlocBuilder<RevisedProductBloc, RevisedProductState>(
      builder: (context, state) {
        switch (state) {
          case RevisedProductLoading():
            return const Center(child: CircularProgressIndicator());
          case RevisedProductInitial():
            return const Center(
                child: Text(
              'No hay productos revisados',
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
          case RevisedProductList():
            _scrollController.addListener(() {
              if (_scrollController.position.pixels ==
                  _scrollController.position.maxScrollExtent) {
                bloc.add(
                    OnGetLocalProducts());
              }
            });
            return SizedBox.expand(
              child: ListView.builder(
                itemCount: state.products.length,
                controller: _scrollController,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductCardRevised(
                    product: state.products[index],
                    onDelete: () => BlocProvider.of<RevisedProductBloc>(context)
                        .add(OnDeleteProduct(
                            id: state.products[index].id.toString())),
                  );
                },
              ),
            );
          case RevisedProductFailure():
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                      'A ocurrido un error, que te parece si lo intentamos nuevamente'),
                  TextButton(
                      onPressed: () =>
                          BlocProvider.of<RevisedProductBloc>(context)
                              .add(OnGetProducts()),
                      child: const Text('Cargar lista de productos'))
                ],
              ),
            );
          case RevisedProductListLoaded():
            return Container();
        }
      },
    );
  }
}
