import 'package:apploan/core/core.dart';
import 'package:apploan/views/dino/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DinoView extends GetView<DinoController> {
  DinoView({super.key});
  final DinoController c = Get.put(DinoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(
        title: LocaleKeys.deno.tr,
        onBack: () => Navigator.pop(context, false),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              // _buildTableHeader(),
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   padding: EdgeInsets.all(0),
              //   itemCount: c.denominations.length,
              //   itemBuilder: (context, index) {
              //     int denom = c.denominations[index];
              //     return _buildDenomRow(denom);
              //   },
              // ),
              // _buildDenoTotalFooter(),
              _buildMainTable(),
              _buildDenoTotalFooter(),
              SizedBox(height: 5),
              _buildBalanceSection(),
              20.height,
              PrimaryButton(text: 'រក្សាទុក', onPressed: controller.submit),
              50.height,
            ],
          );
        }),
      ),
    );
  }

  Widget _buildMainTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.1, color: Colors.black),
      ),
      child: Table(
        // columnWidths defines the layout once for all rows
        columnWidths: const {
          0: FlexColumnWidth(2.5), // Denomination label
          1: FixedColumnWidth(50), // The "X"
          2: FixedColumnWidth(
            130,
          ), // The Input Box (Fixed width to stop jumping)
          3: FlexColumnWidth(3), // The Row Total
        },
        border: TableBorder.all(color: Colors.blue.shade100, width: 0.1),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // HEADER ROW
          TableRow(
            decoration: const BoxDecoration(color: AppColor.primary),
            children: [
              _tableCell("ប្រភេទលុយ", isHeader: true),
              _tableCell("គុណ", isHeader: true),
              _tableCell("ចំនួន", isHeader: true),
              _tableCell("សរុប", isHeader: true),
            ],
          ),
          // DATA ROWS
          ...c.denominations.map(
            (denom) => TableRow(
              children: [
                _tableCell(
                  NumberFormat('#,###').format(denom),
                  align: Alignment.centerLeft,
                ),
                const Center(child: Text("X")),
                _inputCell(denom),
                Obx(
                  () => _tableCell(
                    NumberFormat(
                      '#,###',
                    ).format(denom * (c.quantities[denom] ?? 0)),
                    align: Alignment.centerRight,
                  ),
                ),
              ],
            ),
          ),

          // // DENO TOTAL ROW
          // TableRow(
          //   decoration: const BoxDecoration(color: Color(0xFF2C9FAF)),
          //   children: [
          //     const SizedBox.shrink(),
          //     const SizedBox.shrink(),
          //     _tableCell(
          //       "ទឹកប្រាក់ក្នុង Deno",
          //       isHeader: true,
          //       align: Alignment.centerRight,
          //     ),
          //     Obx(
          //       () => Container(
          //         color: Colors.white,
          //         margin: const EdgeInsets.all(2),
          //         child: _tableCell(NumberFormat('#,###').format(c.denoTotal)),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  } // Specific helper for the Input Cell inside the Table

  Widget _inputCell(int denom) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: _inputField((val) => c.updateQty(denom, val)),
    );
  }

  Widget _tableCell(
    String text, {
    bool isHeader = false,
    Alignment align = Alignment.center,
  }) {
    return Container(
      alignment: align,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          color: isHeader ? AppColor.white : AppColor.black,
          fontSize: isHeader ? 13 : 14,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildDenomRow(int denom) {
    return Container(
      height: 48, // Fixed height prevents vertical jumping
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100, width: 0.5),
      ),
      child: Row(
        children: [
          // Column 1: Denomination (Flexible)
          _cell(
            NumberFormat('#,###').format(denom),
            flex: 1,
            align: Alignment.centerLeft,
          ),

          // Column 2: The "X" (Fixed width)
          SizedBox(width: 30, child: Text("X", textAlign: TextAlign.center)),

          // Column 3: The Input Box (Fixed width - THE FIX)
          Container(
            width: 90,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: _inputField((val) => c.updateQty(denom, val)),
          ),

          // Column 4: Row Total (Flexible - takes remaining space)
          Expanded(
            flex: 4,
            child: Obx(
              () => _cell(
                NumberFormat(
                  '#,###',
                ).format(denom * (c.quantities[denom] ?? 0)),
                align: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- UPDATED CELL HELPER ---
  Widget _cell(
    String text, {
    int flex = 1,
    Color color = Colors.black,
    Alignment align = Alignment.center,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: align,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: EdgeInsets.all(1),

        color: Colors.yellow.withValues(alpha: 0.1),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 13, // Standardize size instead of FittedBox
            fontWeight:
                color == Colors.white ? FontWeight.bold : FontWeight.normal,
          ),
          maxLines: 1,
          overflow:
              TextOverflow.ellipsis, // Better than FittedBox for simple tables
        ),
      ),
    );
  }

  Widget _buildDenoTotalFooter() {
    return Container(
      color: AppColor.primary,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          _summaryRow(
            "ទឹកប្រាក់ក្នុង Deno",
            Obx(
              () => Text(
                NumberFormat(
                  '#,###',
                ).format(double.tryParse(c.denoTotal.toString()) ?? 0),
              ),
            ),
          ),
          SizedBox(height: 4),
          // _summaryRow("Actual Amt", Container()),
        ],
      ),
    );
  }

  // --- Balance Section (Bottom Part) ---
  Widget _buildBalanceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          _balanceInputRow(
            "1- លុយបានទម្លាក់ទុន",
            (val) => c.receivedAmt.value = double.tryParse(val) ?? 0,
            controller: c.receivedAmtController,
            readOnly: true,
          ),
          _balanceInputRow(
            "2- សេវារដ្ឋបាល",
            (val) => c.adminFee.value = double.tryParse(val) ?? 0,
            controller: c.adminFeeController,
            readOnly: true,
          ),
          _balanceInputRow(
            "3- លុយប្រមូលសរុប",
            (val) => c.collectedTotal.value = double.tryParse(val) ?? 0,
            controller: c.collectedTotalController,
            readOnly: true,
          ),
          SizedBox(height: 10),
          _buildOverShortageBar(),
        ],
      ),
    );
  }

  Widget _buildOverShortageBar() {
    return Container(
      color: AppColor.primary,
      height: 40,
      child: Row(
        children: [
          _cell(
            "Over/Shortage",
            flex: 3,
            color: Colors.white,
            align: Alignment.centerLeft,
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.all(2),
              color: Color(0xFFE0F7FA),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Obx(
                () => Text(
                  c.overShortage.toStringAsFixed(0),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Update _inputField to accept the controller
  Widget _inputField(Function(String) onChanged) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 100, // This fixed width will now be respected on first load
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: TextField(
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 10,
            ),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, Widget value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 120,
          height: 30,
          color: Colors.white,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: value,
        ),
      ],
    );
  }

  Widget _balanceInputRow(
    String label,
    Function(String) onChanged, {
    TextEditingController? controller,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Label takes up the left side
          Expanded(
            flex: 4,
            child: Text(label, style: const TextStyle(fontSize: 13)),
          ),
          // Input takes up the same proportional space as the table's right side
          Expanded(
            flex: 6,
            child: SizedBox(
              height: 38,
              child: TextField(
                controller: controller,
                readOnly: readOnly,
                onChanged: onChanged,
                enableInteractiveSelection: false,
                textAlign:
                    TextAlign.right, // Match the table's right-aligned totals
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
