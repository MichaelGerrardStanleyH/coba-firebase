class Ram{

  String name, id;
  int price;

  Ram({required this.name, required this.price, required this.id});

  factory Ram.fromJson(Map<String, dynamic> json) {
    return Ram(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}
