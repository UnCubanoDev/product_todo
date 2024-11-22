import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_todo/features/product/domain/entities/product.dart';
import 'package:product_todo/features/product/presentation/bloc/search_product_bloc/search_product_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.image!,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12), // Espacio entre la imagen y el texto
            Text(
              product.name!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12), // Espacio entre el texto y el checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Aprobar', style: TextStyle(fontSize: 16)),
                Checkbox(
                  value: product.approved,
                  onChanged: (bool? value) {
                    BlocProvider.of<SearchProductBloc>(context)
                        .add(OnPutProduct(product: product.copyWith(approved: true)));
                  },
                ),
                const Text('Rechazar', style: TextStyle(fontSize: 16)),
                Checkbox(
                  value: product.refused,
                  onChanged: (bool? value) {
                    BlocProvider.of<SearchProductBloc>(context).add(
                        OnPutProduct(
                            product: product.copyWith(refused: true)));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
