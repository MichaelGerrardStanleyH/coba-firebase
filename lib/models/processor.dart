class Processor{
  String id, name, vendor;
  int price;

  Processor({required this.id, required this.name, required this.vendor, required this.price});

  factory Processor.fromJson(Map<String, dynamic> json) {
    return Processor(
      id: json['id'],
      name: json['name'],
      vendor: json["vendor"],
      price: json['price'],
    );
  }
}