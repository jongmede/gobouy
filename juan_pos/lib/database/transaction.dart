
class Transaction{

  String typeDoc, taxType;
  int transactionId, number, productId, customerId;
  double qty, unitPrice, scDiscountAmt, pwdDiscountAmt, otherDiscountAmt, nonVatSales, vatableSales, vatAmt, vatExemptSales, zeroRatedSales;

  List<String> columns = ["transacId","typeDoc","number","productId","qty","unitPrice",
    "scDiscountAmt","pwdDiscountAmt","otherDiscountAmt","taxType",
  "nonVatSales","vatableSales","vatAmt","vatExemptSales","zeroRatedSales"];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "transacId" : transactionId,
      "typeDoc" : typeDoc,
      "number" : number,
      "productId" : productId,
      "qty" : qty,
      "unitPrice" : unitPrice,
      "scDiscountAmt" : scDiscountAmt,
      "pwdDiscountAmt" : pwdDiscountAmt,
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
    this.typeDoc, this.taxType, this.transactionId, this.number, this.productId,
    this.qty, this.unitPrice, this.scDiscountAmt, this.pwdDiscountAmt, this.otherDiscountAmt, this.nonVatSales, this.vatableSales, this.vatAmt,
    this.vatExemptSales, this.zeroRatedSales, this.customerId
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    Transaction t = new Transaction(
      transactionId : map["transacId"],
      typeDoc : map["typeDoc"],
      number : map["number"],
      productId : map["productId"],
      qty : map["qty"],
      unitPrice : map["unitPrice"],
      scDiscountAmt : map["scDiscountAmt"],
      pwdDiscountAmt : map["pwdDiscountAmt"],
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
