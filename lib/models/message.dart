class Message {
  Message();

  String? dataMessage;
  num? idMessage;
  String? message;
  bool? messageRead;

  Message.fromJson(Map<String, dynamic> json) {
    dataMessage = json['dateMessage'].toString();
    idMessage = json['idMessage'];
    message = json['message'];
    messageRead = json['messageRead'];
  }

}
