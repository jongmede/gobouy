
class Product {

  String productName, productCode;
  int categoryId, productId;
  int nonVat = 0;
  int vat = 0;
  int scDiscount = 0;
  int pwdDiscount = 0;
  int otherDiscount = 0;
  int scVatExempt, pwdVatExempt, zeroRated;
  double unitCost = 0;
  double unitPrice = 0;
  double scDiscountPercent = 0;
  double pwdDiscountPercent = 0;
  double otherDiscountPercent = 0;

  List<String> columns = ['productId', 'productName', 'categoryId', 'productCode', 'unitCost',
    'unitPrice', 'nonVat', 'vat', 'scDiscount', 'scDiscountPercent', 'pwdDiscount',
    'pwdDiscountPercent', 'otherDiscount', 'otherDiscountPercent', 'scVatExempt'];

  Product();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'productId': productId,
      'productName': productName,
      'categoryId': categoryId,
      'productCode': productCode,
      'unitCost': unitCost,
      'unitPrice': unitPrice,
      'nonVat': nonVat,
      'vat': vat,
      'scDiscount': scDiscount,
      'scDiscountPercent': scDiscountPercent,
      'pwdDiscount': pwdDiscount,
      'pwdDiscountPercent': pwdDiscountPercent,
      'otherDiscount': otherDiscount,
      'otherDiscountPercent': otherDiscountPercent,
      'scVatExempt': scVatExempt,
      'pwdVatExempt': pwdVatExempt,
      'zeroRated': zeroRated,
    };
    return map;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    Product p = new Product();
    p.productId = map['productId'];
    p.productName = map['productName'];
    p.categoryId = map['categoryId'];
    p.productCode = map['productCode'];
    p.unitCost = map['unitCost'];
    p.unitPrice = map['unitPrice'];
    p.nonVat = map['nonVat'];
    p.vat = map['vat'];
    p.scDiscount = map['scDiscount'];
    p.scDiscountPercent = map['scDiscountPercent'];
    p.pwdDiscount = map['pwdDiscount'];
    p.pwdDiscountPercent = map['pwdDiscountPercent'];
    p.otherDiscount = map['otherDiscount'];
    p.otherDiscountPercent = map['otherDiscountPercent'];
    p.scVatExempt = map['scVatExempt'];
    p.pwdVatExempt = map['pwdVatExempt'];
    p.zeroRated = map['zeroRated'];
    return p;
  }

  void setProductId(int id) {
    this.productId = id;
  }
}
