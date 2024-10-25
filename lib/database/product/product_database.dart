import 'package:ksu_budidaya/core.dart';

class ProductDatabase {
  static ProductResult productResult = ProductResult();

  static load() async {
    productResult = mainStorage.get("productResult") ?? ProductResult();
  }

  static save(ProductResult productResult) async {
    mainStorage.put("productResult", productResult);
    ProductDatabase.productResult = productResult;
  }
}
