
class Product{

  String productName, categoryId, productCode;
  int productId;
  int nVat, vat, scDiscount,  pdwDiscount,  otherDiscount,  scVatExempt, pdwVatExempt, zeroRated;
  double unitCost, unitPrice, scDiscountPercent, pdwDiscountPercent, otherDiscountPercent;

  List<String> columns = ["productId","productName","categoryId","productCode","unitCost",
    "unitPrice","nVat","vat","scDiscount","scDiscountPercent","pdwDiscount",
    "pdwDiscountPercent","otherDiscount","otherDiscountPercent","scVatExempt"];


  Product({
      this.productName,this.vat,this.categoryId,this.otherDiscount,this.pdwDiscount,this.scDiscount,this.scVatExempt,this.pdwVatExempt,
      this.otherDiscountPercent,this.scDiscountPercent,this.nVat,this.unitPrice,this.unitCost,
      this.productCode,this.pdwDiscountPercent,this.productId,this.zeroRated}
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "productId" : productId,
      "productName" : productName,
      "categoryId" : categoryId,
      "productCode" : productCode,
      "unitCost" : unitCost,
      "unitPrice" : unitPrice,
      "nVat" : nVat,
      "vat" : vat,
      "scDiscount" : scDiscount,
      "scDiscountPercent" : scDiscountPercent,
      "pdwDiscount" : pdwDiscount,
      "pdwDiscountPercent" : pdwDiscountPercent,
      "otherDiscount" : otherDiscount,
      "otherDiscountPercent" : otherDiscountPercent,
      "scVatExempt" : scVatExempt,
      "pdwVatExempt" : pdwVatExempt,
      "zeroRated" : zeroRated,
    };
    return map;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    Product p = new Product(
        productId : map["productId"],
        productName : map["productName"],
        categoryId : map["categoryId"],
        productCode : map["productCode"],
        unitCost : map["unitCost"],
        unitPrice : map["unitPrice"],
        nVat : map["nVat"],
        vat : map["vat"],
        scDiscount : map["scDiscount"],
        scDiscountPercent : map["scDiscountPercent"],
        pdwDiscount : map["pdwDiscount"],
        pdwDiscountPercent : map["pdwDiscountPercent"],
        otherDiscount : map["otherDiscount"],
    otherDiscountPercent : map["otherDiscountPercent"],
    scVatExempt : map["scVatExempt"],
        pdwVatExempt : map["pdwVatExempt"],
      zeroRated: map["zeroRated"]
    );

    return p;
  }

  void setProductId(int id) {
    this.productId = id;
  }
}
