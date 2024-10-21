class UserDataModel {
  String? uid;
  String? email;
  String? username;

  UserDataModel({this.email, this.uid, this.username});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['username'] = username;
    return data;
  }
}
