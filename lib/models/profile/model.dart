class ProfileModel {
  final num id;
  final String name;
  final String email;
  final String profile;
  final String phone;
  final String gender;
  final String status;
  final num branch_id;
  final String created_at;
  final String updated_at;
  final String profilePath;
  final String policy;
  final String type;
  final String full_name;
  ProfileModel({
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      profile: json['profile'] ?? 'N/A',
      phone: json['phone'] ?? 'N/A',
      gender: json['gender'] ?? 'N/A',
      status: json['status'] ?? 'null',
      branch_id: json['branch_id'] ?? 0,
      created_at: json['created_at'] ?? 'N/A',
      updated_at: json['updated_at'] ?? 'N/A',
      profilePath: json['profile_path'] ?? 'N/A',
      policy: json['policy'] ?? 'N/A',
      type: json['type'] ?? 'N/A',
      full_name: json['full_name'] ?? 'N/A',
    );
  }
  Map<String,dynamic> toJson(){
      final Map<String,dynamic> data = new Map<String,dynamic>();
      data['id'] = this.id;
      data['name'] = this.name;
      data['email'] = this.email;
      data['profile_path'] = this.profile;
      data['phone'] = this.phone;
      data['gender'] = this.gender;
      data['profile_path'] = this.profilePath;
      data["status"] = this.status;
      data['branch_id'] = this.branch_id;
      data['created_at'] = this.created_at;
      data['updated_at'] = this.updated_at;
      data['policy'] = this.policy;
      data['type'] = this.type;
      data['full_name'] = this.full_name;
      return data;
    }
  }
