class Vga{
  String id, name;
  int price;

  Vga({required this.id, required this.name, required this.price});

  factory Vga.fromJson(Map<String, dynamic> json) {
    return Vga(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}