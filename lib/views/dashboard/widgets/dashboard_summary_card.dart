import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';

class DashboardSummaryCard extends StatelessWidget {
  const DashboardSummaryCard({
    Key? key,
    required this.stats,
    required this.userName,
    this.companyName = 'Soft Creative CO.,LTD',
  }) : assert(
         stats.length == 4,
         'DashboardSummaryCard requires exactly 4 StatItems',
       ),
       super(key: key);

  final List<StatItem> stats;
  final String userName;
  final String companyName;

  @override
  // with background block
  //   Widget build(BuildContext context) {
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 12),
  //       child: ClipRRect(
  //         borderRadius: BorderRadius.circular(20),
  //         child: BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: Colors.white.withOpacity(0.20),
  //               borderRadius: BorderRadius.circular(20),
  //               border: Border.all(
  //                 color: Colors.white.withOpacity(0.5),
  //                 width: 1.5,
  //               ),
  //             ),
  //             padding: const EdgeInsets.all(12),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 _CardHeader(
  //                   companyName: companyName,
  //                   userName: UserRepository.shared.userName,
  //                 ),
  //                 8.height,
  //                 Row(
  //                   children: [
  //                     Expanded(child: _StatBox(item: stats[0])),
  //                     16.width,
  //                     Expanded(child: _StatBox(item: stats[1])),
  //                   ],
  //                 ),
  //                 8.height,
  //                 Row(
  //                   children: [
  //                     Expanded(child: _StatBox(item: stats[2])),
  //                     16.width,
  //                     Expanded(child: _StatBox(item: stats[3])),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }
  // without background block
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(companyName: companyName, userName: userName),
          12.height,
          Row(
            children: [
              Expanded(child: _StatBox(item: stats[0])),
              16.width,
              Expanded(child: _StatBox(item: stats[1])),
            ],
          ),
          8.height,
          Row(
            children: [
              Expanded(child: _StatBox(item: stats[2])),
              16.width,
              Expanded(child: _StatBox(item: stats[3])),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.companyName, required this.userName});

  final String companyName;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.white.withOpacity(0.6), width: 2),
          ),
          child: ClipOval(
            child: Image.asset(AssetPath.appLogo.path, fit: BoxFit.cover),
          ),
        ),
        12.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                companyName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              4.height,
              Text(
                'Hi, $userName! Welcome to SC Loan.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.item});

  final StatItem item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              2.height,
              Text(
                item.sublabel,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 12,
                ),
              ),
              4.height,
              Text(
                item.amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
