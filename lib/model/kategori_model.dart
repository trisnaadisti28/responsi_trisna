class CategoriesModel {
  List<Data>? data;

  CategoriesModel({
    this.data,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    data = (json['categories'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['categories'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Data {
  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;

  Data({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  Data.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'] as String?;
    strCategory = json['strCategory'] as String?;
    strCategoryThumb = json['strCategoryThumb'] as String?;
    strCategoryDescription = json['strCategoryDescription'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['idCategory'] = idCategory;
    json['strCategory'] = strCategory;
    json['strCategoryThumb'] = strCategoryThumb;
    json['strCategoryDescription'] = strCategoryDescription;
    return json;
  }
}