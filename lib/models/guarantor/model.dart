class GuarantorIdTypeModel {
  final String id;
  final String name;

  GuarantorIdTypeModel({required this.id, required this.name});

  factory GuarantorIdTypeModel.fromJson(Map<String, dynamic> json) =>
      GuarantorIdTypeModel(
        id: json['id'].toString(),
        name: json['name'] as String,
      );

  @override
  bool operator ==(Object other) =>
      other is GuarantorIdTypeModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class GuarantorRelationshipModel {
  final String id;
  final String name;

  GuarantorRelationshipModel({required this.id, required this.name});

  factory GuarantorRelationshipModel.fromJson(Map<String, dynamic> json) =>
      GuarantorRelationshipModel(
        id: json['id'].toString(),
        name: json['name'] as String,
      );

  @override
  bool operator ==(Object other) =>
      other is GuarantorRelationshipModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class GuarantorModel {
  final String fullname;
  final String? dateOfBirth;
  final String? gender;
  final String phoneNumber;
  final String idTypeId;
  final String nationalId;
  final String relationship;

  GuarantorModel({
    required this.fullname,
    this.dateOfBirth,
    this.gender,
    required this.phoneNumber,
    required this.idTypeId,
    required this.nationalId,
    required this.relationship,
  });

  Map<String, dynamic> toJson() => {
    'gu_first_name': fullname,
    'gu_dob': dateOfBirth,
    'gu_gender': gender,
    'gu_mobile': phoneNumber,
    'gu_client_identification_type_id': idTypeId,
    'gu_external_id': nationalId,
    'gu_client_relationship_id': relationship,
  };
}
