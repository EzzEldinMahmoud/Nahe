class userinfo {
  userinfo({
    required this.data,
  });
  late final Data data;
  
  userinfo.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.user,
  });
  late final User user;
  
  Data.fromJson(Map<String, dynamic> json){
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.phoneNumber,
    required this.name,
     this.photo,
    required this.address,
  });
  late final String phoneNumber;
  late final String name;
  late final Null photo;
  late final String address;
  
  User.fromJson(Map<String, dynamic> json){
    phoneNumber = json['phone_number'];
    name = json['name'];
    photo = null;
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phone_number'] = phoneNumber;
    _data['name'] = name;
    _data['photo'] = photo;
    _data['address'] = address;
    return _data;
  }
}