class RepaymentDetailModel {
  String? client;
  String? mobile;
  String? loan_officer;
  String? photo;
  String? branch_id;
  String? branch;
  String? client_id;
  String? loan_id;
  String? total_repayment;
  String? pricipal;
  String? interest;
  String? monthly_fee;
  String? prepaymentAmt;
  String? total_overdue;
  String? last_payment_date;

  RepaymentDetailModel({
    this.client,
    this.mobile,
    this.loan_officer,
    this.photo,
    this.branch_id,
    this.branch,
    this.client_id,
    this.loan_id,
    this.total_repayment,
    this.pricipal,
    this.interest,
    this.monthly_fee,
    this.prepaymentAmt,
    this.total_overdue,
    this.last_payment_date
  });
  RepaymentDetailModel.fromJson(Map<String,dynamic> json){
    client = json["client"];
    mobile = json["mobile"];
    loan_officer = json["loan_officer"];
    photo = json["photo"];
    branch_id = json["branch_id"];
    branch = json["branch"];
    client_id = json["client_id"];
    loan_id = json["loan_id"];
    total_repayment = json["total_repayment"];
    pricipal = json["pricipal"];
    interest = json["interest"];
    monthly_fee = json["monthly_fee"];
    prepaymentAmt = json["prepaymentAmt"];
    total_overdue = json["total_overdue"];
    last_payment_date = json["last_payment_date"];

  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['client'] = this.client;
    data['mobile'] = this.mobile;
    data['loan_officer'] = this.loan_officer;
    data['photo'] = this.photo;
    data['branch_id'] = this.branch_id;
    data['branch'] = this.branch;
    data['client_id'] = this.client_id;
    data['loan_id'] = this.loan_id;
    data['total_repayment'] = this.total_repayment;
    data['pricipal'] = this.pricipal;
    data['interest'] = this.interest;
    data['monthly_fee'] = this.monthly_fee;
    data['prepaymentAmt'] = this.prepaymentAmt;
    data['total_overdue'] = this.total_overdue;
    data['last_payment_date'] = this.last_payment_date;
    return data;
  }
}