// var chatModel = {
//   "chatText": "hi",
//   "dateTime": "qwerty",
//   "imageUrl": "wert",
//   "status": 0,
//   "receiverUser": {
//     "email": "qwer",
//     "uid": "wert",
//     "name": "qwert",
//     "userImageUrl": "qwerty"
//   },
//   "senderUser": {
//     "email": "qwer",
//     "uid": "wert",
//     "name": "qwert",
//     "userImageUrl": "qwert"
//   },
// };

class ChatModel {
  ChatModel({
    required this.chatText,
    required this.dateTime,
    required this.imageUrl,
    required this.status,
    required this.receiverUser,
    required this.senderUser,
  });
  late final String chatText;
  late final String dateTime;
  late final String imageUrl;
  late final int status;
  late final ChatUser receiverUser;
  late final ChatUser senderUser;

  ChatModel.fromJson(Map<String, dynamic> json) {
    chatText = json['chatText'];
    dateTime = json['dateTime'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    receiverUser = ChatUser.fromJson(json['receiverUser']);
    senderUser = ChatUser.fromJson(json['senderUser']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['chatText'] = chatText;
    _data['dateTime'] = dateTime;
    _data['imageUrl'] = imageUrl;
    _data['status'] = status;
    _data['receiverUser'] = receiverUser.toJson();
    _data['senderUser'] = senderUser.toJson();
    return _data;
  }
}

class ChatUser {
  ChatUser({
    required this.email,
    required this.uid,
    required this.name,
    required this.userImageUrl,
  });
  late final String email;
  late final String uid;
  late final String name;
  late final String userImageUrl;

  ChatUser.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uid = json['uid'];
    name = json['name'];
    userImageUrl = json['userImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['uid'] = uid;
    _data['name'] = name;
    _data['userImageUrl'] = userImageUrl;
    return _data;
  }
}
