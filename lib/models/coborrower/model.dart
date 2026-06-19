class CoBorrowerIdTypeModel {
  final String id;
  final String name;

  CoBorrowerIdTypeModel({required this.id, required this.name});

  factory CoBorrowerIdTypeModel.fromJson(Map<String, dynamic> json) {
    return CoBorrowerIdTypeModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'N/A',
    );
  }

  @override
  bool operator ==(Object other) =>
      other is CoBorrowerIdTypeModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class CoBorrowerModel {
  final String fullname;
  final String? dateOfBirth;
  final String? gender;
  final String phoneNumber;
  final String idTypeId;
  final String nationalId;

  CoBorrowerModel({
    required this.fullname,
    this.dateOfBirth,
    this.gender,
    required this.phoneNumber,
    required this.idTypeId,
    required this.nationalId,
  });

  Map<String, dynamic> toJson() => {
    'co_first_name': fullname,
    'co_dob': dateOfBirth,
    'co_gender': gender,
    'co_mobile': phoneNumber,
    'co_client_identification_type_id': idTypeId,
    'co_external_id': nationalId,
  };
}
