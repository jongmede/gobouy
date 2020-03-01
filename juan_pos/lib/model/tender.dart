
class Tender {

  // CARD TYPE: 1 = VISA, 2 =  MASTER_CARD
  int tenderId, ctrId, transactionId, cashPay, cardPay, cardType, cardNum, transactionRefId, contactId, userId;
  String approvalCode;
  double amount;

  Tender();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'tenderId' : tenderId,
      'ctrId' : ctrId,
      'transactionId' : transactionId,
      'cashPay' : cashPay,
      'cardPay' : cardPay,
      'cardType' : cardType,
      'cardNum' : cardNum,
      'transactionRefId' : transactionRefId,
      'contactId' : contactId,
      'userId' : userId,
      'approvalCode' : approvalCode,
      'amount' : amount,
    };
    return map;
  }

  factory Tender.fromMap(Map<String, dynamic> map) {
    Tender t = new Tender();
    t.tenderId = map['tenderId'];
    t.ctrId = map['ctrId'];
    t.transactionId = map['transactionId'];
    t.cashPay = map['cashPay'];
    t.cardPay = map['cardPay'];
    t.cardType = map['cardType'];
    t.cardNum = map['cardNum'];
    t.transactionRefId = map['transactionRefId'];
    t.contactId = map['contactId'];
    t.userId = map['userId'];
    t.approvalCode = map['approvalCode'];
    t.amount = map['amount'];

    return t;
  }

}
