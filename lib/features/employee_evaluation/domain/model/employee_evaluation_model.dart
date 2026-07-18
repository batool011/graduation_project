class EmployeeEvaluationResponse {
  final bool? status;
  final EmployeeEvaluationData? data;
  final String? message;

  EmployeeEvaluationResponse({
    this.status,
    this.data,
    this.message,
  });

  factory EmployeeEvaluationResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeEvaluationResponse(
      status: json['status'] as bool?,
      data: json['data'] != null
          ? EmployeeEvaluationData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.toJson(),
    'message': message,
  };
}

class EmployeeEvaluationData {
  final EmployeeEvaluationSummary? evaluation;
  final List<EmployeeEvaluationDetail>? details;

  EmployeeEvaluationData({
    this.evaluation,
    this.details,
  });

  factory EmployeeEvaluationData.fromJson(Map<String, dynamic> json) {
    return EmployeeEvaluationData(
      evaluation: json['evaluation'] != null
          ? EmployeeEvaluationSummary.fromJson(
          json['evaluation'] as Map<String, dynamic>)
          : null,
      details: (json['details'] as List<dynamic>?)
          ?.map((e) =>
          EmployeeEvaluationDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'evaluation': evaluation?.toJson(),
    'details': details?.map((e) => e.toJson()).toList(),
  };
}

class EmployeeEvaluationSummary {
  final int? id;
  final int? companyId;
  final int? employeeId;
  final String? period;
  final String? totalScore;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EmployeeEvaluationSummary({
    this.id,
    this.companyId,
    this.employeeId,
    this.period,
    this.totalScore,
    this.createdAt,
    this.updatedAt,
  });

  /// total_score is a weighted average of each KPI's 0-10 score,
  /// e.g. 0*0.4 + 8.70*0.5 + 0*0.1 = 4.35, so this value is also on a 0-10 scale.
  double get totalScoreValue => double.tryParse(totalScore ?? '') ?? 0.0;

  static const Map<String, String> _arabicMonths = {
    '01': 'يناير',
    '02': 'فبراير',
    '03': 'مارس',
    '04': 'أبريل',
    '05': 'مايو',
    '06': 'يونيو',
    '07': 'يوليو',
    '08': 'أغسطس',
    '09': 'سبتمبر',
    '10': 'أكتوبر',
    '11': 'نوفمبر',
    '12': 'ديسمبر',
  };

  /// e.g. "2026-07" -> "يوليو 2026"
  String get periodLabel {
    final parts = (period ?? '').split('-');
    if (parts.length != 2) return period ?? '';
    final year = parts[0];
    final month = _arabicMonths[parts[1]] ?? parts[1];
    return '$month $year';
  }

  factory EmployeeEvaluationSummary.fromJson(Map<String, dynamic> json) {
    return EmployeeEvaluationSummary(
      id: json['id'] as int?,
      companyId: json['company_id'] as int?,
      employeeId: json['employee_id'] as int?,
      period: json['period'] as String?,
      totalScore: json['total_score']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'company_id': companyId,
    'employee_id': employeeId,
    'period': period,
    'total_score': totalScore,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class EmployeeEvaluationDetail {
  final int? id;
  final int? evaluationId;
  final int? companyKpiConfigId;
  final String? kpiKey;
  final String? score;
  final String? weight;
  final String? raw;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EmployeeEvaluationDetail({
    this.id,
    this.evaluationId,
    this.companyKpiConfigId,
    this.kpiKey,
    this.score,
    this.weight,
    this.raw,
    this.createdAt,
    this.updatedAt,
  });

  /// KPI score is on a 0-10 scale (verified against total_score =
  /// sum(score * weight/100) in the API response).
  double get scoreValue => double.tryParse(score ?? '') ?? 0.0;

  /// weight is a percentage (0-100) of the KPI's contribution to total_score.
  double get weightValue => double.tryParse(weight ?? '') ?? 0.0;

  static const Map<String, String> _kpiTitles = {
    'task_completion': 'إنجاز المهام',
    'attendance': 'الحضور والانضباط',
    'manager_score': 'تقييم المدير',
  };

  /// Human-readable name for this KPI. Falls back to a
  /// humanized version of kpi_key if it's not in the known map.
  String get title {
    if (kpiKey == null) return '';
    return _kpiTitles[kpiKey] ?? _humanize(kpiKey!);
  }

  String get subtitle =>
      'يمثل ${weightValue.toStringAsFixed(0)}% من التقييم الإجمالي';

  String get weightLabel => '${weightValue.toStringAsFixed(0)}%';

  String get scoreLabel => scoreValue.toStringAsFixed(2);

  String _humanize(String key) {
    return key
        .split('_')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  factory EmployeeEvaluationDetail.fromJson(Map<String, dynamic> json) {
    return EmployeeEvaluationDetail(
      id: json['id'] as int?,
      evaluationId: json['evaluation_id'] as int?,
      companyKpiConfigId: json['company_kpi_config_id'] as int?,
      kpiKey: json['kpi_key'] as String?,
      score: json['score']?.toString(),
      weight: json['weight']?.toString(),
      raw: json['raw']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'evaluation_id': evaluationId,
    'company_kpi_config_id': companyKpiConfigId,
    'kpi_key': kpiKey,
    'score': score,
    'weight': weight,
    'raw': raw,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}