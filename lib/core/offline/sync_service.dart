
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/services/api_service.dart';
import 'package:apploan/core/services/end_points.dart';
import 'package:apploan/core/services/response.dart';
import 'database_helper.dart';

Future<void> syncDataRepayment() async {



    final clientList = await Get.find<ApiService>().get(
      EndPoints.repayment,
      isShowLoading: false,
    );
    final data = getPropertyFromJson(clientList.data, 'data');
    for (var item in data) {
      await DatabaseHelper.instance.insertRepayment({
        'id': item.id,
        'client': item.client,
        'loan_officer': item.loan_officer,
        'branch': item.branch,
        'client_id': item.client_id,
        'loan_id': item.loan_id,
        'mobile': item.mobile,
        'client_code': item.client_code,
        'account_number': item.account_number,
        'cycle': item.cycle,
        'loan_term': item.loan_term,
        'photo': item.photo,
        'principal': item.principal,
        'end_pricipal' : item.end_pricipal,
        'interest' : item.interest,
        'monthly_fee' : item.monthly_fee,
        'villages_name': item.villages_name,
        'last_payment_date': item.last_payment_date,
        'total_repayment': item.total_repayment,
        'arrea': item.arrea,
        'total_toclose': item.total_toclose,
        'syncedate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'synced': 1
      });
    }
  
}
