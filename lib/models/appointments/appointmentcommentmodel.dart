class APPOINTMENTCOMMENTMODEL {
  APPOINTMENTCOMMENTMODEL({
    required this.data,
  });
  late final Data data;
  
  APPOINTMENTCOMMENTMODEL.fromJson(Map<String, dynamic> json){
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
    required this.review,
  });
  late final Review review;
  
  Data.fromJson(Map<String, dynamic> json){
    review = Review.fromJson(json['review']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['review'] = review.toJson();
    return _data;
  }
}

class Review {
  Review({
    required this.comment,
    required this.rating,
    required this.clientName,
  });
  late final String comment;
  late final String rating;
  late final String clientName;
  
  Review.fromJson(Map<String, dynamic> json){
    comment = json['comment'];
    rating = json['rating'];
    clientName = json['client_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['comment'] = comment;
    _data['rating'] = rating;
    _data['client_name'] = clientName;
    return _data;
  }
}