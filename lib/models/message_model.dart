class MessageModel {
  String? text;
  String? dateTime;
  String? senderId;
  String? receiverId;
  String? chatImage;

  MessageModel({
    this.text,
    this.dateTime,
    this.senderId,
    this.receiverId,
    this.chatImage,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    dateTime = json['dateTime'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    chatImage = json['chatImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'dateTime': dateTime,
      'senderId': senderId,
      'receiverId': receiverId,
      'chatImage': chatImage,
    };
  }
}
