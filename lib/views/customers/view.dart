import 'package:apploan/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;

// class CustomersView extends GetView<CustomersController> {
//   const CustomersView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: LocaleKeys.customers.tr,
//         onBack: () => Navigator.pop(context, false),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(
//             child: CircularProgressIndicator(color: AppColor.red),
//           );
//         }

//         if (controller.customerModel.isEmpty) {
//           return const NoDataWidget();
//         }

//         final List<ClientModel> delivery = controller.customerModel;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: UIConstants.spacing.padHorizontal,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   UIConstants.spacing.height,

//                   // Clear
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         LocaleKeys.searchByCIDName.tr,
//                         style: AppTextStyle.midPrimaryBold,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           if (controller.searchCtl.text.isEmpty) {
//                             return;
//                           }
//                           controller.clearFitler();
//                           controller.fetchClientSearch(
//                             isRefresh: true,
//                             isFilter: true,
//                           );
//                         },
//                         child: Text(
//                           LocaleKeys.clear.tr,
//                           style: AppTextStyle.midPrimaryBold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   UIConstants.spacing.height,

//                   // Search
//                   CustomTextField(
//                     controller: controller.searchCtl,
//                     filled: true,
//                     hintText: LocaleKeys.searchByCIDName.tr,
//                     onFieldSubmitted: (value) {
//                       if (value.isEmpty) {
//                         return;
//                       }
//                       controller.setSearchValue();
//                       controller.fetchClientSearch(
//                         isRefresh: true,
//                         isFilter: true,
//                       );
//                     },
//                   ),
//                   UIConstants.spacing.height,
//                 ],
//               ),
//             ),

//             // Title
//             // Padding(
//             //   padding: UIConstants.spacing.padHorizontal,
//             //   child: Text(
//             //     '${LocaleKeys.totalOS.tr} ${controller.total}  ${LocaleKeys.totalClient.tr}',
//             //     style: AppTextStyle.midPrimaryBold,
//             //   ),
//             // ),
//             UIConstants.midSpacing.height,

//             // Listing
//             Expanded(
//               child: RefreshIndicator(
//                 backgroundColor: AppColor.white,
//                 color: AppColor.primary,
//                 onRefresh: () async => await controller.onRefresh(),
//                 child: pull.SmartRefresher(
//                   header: pull.CustomHeader(
//                     height: 0,
//                     builder: (context, mode) => const SizedBox.shrink(),
//                   ),
//                   enablePullUp: !controller.pagination.isEndOfPage,
//                   controller: controller.refreshCtl,
//                   onLoading: () async => await controller.onLoading(),
//                   child: ListView.builder(
//                     padding: EdgeInsets.only(
//                       left: UIConstants.spacing.toDouble(),
//                       right: UIConstants.spacing.toDouble(),
//                       top: UIConstants.midSpacing.toDouble(),
//                     ),
//                     itemCount: delivery.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: UIConstants.spacing.padBottom,
//                         child: CustomersItemWidget(delivery: delivery[index]),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//       // floatingActionButton: FloatingActionButton(
//       //   backgroundColor: const Color(0xFFFFDDE3),
//       //   onPressed: AddCustomerHandleTap,
//       //   tooltip: 'Perform Action',
//       //   child: const Icon(Icons.add, color: Colors.red),
//       // ),
//       floatingActionButton:
//           UserRepository.shared.isCO
//               ? FloatingActionButton(
//                 backgroundColor: const Color(0xFFFFDDE3),
//                 onPressed: AddCustomerHandleTap,
//                 tooltip: 'Perform Action',
//                 child: const Icon(Icons.add, color: Colors.red),
//               )
//               : null,
//     );
//   }

//   void AddCustomerHandleTap() {
//     Get.back();
//     Get.toNamed(Routes.addCustomer);
//   }
// }

class CustomersView extends GetView<CustomersController> {
  const CustomersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      bottomNavigationBar: AppBottomNav(items: controller.getItems()),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ClientsHeader(),
            Obx(
              () =>
                  controller.isSearchVisible.value
                      ? const _SearchSection()
                      : const SizedBox.shrink(),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColor.red),
                  );
                }

                if (controller.customerModel.isEmpty) {
                  return const NoDataWidget();
                }

                return RefreshIndicator(
                  backgroundColor: AppColor.white,
                  color: AppColor.primary,
                  onRefresh: controller.onRefresh,
                  child: pull.SmartRefresher(
                    header: pull.CustomHeader(
                      height: 0,
                      builder: (context, mode) => const SizedBox.shrink(),
                    ),
                    enablePullUp: !controller.pagination.isEndOfPage,
                    controller: controller.refreshCtl,
                    onLoading: controller.onLoading,
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        UIConstants.spacing.toDouble(),
                        0,
                        UIConstants.spacing.toDouble(),
                        UIConstants.spacing.toDouble(),
                      ),
                      itemCount: controller.customerModel.length,
                      separatorBuilder: (context, index) => 12.height,
                      itemBuilder: (context, index) {
                        return CustomersItemWidget(
                          client: controller.customerModel[index],
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClientsHeader extends StatelessWidget {
  const _ClientsHeader();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CustomersController>();
    return Padding(
      padding: EdgeInsets.fromLTRB(
        UIConstants.spacing.toDouble(),
        UIConstants.spacing.toDouble(),
        UIConstants.spacing.toDouble(),
        UIConstants.midSpacing.toDouble(),
      ),
      child: Row(
        children: [
          _HeaderIconButton(icon: Icons.arrow_back, onTap: Get.back),
          12.width,
          Expanded(
            child: Text(
              LocaleKeys.customers.tr,
              textAlign: TextAlign.center,
              style: AppTextStyle.mediumPrimarySemiBold,
            ),
          ),
          if (UserRepository.shared.isCO) ...[
            _HeaderIconButton(
              icon: Icons.add,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.addCustomer);
              },
            ),
            8.width,
          ],
          _HeaderIconButton(icon: Icons.search, onTap: c.toggleSearch),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: AppColor.primaryText, size: 22),
        ),
      ),
    );
  }
}

class _SearchSection extends StatelessWidget {
  const _SearchSection();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CustomersController>();
    return Padding(
      padding: EdgeInsets.fromLTRB(
        UIConstants.spacing.toDouble(),
        0,
        UIConstants.spacing.toDouble(),
        UIConstants.midSpacing.toDouble(),
      ),
      child: SearchField(
        controller: c.searchCtl,
        hintText: LocaleKeys.searchByCIDName.tr,
        onClear: c.clearSearch,
        onSubmitted: c.searchLocally,
      ),
    );
  }
}
