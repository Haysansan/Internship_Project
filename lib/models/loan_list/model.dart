class LoanListModel{

  int? id;
  String? client;
  String? principal;
  String? disbursed_on_date;
  String? client_code;
  String? mobile;
  String? photo;
  String? status;
  int? synced;

  LoanListModel({
    this.id,
    this.client,
    this.principal,
    this.disbursed_on_date,
    this.client_code,
    this.mobile,
    this.photo,
    this.status,
    this.synced,
  });

  LoanListModel.fromJson(Map<String,dynamic> json){
    id                 = json["id"];
    client             = json["client"];
    principal          = json["principal"];
    disbursed_on_date  = json["disbursed_on_date"];
    client_code        = json["client_code"];
    mobile             = json["mobile"];
    photo              = json["photo"];
    status             = json["status"];
    synced             = json["synced"];
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data["id"] = this.id;
    data["client"]  = this.client;
    data["principal"]     = this.principal;
    data["disbursed_on_date"] = this.disbursed_on_date;
    data["client_code"] = this.client_code;
    data["mobile"]   = this.mobile;
    data["photo"] = this.photo;
    data["status"] = this.status;
    data["synced"] = 1;
    return data;
  }
}