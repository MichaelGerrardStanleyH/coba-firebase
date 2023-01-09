class Pc{
  String id, name, processor, ram, motherboard;
  int totalPrice;

  Pc({required this.id, required this.name, required this.processor, required this.ram, required this.motherboard, required this.totalPrice});
  

  factory Pc.fromJson(Map<String, dynamic> json) {
    return Pc(
      id: json['id'],
      name: json['name'],
      processor: json['processor'],
      ram: json['ram'],
      motherboard: json['motherboard'],
      totalPrice: json["totalPrice"]
    );
  }
}