
class Transaction{

  String typeDoc, taxType;
  int transacId, number, productId,customerId;
  double qty, unitPrice, scDiscountAmt, pdwDiscountAmt, otherDiscountAmt, nonVatSales, vatableSales, vatAmt,vatExemptSales,zeroRatedSales;

  List<String> columns = ["transacId","typeDoc","number","productId","qty","unitPrice",
    "scDiscountAmt","pdwDiscountAmt","otherDiscountAmt","taxType",
  "nonVatSales","vatableSales","vatAmt","vatExemptSales","zeroRatedSales"];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "transacId" : transacId,
      "typeDoc" : typeDoc,
      "number" : number,
      "productId" : productId,
      "qty" : qty,
      "unitPrice" : unitPrice,
      "scDiscountAmt" : scDiscountAmt,
      "pdwDiscountAmt" : pdwDiscountAmt,
      "otherDiscountAmt" : otherDiscountAmt,
      "taxType" : taxType,
      "nonVatSales" : nonVatSales,
      "vatableSales" : vatableSales,
      "vatAmt" : vatAmt,
      "vatExemptSales" : vatExemptSales,
      "zeroRatedSales" : zeroRatedSales,
      "customerId" : customerId,
    };
    return map;
  }

  Transaction({
    this.typeDoc, this.taxType, this.transacId, this.number, this.productId,
    this.qty, this.unitPrice, this.scDiscountAmt, this.pdwDiscountAmt, this.otherDiscountAmt, this.nonVatSales, this.vatableSales, this.vatAmt,
    this.vatExemptSales,this.zeroRatedSales,this.customerId
});

  factory Transaction.fromMap(Map<String, dynamic> map) {
    Transaction t = new Transaction(
        transacId : map["transacId"],
        typeDoc : map["typeDoc"],
        number : map["number"],
        productId : map["productId"],
        qty : map["qty"],
        unitPrice : map["unitPrice"],
        scDiscountAmt : map["scDiscountAmt"],
        pdwDiscountAmt : map["pdwDiscountAmt"],
        otherDiscountAmt : map["otherDiscountAmt"],
        taxType : map["taxType"],
        nonVatSales : map["nonVatSales"],
        vatableSales : map["vatableSales"],
        vatAmt : map["vatAmt"],
    vatExemptSales : map["vatExemptSales"],
    zeroRatedSales : map["zeroRatedSales"],
        customerId : map["customerId"]
    );

    return t;
  }
}
