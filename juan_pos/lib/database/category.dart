
class Category{

  String categoryName;
  int categoryId;

  List<String> columns = ["categoryId","categoryName"];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "categoryId" : categoryId,
      "categoryName" : categoryName
    };
    return map;
  }

  Category();

  Category.fromMap(Map<String, dynamic> map) {
    categoryId = map["categoryId"];
    categoryName = map["categoryId"];
  }
}
