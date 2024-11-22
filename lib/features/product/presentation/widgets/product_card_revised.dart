import 'package:flutter/material.dart';
import 'package:product_todo/features/product/domain/entities/product.dart';

class ProductCardRevised extends StatelessWidget {
  const ProductCardRevised(
      {super.key, required this.product, required this.onDelete});
  final Product product;
  final VoidCallback onDelete;

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
            const SizedBox(height: 12), // Espacio entre el texto y el ícono
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [
                  Icon(
                    product.approved! ? Icons.check : Icons.close,
                    color: product.approved! ? Colors.green : Colors.red,// Cambia el color según la aprobación
                  ),
                  Text(product.approved! ? 'Aprobado' : 'Rechazado'),
                ],),
                const SizedBox(height: 12),
                IconButton(
                  icon: const Icon(Icons.remove_red_eye_outlined),
                  onPressed: () {
                    // Acción al presionar el ícono (navegar a los detalles)
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(product.name!),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(product.description!),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Cerrar el dialog
                              },
                              child: const Text('Cerrar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  tooltip: 'Ver Detalles', // Tooltip para accesibilidad
                ),
                const SizedBox(height: 12),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete, // Llama a la función para eliminar
                  tooltip: 'Eliminar Producto',
                  color: Colors.red,
                ),
              ],
            )
            
          ],
        ),
      ),
    );
  }
}
