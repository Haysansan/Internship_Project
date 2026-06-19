class LoginModel {
  final String token;
  final String name;
  final String permission;
  final int user_id;
  final int branch_id;


  LoginModel({
    required this.token,
    required this.name,
    required this.permission,
    required this.user_id,
    required this.branch_id,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'] ?? '',
      name: json['fullname'] ?? json['name'] ?? '',
      permission: json['permission'] ?? '',
      user_id: _toInt(json['user_id']),
      branch_id: _toInt(json['branch_id']),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['token'] = this.token;
    data['name'] = this.name;
    data['permission'] = this.permission;
    data['user_id'] = this.user_id;
    data['branch_id'] = this.branch_id;
    return data;
  }
}
