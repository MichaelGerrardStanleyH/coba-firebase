class Motherboard{
  String id, name, vendor;
  int price;

  Motherboard({required this.id, required this.name, required this.vendor, required this.price});

  factory Motherboard.fromJson(Map<String, dynamic> json) {
    return Motherboard(
      id: json['id'],
      name: json['name'],
      vendor: json["vendor"],
      price: json['price'],
    );
  }
}