import 'package:flutter/material.dart';
import 'package:my_p/api/api_service.dart';
import 'package:my_p/models/product_model.dart';
import 'package:my_p/pages/edit_product.dart';

class SingleProduct extends StatelessWidget {
  final int productId;
  SingleProduct({
    super.key,
    required this.productId,
  });

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Deatils"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Product>(
          future: apiService.fetchSingleProduct(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text("Produt Not Found"),
              );
            } else {
              Product product = snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product.image,
                      width: 400,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      product.title,
                      style: const TextStyle(fontSize: 24.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(fontSize: 20.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(product.description),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProduct(product: product),
                              ),
                            );
                          },
                          child: Text("Updated"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await apiService.deleteProduct(product.id!);
                            Navigator.pop(context);
                          },
                          child: Text("Delete"),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
