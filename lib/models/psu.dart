class Psu{
  String id, name;
  int price;

  Psu({required this.id, required this.name, required this.price});

  factory Psu.fromJson(Map<String, dynamic> json) {
    return Psu(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}