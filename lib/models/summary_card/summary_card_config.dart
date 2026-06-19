import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';
import 'package:get/get.dart';

class SummaryCardConfig {
  const SummaryCardConfig({
    required this.collectedCount,
    required this.totalCount,
    required this.countLabel,
    required this.totalRepaymentUsd,
    required this.collectedUsd,
    this.exchangeRate = 1,
    this.coTotal,
    this.onCountTap,
  });

  final int collectedCount;
  final int totalCount;
  final String countLabel;
  final double totalRepaymentUsd;
  final double collectedUsd;
  final double exchangeRate;
  final int? coTotal;
  final VoidCallback? onCountTap;

  factory SummaryCardConfig.forCO({
    required int collectedClients,
    required int totalClients,
    required double totalRepaymentUsd,
    required double collectedUsd,
    double exchangeRate = 1,
    VoidCallback? onTap,
  }) => SummaryCardConfig(
    collectedCount: collectedClients,
    totalCount: totalClients,
    countLabel: LocaleKeys.clients.tr,
    totalRepaymentUsd: totalRepaymentUsd,
    collectedUsd: collectedUsd,
    exchangeRate: exchangeRate,
    onCountTap: onTap,
  );

  factory SummaryCardConfig.forBM({
    required int collectedCOs,
    required int totalCOs,
    required double totalRepaymentUsd,
    required double collectedUsd,
    double exchangeRate = 1,
    VoidCallback? onTap,
  }) => SummaryCardConfig(
    collectedCount: collectedCOs,
    totalCount: totalCOs,
    countLabel: LocaleKeys.creditofficers.tr,
    totalRepaymentUsd: totalRepaymentUsd,
    collectedUsd: collectedUsd,
    exchangeRate: exchangeRate,
    onCountTap: onTap,
  );

  factory SummaryCardConfig.forCEO({
    required int collectedBMs,
    required int totalBMs,
    required double totalRepaymentUsd,
    required double collectedUsd,
    double exchangeRate = 1,
  }) => SummaryCardConfig(
    collectedCount: collectedBMs,
    totalCount: totalBMs,
    countLabel: LocaleKeys.branchmanagers.tr,
    totalRepaymentUsd: totalRepaymentUsd,
    collectedUsd: collectedUsd,
    exchangeRate: exchangeRate,
  );
}
