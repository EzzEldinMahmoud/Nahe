class HOMEMODEL {
  HOMEMODEL({
    required this.data,
  });
  late final Data data;
  
  HOMEMODEL.fromJson(Map<String, dynamic> json){
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
    required this.services,
    required this.upcomingAppointments,
  });
  late final User user;
  late final List<Services> services;
  late final List<UpcomingAppointments> upcomingAppointments;
  
  Data.fromJson(Map<String, dynamic> json){
    user = User.fromJson(json['user']);
    services = List.from(json['services']).map((e)=>Services.fromJson(e)).toList();
    upcomingAppointments = List.from(json['upcoming_appointments']).map((e)=>UpcomingAppointments.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    _data['services'] = services.map((e)=>e.toJson()).toList();
    _data['upcoming_appointments'] = upcomingAppointments.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class User {
  User({
    required this.phoneNumber,
    required this.name,
    required this.photo,
    required this.address,
  });
  late final String phoneNumber;
  late final String name;
  late final String photo;
  late final String address;
  
  User.fromJson(Map<String, dynamic> json){
    phoneNumber = json['phone_number'];
    name = json['name'];
    photo = json['photo'];
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

class Services {
  Services({
    required this.id,
    required this.title,
    required this.icon,
    required this.colour,
  });
  late final int id;
  late final String title;
  late final String icon;
  late final String colour;
  
  Services.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    colour = json['colour'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['icon'] = icon;
    _data['colour'] = colour;
    return _data;
  }
}

class UpcomingAppointments {
  UpcomingAppointments({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
    required this.paymentMethod,
    required this.details,
    required this.agent,
  });
  late final int id;
  late final String date;
  late final String time;
  late final int status;
  late final int paymentMethod;
  late final String details;
  late final Agent agent;
  
  UpcomingAppointments.fromJson(Map<String, dynamic> json){
    id = json['id'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    paymentMethod = json['payment_method'];
    details = json['details'];
    agent = Agent.fromJson(json['agent']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['date'] = date;
    _data['time'] = time;
    _data['status'] = status;
    _data['payment_method'] = paymentMethod;
    _data['details'] = details;
    _data['agent'] = agent.toJson();
    return _data;
  }
}

class Agent {
  Agent({
    required this.id,
    required this.name,
     this.photo,
    required this.occupation,
    required this.rating,
    required this.address,
    required this.phoneNumber,
  });
  late final int id;
  late final String name;
    String? photo;
  late final Occupation occupation;
  late final String rating;
  late final String address;
  late final String phoneNumber;
  
  Agent.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    occupation = Occupation.fromJson(json['occupation']);
    rating = json['rating'];
    address = json['address'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['photo'] = photo;
    _data['occupation'] = occupation.toJson();
    _data['rating'] = rating;
    _data['address'] = address;
    _data['phone_number'] = phoneNumber;
    return _data;
  }
}

class Occupation {
  Occupation({
    required this.id,
    required this.title,
    required this.icon,
    required this.colour,
  });
  late final int id;
  late final String title;
  late final String icon;
  late final String colour;
  
  Occupation.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    colour = json['colour'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['icon'] = icon;
    _data['colour'] = colour;
    return _data;
  }
}