class Registermodel {
  Registermodel({
    required this.data,
  });
  late final Data data;

  Registermodel.fromJson(Map<String, dynamic> json) {
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
    required this.token,
    required this.user,
  });
  late final Token token;
  late final User user;

  Data.fromJson(Map<String, dynamic> json) {
    token = Token.fromJson(json['token']);
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token.toJson();
    _data['user'] = user.toJson();
    return _data;
  }
}

class Token {
  Token({
    required this.iat,
    required this.exp,
    required this.authToken,
  });
  late final String iat;
  late final String exp;
  late final String authToken;

  Token.fromJson(Map<String, dynamic> json) {
    iat = json['iat'];
    exp = json['exp'];
    authToken = json['auth_token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iat'] = iat;
    _data['exp'] = exp;
    _data['auth_token'] = authToken;
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

  User.fromJson(Map<String, dynamic> json) {
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
