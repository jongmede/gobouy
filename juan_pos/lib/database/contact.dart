
class Contact{

  String contactName, address, busStyle, tin, pwId, scId;
  int contactId;

  List<String> columns = ["contactId","contactName","address","tin","busStyle","pwId","scId"];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "contactId" : contactId,
      "contactName" : contactName,
      "address" : address,
      "tin" : tin,
      "busStyle" : busStyle,
      "pwId" : pwId,
      "scId" : scId
    };
    return map;
  }

  Contact(
  {
    this.contactId,
    this.contactName,
    this.address,
    this.tin,
    this.busStyle,
    this.scId,
    this.pwId
  }
      );

  factory Contact.fromMap(Map<String, dynamic> map) {
    Contact c = new Contact(
      contactId : map["contactId"],
      contactName : map["contactName"],
      address : map["address"],
      tin : map["tin"],
      busStyle : map["busStyle"],
      pwId : map["pwId"],
      scId : map["scId"],
    );

    return c;
  }
}
