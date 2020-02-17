
class Tender {

  int tenderId, ctrId, transacId, cashPay, cardPay, cardType, cardNum, transactionRefId, contactId, userId; //CARD TYPE: 1 = VISA, 2 =  MASTER_CARD
  String approvalCode;
  double amount;

  Tender({
    this.tenderId, this.ctrId, this.transacId, this.cashPay, this.cardPay, this.cardType, this.cardNum,
    this.transactionRefId, this.contactId, this.userId, this.approvalCode, this.amount,
  });


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "tenderId" : tenderId,
      "ctrId" : ctrId,
      "transacId" : transacId,
      "cashPay" : cashPay,
      "cardPay" : cardPay,
      "cardType" : cardType,
      "cardNum" : cardNum,
      "transactionRefId" : transactionRefId,
      "contactId" : contactId,
      "userId" : userId,
      "approvalCode" : approvalCode,
      "amount" : amount,
    };
    return map;
  }

  factory Tender.fromMap(Map<String, dynamic> map) {
    Tender t = new Tender(
        tenderId : map["tenderId"],
        ctrId : map["ctrId"],
        transacId : map["transacId"],
        cashPay : map["cashPay"],
        cardPay : map["cardPay"],
        cardType : map["cardType"],
        cardNum : map["cardNum"],
        transactionRefId : map["transactionRefId"],
        contactId : map["contactId"],
        userId : map["userId"],
        approvalCode : map["approvalCode"],
        amount : map["amount"],
    );

    return t;
  }

}

