class APPOINTMENTMODEL {
  APPOINTMENTMODEL({
    required this.data,
  });
  late final Data data;

  APPOINTMENTMODEL.fromJson(Map<String, dynamic> json) {
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
    required this.upcomingAppointments,
    required this.archivedAppointments,
  });
  late final List<UpcomingAppointments> upcomingAppointments;
  late final List<ArchivedAppointments> archivedAppointments;

  Data.fromJson(Map<String, dynamic> json) {
    upcomingAppointments = List.from(json['upcoming_appointments'])
        .map((e) => UpcomingAppointments.fromJson(e))
        .toList();
    archivedAppointments = List.from(json['archived_appointments'])
        .map((e) => ArchivedAppointments.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['upcoming_appointments'] =
        upcomingAppointments.map((e) => e.toJson()).toList();
    _data['archived_appointments'] =
        archivedAppointments.map((e) => e.toJson()).toList();
    return _data;
  }
}

class UpcomingAppointments {
  UpcomingAppointments({
    required this.id,
    required this.date,
    required this.time,
    required this.details,
    required this.agent,
    required this.status,
  });
  late final int id;
  late final String date;
  late final String time;
  late final String details;
  late final Agent agent;
  late final String status;

  UpcomingAppointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    details = json['details'];
    agent = Agent.fromJson(json['agent']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['date'] = date;
    _data['time'] = time;
    _data['details'] = details;
    _data['agent'] = agent.toJson();
    _data['status'] = status;
    return _data;
  }
}

class Agent {
  Agent({
    required this.id,
    required this.name,
    required this.photo,
    required this.occupation,
    required this.rating,
    required this.address,
    required this.phoneNumber,
  });
  late final int id;
  late final String name;
  late final String photo;
  late final Occupation occupation;
  late final String rating;
  late final String address;
  late final String phoneNumber;

  Agent.fromJson(Map<String, dynamic> json) {
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
  });
  late final int id;
  late final String title;
  late final String icon;

  Occupation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['icon'] = icon;
    return _data;
  }
}

class ArchivedAppointments {
  ArchivedAppointments({
    required this.id,
    required this.date,
    required this.time,
    required this.details,
    required this.agent,
    required this.status,
  });
  late final int id;
  late final String date;
  late final String time;
  late final String details;
  late final Agent agent;
  late final String status;

  ArchivedAppointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    details = json['details'];
    agent = Agent.fromJson(json['agent']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['date'] = date;
    _data['time'] = time;
    _data['details'] = details;
    _data['agent'] = agent.toJson();
    _data['status'] = status;
    return _data;
  }
}
