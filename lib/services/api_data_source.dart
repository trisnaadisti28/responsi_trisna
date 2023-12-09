import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadCategories() {
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> loadMeals(String kategori){
    String kate = kategori;
    return BaseNetwork.get("filter.php?c=$kate");
  }

  Future<Map<String, dynamic>> loadDetails(int idMeals){
    String id = idMeals.toString();
    return BaseNetwork.get("lookup.php?i=$id");
  }
}