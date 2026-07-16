class EmployeeEvaluationResponse {
  final bool status;
  final EmployeeEvaluationData? data;
  final String message;

  const EmployeeEvaluationResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory EmployeeEvaluationResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return EmployeeEvaluationResponse(
      status: json['status'] == true,
      data: data is Map<String, dynamic>
          ? EmployeeEvaluationData.fromJson(data)
          : null,
      message: json['message']?.toString().trim() ?? '',
    );
  }
}

class EmployeeEvaluationData {
  final EmployeeEvaluationSummary evaluation;
  final List<EmployeeEvaluationDetail> details;

  const EmployeeEvaluationData({
    required this.evaluation,
    required this.details,
  });

  factory EmployeeEvaluationData.fromJson(Map<String, dynamic> json) {
    final details = json['details'];

    return EmployeeEvaluationData(
      evaluation: EmployeeEvaluationSummary.fromJson(
        (json['evaluation'] as Map?)?.cast<String, dynamic>() ??
            <String, dynamic>{},
      ),
      details: details is List
          ? details
              .whereType<Map<String, dynamic>>()
              .map(EmployeeEvaluationDetail.fromJson)
              .toList()
          : <EmployeeEvaluationDetail>[],
    );
  }
}

class EmployeeEvaluationSummary {
  final int id;
  final int companyId;
  final int employeeId;
  final String period;
  final String totalScore;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const EmployeeEvaluationSummary({
    required this.id,
    required this.companyId,
    required this.employeeId,
    required this.period,
    required this.totalScore,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmployeeEvaluationSummary.fromJson(Map<String, dynamic> json) {
    return EmployeeEvaluationSummary(
      id: _intValue(json['id']),
      companyId: _intValue(json['company_id']),
      employeeId: _intValue(json['employee_id']),
      period: json['period']?.toString().trim() ?? '',
      totalScore: json['total_score']?.toString().trim() ?? '0',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
    );
  }

  double get totalScoreValue => double.tryParse(totalScore) ?? 0;

  String get periodLabel {
    if (period.isEmpty) {
      return 'غير محدد';
    }

    final parts = period.split('-');
    if (parts.length != 2) {
      return period;
    }

    final year = parts[0];
    final month = int.tryParse(parts[1]) ?? 0;
    const months = [
      '',
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    final monthName = month >= 1 && month < months.length ? months[month] : '';
    if (monthName.isEmpty) {
      return period;
    }

    return '$monthName $year';
  }
}

class EmployeeEvaluationDetail {
  final int id;
  final int evaluationId;
  final int companyKpiConfigId;
  final String kpiKey;
  final String score;
  final String weight;
  final String? raw;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const EmployeeEvaluationDetail({
    required this.id,
    required this.evaluationId,
    required this.companyKpiConfigId,
    required this.kpiKey,
    required this.score,
    required this.weight,
    required this.raw,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmployeeEvaluationDetail.fromJson(Map<String, dynamic> json) {
    return EmployeeEvaluationDetail(
      id: _intValue(json['id']),
      evaluationId: _intValue(json['evaluation_id']),
      companyKpiConfigId: _intValue(json['company_kpi_config_id']),
      kpiKey: json['kpi_key']?.toString().trim() ?? '',
      score: json['score']?.toString().trim() ?? '0',
      weight: json['weight']?.toString().trim() ?? '0',
      raw: _stringValue(json['raw']),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
    );
  }

  double get scoreValue => double.tryParse(score) ?? 0;

  double get weightValue => double.tryParse(weight) ?? 0;

  String get title => kpiLabelFor(kpiKey);

  String get subtitle => kpiDescriptionFor(kpiKey);

  String get scoreLabel => _formatNumber(scoreValue);

  String get weightLabel => '${_formatNumber(weightValue)}%';
}

int _intValue(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  if (value is String) {
    final parsed = int.tryParse(value.trim());
    if (parsed != null) return parsed;
  }
  return fallback;
}

String? _stringValue(dynamic value) {
  if (value == null) return null;
  final text = value.toString().trim();
  return text.isEmpty ? null : text;
}

String _formatNumber(double value) {
  if (value == value.roundToDouble()) {
    return value.toInt().toString();
  }
  return value.toStringAsFixed(2);
}

String kpiLabelFor(String key) {
  switch (key) {
    case 'task_completion':
      return 'إنجاز المهام';
    case 'attendance':
      return 'الالتزام بالحضور';
    case 'manager_score':
      return 'تقييم المدير';
    default:
      return key.replaceAll('_', ' ').trim();
  }
}

String kpiDescriptionFor(String key) {
  switch (key) {
    case 'task_completion':
      return 'نسبة إنجاز المهام ضمن الفترة المحددة';
    case 'attendance':
      return 'الأداء المرتبط بالحضور والانضباط';
    case 'manager_score':
      return 'الدرجة المعتمدة من المدير المباشر';
    default:
      return 'مؤشر أداء رئيسي';
  }
}