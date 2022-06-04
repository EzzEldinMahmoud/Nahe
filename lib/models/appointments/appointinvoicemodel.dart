class Appointmentinvoicemodel  {
  Appointmentinvoicemodel ({
    required this.data,
  });
  late final Data data;
  
  Appointmentinvoicemodel .fromJson(Map<String, dynamic> json){
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
    required this.invoice,
  });
  late final Invoice invoice;
  
  Data.fromJson(Map<String, dynamic> json){
    invoice = Invoice.fromJson(json['invoice']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['invoice'] = invoice.toJson();
    return _data;
  }
}

class Invoice {
  Invoice({
    required this.pdf,
    required this.totalPrice,
    required this.items,
  });
  late final String pdf;
  late final double totalPrice;
  late final List<Items> items;
  
  Invoice.fromJson(Map<String, dynamic> json){
    pdf = json['pdf'];
    totalPrice = json['total_price'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pdf'] = pdf;
    _data['total_price'] = totalPrice;
    _data['items'] = items.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.notes,
  });
  late final int id;
  late final String title;
  late final String price;
  late final int quantity;
  late final String notes;
  
  Items.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['price'] = price;
    _data['quantity'] = quantity;
    _data['notes'] = notes;
    return _data;
  }
}