class StaffModel {
  final int id;
  final String name;
  final String email;
  final String profile;
  final String phone;
  final String gender;
  final String status;
  final String branch_id;
  final String created_at;
  final String updated_at;
  final String profilePath;
  final String policy;
  final String type;
  final String full_name;
  StaffModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profile,
    required this.phone,
    required this.gender,
    required this.status,
    required this.branch_id,
    required this.created_at,
    required this.updated_at,
    required this.profilePath,
    required this.policy,
    required this.type,
    required this.full_name,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      id: json['id'],
      name: _toStr(json['name']),
      email: _toStr(json['email']),
      profile: _toStr(json['profile_path']),
      phone: _toStr(json['phone']),
      gender: _toStr(json['gender']),
      status: _toStr(json['status']),
      branch_id: _toStr(json['branch_id']),
      created_at: _toStr(json['created_at']),
      updated_at: _toStr(json['updated_at']),
      profilePath: _toStr(json['profile_path']),
      policy: _toStr(json['policy']),
      type: _toStr(json['type']),
      full_name: _toStr(json['full_name']),
    );
  }
}

String _toStr(dynamic value) => value?.toString() ?? 'N/A';
