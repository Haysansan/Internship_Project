import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';

class TermConditionView extends StatelessWidget {
  const TermConditionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.termAndCondition.tr,
        onBack: () => Navigator.pop(context, false),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Image.network(UserRepository.shared.profile.policy),
      ),

      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       (UIConstants.spacing + 8).height,

      //       // Normal service fee
      //       const TermConditionsItemWidget(
      //         title: '1. តម្លៃសេវាកម្មធម្មតា',
      //         subTitle: ['- 5000 រៀល (ទាំងក្នុងក្រុង នឹងជាយក្រុង)'],
      //       ),
      //       (UIConstants.spacing + 8).height,

      //       // VIP service feee
      //       const TermConditionsItemWidget(
      //         title: '2. តម្លៃសេវាកម្មរហ័ស ឬVIP',
      //         subTitle: [
      //           '- (S grIME EMME)(8:00-4:00)',
      //           '- 8000 រៀល (ទាំងក្នុងក្រុង នឹងជាយក្រុង)',
      //         ],
      //       ),
      //       (UIConstants.spacing + 8).height,

      //       // Car service fee
      //       const TermConditionsItemWidget(
      //         title: '3. តម្លៃសេវាកម្មផ្ញើរឡាន',
      //         subTitle: [
      //           '- 4000 រៀល+សេវាឡាន',
      //           '- វីរះបុនថាំ',
      //           '- ការពីតូ',
      //           '- J&T',
      //           '- តាក់សី',
      //         ],
      //       ),
      //       (UIConstants.spacing + 8).height,

      //       // Noted
      //       Padding(
      //         padding: UIConstants.spacing.padHorizontal,
      //         child: const Text(
      //           '* បញ្ចាក់ : សម្រាប់ឥវ៉ានក្រោម 3គីឡូ ផ្ញៀវVIP (កក់1ដង=ចាប់ពី10កញ្ចប់ នឹង ទទួលបានតម្លៃVIP)',
      //           style: AppTextStyle.midRedBold,
      //         ),
      //       ),
      //       (UIConstants.spacing + 8).height,

      //       // Normal service fee
      //       const TermConditionsItemWidget(
      //         title: '1. តម្លៃសេវាកម្មធម្មតា',
      //         subTitle: [
      //           '- (ទទួលព្រឹក ដឹកថ្ងៃ)(8:00-11:00)',
      //           '- 4000 រៀល (ទាំងក្នុងក្រុង នឹងជាយក្រុង)',
      //         ],
      //       ),
      //       (UIConstants.spacing + 8).height,

      //       // VIP service fee
      //       const TermConditionsItemWidget(
      //         title: '2. តម្លៃសេវាកម្មរហ័ស ឬVIP',
      //         subTitle: [
      //           '- (ទទួលភ្លាម ដឹកភ្លាម)(8:00-4:00)',
      //           '- 8000 រៀល (ទាំងក្នុងក្រុង នឹងជាយក្រុង)',
      //         ],
      //       ),

      //       (UIConstants.spacing * 2).height,
      //     ],
      //   ),
      // ),
    );
  }
}
