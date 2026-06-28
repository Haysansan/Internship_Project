import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';

class ApproveLoansController extends GetxController {
  // ─── Role ───
  final Rx<UserType?> userRole = Rx<UserType?>(null);

  bool get isBM => userRole.value == UserType.bm;
  bool get isCEO => userRole.value == UserType.eco;

  final RxInt selectedTab = 1.obs;
  final RxBool isLoading = false.obs;

  // ─── Live lists ───
  final RxList<LoanApprovalModel> allLoans = <LoanApprovalModel>[].obs;
  final RxList<LoanApprovalModel> verifyLoans = <LoanApprovalModel>[].obs;
  final RxList<LoanApprovalModel> disbursementLoans = <LoanApprovalModel>[].obs;
  final RxList<LoanApprovalModel> acceptLoans = <LoanApprovalModel>[].obs;

  List<LoanApprovalModel> _allSnapshot = [];
  List<LoanApprovalModel> _verifySnapshot = [];
  List<LoanApprovalModel> _disbursementSnapshot = [];
  List<LoanApprovalModel> _acceptSnapshot = [];

  // ─── Filter by CO (replaces free-text search) ───
  final RxList<String> coNames = <String>[].obs;
  final RxnString selectedOfficer = RxnString();

  final Map<int, TextEditingController> _commentControllers = {};
  TextEditingController getCommentController(int loanId) =>
      _commentControllers.putIfAbsent(loanId, () => TextEditingController());
  List<LoanApprovalModel> get currentList {
    switch (selectedTab.value) {
      case 1:
        return isCEO ? acceptLoans : verifyLoans;
      case 2:
        return disbursementLoans;
      default:
        return allLoans;
    }
  }

  int get allCount => allLoans.length;
  int get verifyCount => verifyLoans.length;
  int get disbursementCount => disbursementLoans.length;
  int get acceptCount => acceptLoans.length;

  // ─── Helpers ───
  Future<String?> _getUserName() async {
    final value = await SharedPreferencesManager.get('name');
    return value as String?;
  }

  Future<int?> _getBranchId() =>
      SharedPreferencesManager.getIntValue('branch_id');
  Future<int?> _getUserId() => SharedPreferencesManager.getIntValue('user_id');
  String _status(LoanApprovalModel l) => l.status.toLowerCase();

  Future<UserType?> _resolveRole() async {
    if (UserRepository.shared.isBM) return UserType.bm;
    if (UserRepository.shared.isEco) return UserType.eco;
    final raw = await SharedPreferencesManager.get(Credential.permission.name);
    if (raw is! String) return null;
    final normalized = raw.toLowerCase();
    if (normalized == 'eco' || normalized == 'ceo') return UserType.eco;
    try {
      return UserType.values.firstWhere((e) => e.name == normalized);
    } catch (_) {
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _bootstrap();
  }

  @override
  void onClose() {
    for (final c in _commentControllers.values) c.dispose();
    super.onClose();
  }

  // Role must resolve before lists load — one entry point to avoid race conditions
  Future<void> _bootstrap() async {
    try {
      isLoading.value = true;
      userRole.value = await _resolveRole();
      await _loadAllLists();
    } catch (e) {
      if (isClosed) return;
      ExceptionHandler.handleException(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchLoans() async {
    try {
      isLoading.value = true;
      selectedOfficer.value = null;
      await _loadAllLists();
    } catch (e) {
      if (isClosed) return;
      ExceptionHandler.handleException(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Status flow:
  //   submitted - BM Verify tab
  //   pending   - BM View All ("verified, waiting CEO") + CEO Approve tab
  //   approved  - CEO View All ("waiting disburse")    + BM Disburse tab
  //   rejected  - BM View All + CEO View All (whoever is relevant)
  //   disbursed - BM View All + CEO View All
  Future<void> _loadAllLists() async {
    final branchId = await _getBranchId();
    final userId = await _getUserId();

    final res = await Get.find<ApiService>().get(
      EndPoints.getApproveDisburse,
      queryParameters: {'branch_id': branchId, 'user_id': userId},
      isShowLoading: false,
    );

    final raw = getPropertyFromJson(res.data, 'data');
    if (raw == null || raw is! List) return;

    final all =
        raw
            .map((e) => LoanApprovalModel.fromJson(e as Map<String, dynamic>))
            .toList();

    if (isBM) {
      verifyLoans.value = all.where((l) => _status(l) == 'submitted').toList();

      disbursementLoans.value =
          all.where((l) => _status(l) == 'approved').toList();

      final actionStatuses = {'submitted', 'approved'};
      allLoans.value =
          all.where((l) => !actionStatuses.contains(_status(l))).toList();

      _verifySnapshot = List.of(verifyLoans);
      _disbursementSnapshot = List.of(disbursementLoans);
      _allSnapshot = List.of(allLoans);

      // Land on whichever actionable tab actually has items, instead of
      // always defaulting to Verify (which may be empty while Disburse
      // has the pending items the dashboard badge counted).
      if (verifyLoans.isEmpty && disbursementLoans.isNotEmpty) {
        selectedTab.value = 2;
      } else if (verifyLoans.isNotEmpty) {
        selectedTab.value = 1;
      }
    } else if (isCEO) {
      acceptLoans.value = all.where((l) => _status(l) == 'pending').toList();

      final actionStatuses = {'pending'};
      allLoans.value =
          all.where((l) => !actionStatuses.contains(_status(l))).toList();

      _acceptSnapshot = List.of(acceptLoans);
      _allSnapshot = List.of(allLoans);
    }

    coNames.value =
        all
            .map((l) => l.creditOfficer)
            .where((name) => name.isNotEmpty && name != 'N/A')
            .toSet()
            .toList()
          ..sort();
    selectedOfficer.value = null;
  }

  void filterByOfficer(String? name) {
    selectedOfficer.value = name;

    bool match(LoanApprovalModel l) => name == null || l.creditOfficer == name;

    allLoans.value = _allSnapshot.where(match).toList();

    if (isBM) {
      verifyLoans.value = _verifySnapshot.where(match).toList();
      disbursementLoans.value = _disbursementSnapshot.where(match).toList();
    } else {
      acceptLoans.value = _acceptSnapshot.where(match).toList();
    }
  }

  // BM: verify - pending (CEO sees it in Approve tab)
  Future<void> verifyLoan(LoanApprovalModel loan, String comment) async {
    _confirm(
      title: 'Confirm Verification',
      body:
          'Verify loan for ${loan.client}? It will be sent to CEO for approval.',
      btnText: 'VERIFY',
      onConfirm:
          () => _postAction(
            endpoint: EndPoints.verifyLoan,
            loan: loan,
            status: 'pending',
            comment: comment,
            successMsg: 'Loan verified and sent to CEO.',
          ),
    );
  }

  // BM: reject from Verify tab - stays on BM side, never reaches CEO
  // Future<void> rejectVerifyLoan(LoanApprovalModel loan) async {
  //   _confirm(
  //     title: 'Confirm Rejection',
  //     body: 'Reject loan for ${loan.client}?',
  //     btnText: 'REJECT',
  //     onConfirm:
  //         () => _postAction(
  //           endpoint: EndPoints.verifyLoan,
  //           loan: loan,
  //           status: 'rejected',
  //           successMsg: 'Loan rejected.',
  //         ),
  //   );
  // }
  Future<void> rejectVerifyLoan(LoanApprovalModel loan, String comment) async {
    _confirm(
      title: 'Confirm Rejection',
      body: 'Reject loan for ${loan.client}?',
      btnText: 'REJECT',
      onConfirm: () => _postReject(loan, comment),
    );
  }

  // CEO: approve - BM sees it in Disburse tab
  Future<void> approveLoan(LoanApprovalModel loan, String comment) async {
    _confirm(
      title: 'Confirm Approval',
      body: 'Approve loan for ${loan.client}? BM will be able to disburse it.',
      btnText: 'APPROVE',
      onConfirm:
          () => _postAction(
            endpoint: EndPoints.approveLoan,
            loan: loan,
            status: 'approved',
            comment: comment,
            successMsg: 'Loan approved and sent to BM for disbursement.',
          ),
    );
  }

  // CEO: reject - stays on CEO side
  // Future<void> rejectLoan(LoanApprovalModel loan) async {
  //   _confirm(
  //     title: 'Confirm Rejection',
  //     body: 'Reject loan for ${loan.client}?',
  //     btnText: 'REJECT',
  //     onConfirm:
  //         () => _postAction(
  //           endpoint: EndPoints.approveLoan,
  //           loan: loan,
  //           status: 'rejected',
  //           successMsg: 'Loan rejected.',
  //         ),
  //   );
  // }
  Future<void> rejectLoan(LoanApprovalModel loan, String comment) async {
    _confirm(
      title: 'Confirm Rejection',
      body: 'Reject loan for ${loan.client}?',
      btnText: 'REJECT',
      onConfirm: () => _postReject(loan, comment),
    );
  }

  // BM: disburse - done
  Future<void> disburseLoan(LoanApprovalModel loan, String comment) async {
    _confirm(
      title: 'Confirm Disbursement',
      body: 'Disburse loan for ${loan.client}?',
      btnText: 'DISBURSE',
      onConfirm:
          () => _postAction(
            endpoint: EndPoints.disburseLoan,
            loan: loan,
            status: 'disbursed',
            comment: comment,
            successMsg: 'Loan disbursed successfully.',
          ),
    );
  }

  // BM: reject from Disburse tab
  // Future<void> rejectDisbursement(LoanApprovalModel loan) async {
  //   _confirm(
  //     title: 'Confirm Rejection',
  //     body: 'Reject disbursement for ${loan.client}?',
  //     btnText: 'REJECT',
  //     onConfirm:
  //         () => _postAction(
  //           endpoint: EndPoints.disburseLoan,
  //           loan: loan,
  //           status: 'rejected',
  //           successMsg: 'Disbursement rejected.',
  //         ),
  //   );
  // }
  Future<void> rejectDisbursement(
    LoanApprovalModel loan,
    String comment,
  ) async {
    _confirm(
      title: 'Confirm Rejection',
      body: 'Reject disbursement for ${loan.client}?',
      btnText: 'REJECT',
      onConfirm: () => _postReject(loan, comment),
    );
  }

  // Future<void> _postReject(LoanApprovalModel loan) async {
  //   try {
  //     final comment = _commentControllers[loan.id]?.text.trim() ?? '';
  //     final endpoint = EndPoints.rejectLoan(loan.loanId);
  //     final userId = await _getUserId();
  //     final userName = await _getUserName();

  //     if (comment.isEmpty) {
  //       DialogManager.showDialog(
  //         title: 'Required',
  //         subTitle: 'Please comment a rejection reason before rejecting.',
  //         onPressed: () {},
  //       );
  //       return;
  //     }

  //     await Get.find<ApiService>().post(endpoint, {
  //       'rejected_notes': comment,
  //       'created_by_id': userId,
  //       'user': userName,
  //       'loan_id': loan.loanId,
  //       'client_id': loan.clientId,
  //     }, isShowLoading: true);

  //     _moveToViewAll(loan: loan, newStatus: 'rejected');
  //     _refreshDashboardBadge();

  //     DialogManager.showDialog(
  //       title: LocaleKeys.successfully.tr,
  //       subTitle: 'Loan rejected.',
  //       onPressed: () {},
  //     );
  //   } catch (e) {
  //     if (isClosed) return;
  //     ExceptionHandler.handleException(e);
  //   }
  // }

  void _confirm({
    required String title,
    required String body,
    required String btnText,
    required VoidCallback onConfirm,
  }) {
    DialogManager.showCustom(
      PrimaryDialog(
        title: title,
        subTitle: body,
        btnText: btnText,
        onPressed: () {
          Get.back();
          onConfirm();
        },
      ),
    );
  }

  // Future<void> _postAction({
  //   required String endpoint,
  //   required LoanApprovalModel loan,
  //   required String status,
  //   required String successMsg,
  // }) async {
  //   try {
  //     final comment = _commentControllers[loan.id]?.text.trim() ?? '';
  //     final userId = await _getUserId();
  //     final userName = await _getUserName();
  //     final today = DateTime.now().toIso8601String().split('T')[0];

  //     final body = <String, dynamic>{
  //       'loan_id': loan.loanId,
  //       'client_id': loan.clientId,
  //       'user_id': userId,
  //       'verify_by_user_id': userId,
  //       'created_by_id': userId,
  //       'user': userName,
  //       'verify_on_date': today,
  //       'approved_on_date': today,
  //       'disbursed_on_date': today,
  //       'comment': comment,
  //       'status': status,
  //     };

  //     if (status == 'rejected') {
  //       body['rejected_notes'] = comment;
  //     }

  //     await Get.find<ApiService>().post(endpoint, body, isShowLoading: true);

  //     _moveToViewAll(loan: loan, newStatus: status);
  //     _refreshDashboardBadge();

  //     DialogManager.showDialog(
  //       title: LocaleKeys.successfully.tr,
  //       subTitle: successMsg,
  //       onPressed: () {},
  //     );
  //   } catch (e) {
  //     if (isClosed) return;
  //     ExceptionHandler.handleException(e);
  //   }
  // }
  Future<void> _postReject(LoanApprovalModel loan, String comment) async {
    try {
      if (comment.isEmpty) {
        DialogManager.showDialog(
          title: 'Required',
          subTitle: 'Please add a rejection reason before rejecting.',
          onPressed: () {},
        );
        return;
      }
      final endpoint = EndPoints.rejectLoan(loan.loanId);
      final userId = await _getUserId();
      final userName = await _getUserName();

      await Get.find<ApiService>().post(endpoint, {
        'rejected_notes': comment,
        'created_by_id': userId,
        'user': userName,
        'user_id': userId,
        'loan_id': loan.loanId,
        'client_id': loan.clientId,
      }, isShowLoading: true);

      _moveToViewAll(loan: loan, newStatus: 'rejected');
      _refreshDashboardBadge();

      DialogManager.showDialog(
        title: LocaleKeys.successfully.tr,
        subTitle: 'Loan rejected.',
        onPressed: () {},
      );
    } catch (e) {
      if (isClosed) return;
      ExceptionHandler.handleException(e);
    }
  }

  Future<void> _postAction({
    required String endpoint,
    required LoanApprovalModel loan,
    required String status,
    required String comment,
    required String successMsg,
  }) async {
    try {
      final userId = await _getUserId();
      final userName = await _getUserName();
      final today = DateTime.now().toIso8601String().split('T')[0];

      await Get.find<ApiService>().post(endpoint, {
        'loan_id': loan.loanId,
        'client_id': loan.clientId,
        'user_id': userId,
        'verify_by_user_id': userId,
        'created_by_id': userId,
        'user': userName,
        'verify_on_date': today,
        'approved_on_date': today,
        'disbursed_on_date': today,
        'comment': comment,
        'status': status,
      }, isShowLoading: true);

      _moveToViewAll(loan: loan, newStatus: status);
      _refreshDashboardBadge();

      DialogManager.showDialog(
        title: LocaleKeys.successfully.tr,
        subTitle: successMsg,
        onPressed: () {},
      );
    } catch (e) {
      if (isClosed) return;
      ExceptionHandler.handleException(e);
    }
  }

  void _moveToViewAll({
    required LoanApprovalModel loan,
    required String newStatus,
  }) {
    verifyLoans.removeWhere((l) => l.loanId == loan.loanId);
    disbursementLoans.removeWhere((l) => l.loanId == loan.loanId);
    acceptLoans.removeWhere((l) => l.loanId == loan.loanId);
    allLoans.removeWhere((l) => l.loanId == loan.loanId);

    _verifySnapshot.removeWhere((l) => l.loanId == loan.loanId);
    _disbursementSnapshot.removeWhere((l) => l.loanId == loan.loanId);
    _acceptSnapshot.removeWhere((l) => l.loanId == loan.loanId);
    _allSnapshot.removeWhere((l) => l.loanId == loan.loanId);

    final updated = loan.copyWith(status: newStatus);
    allLoans.insert(0, updated);
    _allSnapshot.insert(0, updated);
  }

  void _refreshDashboardBadge() {
    try {
      final dashCtl = Get.find<DashboardController>();
      dashCtl.pendingApprovalCount.value = isBM ? verifyCount : acceptCount;
    } catch (_) {}
  }
}
