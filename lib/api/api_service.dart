import 'dart:convert';

import 'package:my_p/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //Fetch all product from the Api
  Future<List<Product>> fetchAllProducts() async {
    const String url = 'https://fakestoreapi.com/products';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);

        List<Product> products = responseData.map((json) {
          return Product.fromJson(json);
        }).toList();
        return products;
      } else {
        print("Faild to fetch product the status code ${response.statusCode}");
        throw Exception("Faild to fetch products");
      }
    } catch (e) {
      print("Error:$e");
      throw Exception("Faild to fetch product");
    }
  }

  //fetch a single product from api
  Future<Product> fetchSingleProduct(int id) async {
    final String url = "https://fakestoreapi.com/products/$id";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Product product = Product.fromJson(json.decode(response.body));
        return product;
      } else {
        print(
            "Faild to fetch product and status code : ${response.statusCode}");
        throw Exception("Faild to Fetch product");
      }
    } catch (e) {
      print("Error:$e");
      throw Exception("Faild to Fetch product");
    }
  }

  //add a product to api

  Future<Product> addProduct(Product product) async {
    const String url = "https://fakestoreapi.com/products";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );
      print("Response status code : ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("response:${response.body}");
        Product newProduct = Product.fromJson(json.decode(response.body));
        return newProduct;
      } else {
        print("Failed to add product. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to add product");
      }
    } catch (e) {
      print("Error:$e");
      throw Exception("Faild to add Product");
    }
  }

  //Update a product in the Api
  Future<Product> updteProduct(int id, Product product) async {
    final String url = "https://fakestoreapi.com/products/${id}";

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode == 200) {
        print("response: ${response.body}");
        Product updatedProduct = Product.fromJson(json.decode(response.body));

        return updatedProduct;
      } else {
        print("Failed to add product. Status code: ${response.statusCode}");

        throw Exception("Failed to add product");
      }
    } catch (error) {
      print("Error:$error");
      throw Exception("Faild To Update Product");
    }
  }

  // Delete a product from the API
  Future<void> deleteProduct(int id) async {
    final String url = "https://fakestoreapi.com/products/$id";
    try {
      final response = await http.delete(Uri.parse(url));

      print("Response status code: ${response.statusCode}");
      // Print the body of the response
      print("Response body: ${response.body}");

      if (response.statusCode != 200) {
        print("Failed to delete product. Status code: ${response.statusCode}");
        throw Exception("Failed to delete product");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to delete product");
    }
  }
}
