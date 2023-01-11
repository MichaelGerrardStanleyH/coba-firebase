class Pc{
  String id, name, processor, ram, motherboard, vga, storage, psu;
  int totalPrice;

  Pc({
    required this.id,
    required this.name,
    required this.processor,
    required this.ram,
    required this.motherboard,
    required this.totalPrice,
    required this.vga,
    required this.storage,
    required this.psu
  });
  

  factory Pc.fromJson(Map<String, dynamic> json) {
    return Pc(
      id: json['id'],
      name: json['name'],
      processor: json['processor'],
      ram: json['ram'],
      motherboard: json['motherboard'],
      vga: json['vga'],
      storage: json['storage'],
      psu: json['psu'],
      totalPrice: json["totalPrice"]
    );
  }
}