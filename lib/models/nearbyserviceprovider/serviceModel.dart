class Servicemodel {
  Servicemodel({
    required this.data,
  });
  late final Data data;
  
  Servicemodel.fromJson(Map<String, dynamic> json){
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
    required this.nearbyAgents,
    required this.catalogue,
  });
  late final List<NearbyAgents> nearbyAgents;
  late final List<Catalogue> catalogue;
  
  Data.fromJson(Map<String, dynamic> json){
    nearbyAgents = List.from(json['nearby_agents']).map((e)=>NearbyAgents.fromJson(e)).toList();
    catalogue = List.from(json['catalogue']).map((e)=>Catalogue.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nearby_agents'] = nearbyAgents.map((e)=>e.toJson()).toList();
    _data['catalogue'] = catalogue.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class NearbyAgents {
  NearbyAgents({
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
  late final String? photo;
  late final Occupation occupation;
  late final String rating;
  late final String address;
  late final String phoneNumber;
  
  NearbyAgents.fromJson(Map<String, dynamic> json){
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

class Catalogue {
  Catalogue({
    required this.id,
    required this.title,
    required this.icon,
    required this.colour,
  });
  late final int id;
  late final String title;
  late final String icon;
  late final String colour;
  
  Catalogue.fromJson(Map<String, dynamic> json){
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