class PaidOffModel{
  final int id;
  final String client;
  final String loan_officer;
  final String branch;
  final String client_id;
  final String loan_id;
  final String mobile;
  final String client_code;
  final String account_number;
  final String cycle;
  final String loan_term;
  final String photo;
  final String principal;
  final String end_pricipal;
  final String interest;
  final String monthly_fee;
  final String disburmentAmt;
  final String penalty;
  final String villages_name;
  final String last_payment_date;
  final String total_repayment;
  final String arrea;
  final String total_toclose;
  final String syncedate;
  final int synced;

  PaidOffModel({
    required this.id,
    required this.client,
    required this.loan_officer,
    required this.branch,
    required this.client_id,
    required this.loan_id,
    required this.mobile,
    required this.client_code,
    required this.account_number,
    required this.cycle,
    required this.loan_term,
    required this.photo,
    required this.principal,
    required this.disburmentAmt,
    required this.end_pricipal,
    required this.interest,
    required this.monthly_fee,
    required this.penalty,
    required this.villages_name,
    required this.last_payment_date,
    required this.total_repayment,
    required this.arrea,
    required this.total_toclose,
    required this.syncedate,
    required this.synced,
  });
  factory PaidOffModel.fromJson(Map<String,dynamic> json){
    return PaidOffModel(
    id : json["id"] ?? 0,
    client : json["client"] ?? 'N/A',
    loan_officer : json["loan_officer"] ?? 'N/A',
    branch : json["branch"] ?? 'N/A',
    client_id : json["client_id"] ?? 'N/A',
    loan_id : json["loan_id"] ?? 'N/A',
    mobile : json["mobile"] ?? 'N/A',
    client_code : json["client_code"] ?? 'N/A',
    account_number : json["account_number"] ?? 'N/A',
    cycle : json["cycle"] ?? 'N/A',
    loan_term : json["loan_term"] ?? 'N/A',
    photo : json["photo"] ?? 'N/A',
    principal : json["principal"] ?? 'N/A',
    disburmentAmt : json["disburmentAmt"] ?? '0',
    end_pricipal : json["endpricipal"] ?? 'N/A',
    interest : json["interest"] ?? 'N/A',
    monthly_fee : json["monthly_fee"] ?? 'N/A',
      penalty: json["penalty"] ?? 'N/A',
    villages_name : json["villages_name"] ?? 'N/A',
    last_payment_date : json["last_payment_date"] ?? 'N/A',
    total_repayment : json["total_repayment"] ?? 'N/A',
    arrea : json["arrea"] ?? 'N/A',
    total_toclose : json["total_toclose"] ?? 'N/A',
    syncedate : json["syncedate"] ?? 'N/A',
    synced : json["synced"] ?? 0,
    );
  }
  // factory RepaymentModel.fromJson(Map<String, dynamic> json) {
  //   return RepaymentModel(
  //     invoice: json['invoice'] ?? 'N/A',
  //     title: json['title'] ?? 'N/A',
  //     dateTime: json['date_time'] ?? 'N/A',
  //     description: json['description'] ?? 'N/A',
  //     name: json['name'] ?? 'N/A',
  //     phone: json['phone'] ?? 'N/A',
  //   );
  // }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id']  = this.id;
    data['client'] = this.client;
    data['loan_officer'] = this.loan_officer;
    data['branch'] = this.branch;
    data['client_id'] = this.client_id;
    data['loan_id'] = this.loan_id;
    data['mobile'] = this.mobile;
    data['client_code'] = this.client_code;
    data['account_number'] = this.account_number;
    data['cycle'] = this.cycle;
    data['loan_term'] = this.loan_term;
    data['photo'] = this.photo;
    data['principal'] = this.principal;
    data['disburmentAmt'] = this.disburmentAmt;
    data['endpricipal'] = this.end_pricipal;
    data['interest'] = this.interest;
    data['monthly_fee'] = this.monthly_fee;
    data['penalty'] = this.penalty;
    data['villages_name'] = this.villages_name;
    data['last_payment_date'] = this.last_payment_date;
    data['total_repayment'] = this.total_repayment;
    data['arrea'] = this.arrea;
    data['total_toclose'] = this.total_toclose;
    data['syncedate'] = this.syncedate;
    data['synced'] = this.synced;
    return data;
  }
}