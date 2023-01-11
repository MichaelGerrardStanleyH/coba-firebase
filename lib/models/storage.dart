class Storage{
  String id, name;
  int price;

  Storage({required this.id, required this.name, required this.price});

  factory Storage.fromJson(Map<String, dynamic> json) {
    return Storage(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}