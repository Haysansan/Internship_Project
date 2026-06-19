class IdNameModel {
  final int id;
  final String name;

  IdNameModel({required this.id, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is IdNameModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
