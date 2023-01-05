class Ram{

  String name, id;
  int size;

  Ram({required this.name, required this.size, required this.id});

  factory Ram.fromJson(Map<String, dynamic> json) {
    return Ram(
      id: json['id'],
      name: json['name'],
      size: json['size'],
    );
  }
}
