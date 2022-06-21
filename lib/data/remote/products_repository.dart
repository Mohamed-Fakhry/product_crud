import 'package:products_crud/data/models/product_model.dart';

import '../models/page_model.dart';
import '../models/pair_model.dart';
import 'network_common.dart';

class ProductsRepository {
  const ProductsRepository();

  Future<Pair<Page, List<Product>>> getProducts(
    int page,
  ) {
    Map<String, dynamic> query = {
      "page": page,
      "limit": 20,
    };

    return NetworkCommon()
        .dio
        .get("products", queryParameters: query)
        .then((response) {
      Page page = Page.fromJson(response.data);
      List<Product> products = (response.data['docs'] as List)
          .map((product) => Product.fromJson(product))
          .toList();

      return Pair(
        page,
        products,
      );
    });
  }

  Future<Product> addProduct(Product product) async {
    return NetworkCommon()
        .dio
        .post("products", data: product.toJson())
        .then((response) {
      return Product.fromJson(response.data);
    });
  }

  Future<Product> updateProduct(Product product) async {
    return NetworkCommon()
        .dio
        .put("products/${product.id}", data: product.toJson())
        .then((response) {
      return Product.fromJson(response.data);
    });
  }

  Future<Product> deleteProduct(Product product) async {
    return NetworkCommon()
        .dio
        .delete("products/${product.id}")
        .then((response) {
      return Product.fromJson(response.data);
    });
  }
}
