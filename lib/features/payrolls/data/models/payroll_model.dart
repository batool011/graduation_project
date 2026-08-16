class PayrollRecord {
  final int id;
  final int companyId;
  final int month;
  final int year;
  final double basicSalary;
  final int workingDays;
  final int presentDays;
  final int absenceDays;
  final int unpaidLeaveDays;
  final int lateMinutes;
  final int earlyLeaveMinutes;
  final PayrollRates rates;
  final List<PayrollDeduction> deductions;
  final double totalDeduction;
  final double netSalary;
  final List<PayrollDetail> details;
  final DateTime? calculatedAt;

  const PayrollRecord({
    required this.id,
    required this.companyId,
    required this.month,
    required this.year,
    required this.basicSalary,
    required this.workingDays,
    required this.presentDays,
    required this.absenceDays,
    required this.unpaidLeaveDays,
    required this.lateMinutes,
    required this.earlyLeaveMinutes,
    required this.rates,
    required this.deductions,
    required this.totalDeduction,
    required this.netSalary,
    required this.details,
    required this.calculatedAt,
  });

  factory PayrollRecord.fromJson(Map<String, dynamic> json) {
    return PayrollRecord(
      id: _intValue(json['id']),
      companyId: _intValue(json['company_id']),
      month: _intValue(json['month']),
      year: _intValue(json['year']),
      basicSalary: _doubleValue(json['basic_salary']),
      workingDays: _intValue(json['working_days']),
      presentDays: _intValue(json['present_days']),
      absenceDays: _intValue(json['absence_days']),
      unpaidLeaveDays: _intValue(json['unpaid_leave_days']),
      lateMinutes: _intValue(json['late_minutes']),
      earlyLeaveMinutes: _intValue(json['early_leave_minutes']),
      rates: PayrollRates.fromJson(
        (json['rates'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{},
      ),
      deductions:
          (json['deductions'] as List?)
              ?.whereType<Map>()
              .map(
                (item) =>
                    PayrollDeduction.fromJson(item.cast<String, dynamic>()),
              )
              .toList() ??
          <PayrollDeduction>[],
      totalDeduction: _doubleValue(json['total_deduction']),
      netSalary: _doubleValue(json['net_salary']),
      details:
          (json['details'] as List?)
              ?.whereType<Map>()
              .map(
                (item) => PayrollDetail.fromJson(item.cast<String, dynamic>()),
              )
              .toList() ??
          <PayrollDetail>[],
      calculatedAt: DateTime.tryParse(json['calculated_at']?.toString() ?? ''),
    );
  }

  DateTime get sortDate =>
      calculatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  String get periodLabel => '${month.toString().padLeft(2, '0')}/$year';

  String get calculatedAtLabel {
    final value = calculatedAt;
    if (value == null) {
      return '-';
    }

    final day = value.day.toString().padLeft(2, '0');
    final monthValue = value.month.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$day/$monthValue/${value.year} $hour:$minute';
  }

  static int _intValue(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      final parsed = int.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
    return fallback;
  }

  static double _doubleValue(dynamic value, {double fallback = 0}) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
    return fallback;
  }
}

class PayrollRates {
  final double dayRate;
  final double hourRate;
  final double minuteRate;

  const PayrollRates({
    required this.dayRate,
    required this.hourRate,
    required this.minuteRate,
  });

  factory PayrollRates.fromJson(Map<String, dynamic> json) {
    return PayrollRates(
      dayRate: PayrollRecord._doubleValue(json['day_rate']),
      hourRate: PayrollRecord._doubleValue(json['hour_rate']),
      minuteRate: PayrollRecord._doubleValue(json['minute_rate']),
    );
  }
}

class PayrollDeduction {
  final String policy;
  final double metric;
  final String metricUnit;
  final double amount;

  const PayrollDeduction({
    required this.policy,
    required this.metric,
    required this.metricUnit,
    required this.amount,
  });

  factory PayrollDeduction.fromJson(Map<String, dynamic> json) {
    return PayrollDeduction(
      policy: json['policy']?.toString().trim() ?? '',
      metric: PayrollRecord._doubleValue(json['metric']),
      metricUnit: json['metric_unit']?.toString().trim() ?? '',
      amount: PayrollRecord._doubleValue(json['amount']),
    );
  }
}

class PayrollDetail {
  final DateTime? date;
  final String status;

  const PayrollDetail({required this.date, required this.status});

  factory PayrollDetail.fromJson(Map<String, dynamic> json) {
    return PayrollDetail(
      date: DateTime.tryParse(json['date']?.toString() ?? ''),
      status: json['status']?.toString().trim() ?? '',
    );
  }

  String get dateLabel {
    final value = date;
    if (value == null) {
      return '-';
    }

    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$day/$month/${value.year}';
  }

  bool get isPresent => status.toLowerCase().trim() == 'present';

  bool get isAbsent => status.toLowerCase().trim() == 'absent';
}

class PayrollPaginationMeta {
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;

  const PayrollPaginationMeta({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });

  factory PayrollPaginationMeta.fromJson(Map<String, dynamic> json) {
    return PayrollPaginationMeta(
      total: PayrollRecord._intValue(json['total']),
      count: PayrollRecord._intValue(json['count']),
      perPage: PayrollRecord._intValue(json['per_page']),
      currentPage: PayrollRecord._intValue(json['current_page']),
      totalPages: PayrollRecord._intValue(json['total_pages']),
    );
  }
}
