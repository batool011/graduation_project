class VacationRequest {
  final int id;
  final int userId;
  final String fromDate;
  final int duration;
  final String reason;
  final String status;
  final List<VacationAttachment> attachments;

  VacationRequest({
    required this.id,
    required this.userId,
    required this.fromDate,
    required this.duration,
    required this.reason,
    required this.status,
    required this.attachments,
  });

  factory VacationRequest.fromJson(Map<String, dynamic> json) {
    return VacationRequest(
      id: _intValue(json['id']),
      userId: _intValue(json['user_id']),
      fromDate: json['from_date']?.toString() ?? '',
      duration: _intValue(json['duration']),
      reason: json['reason']?.toString() ?? '',
      status: json['status']?.toString() ?? 'pending',
      attachments: _attachmentsValue(json['attachments']),
    );
  }

  VacationStatus get statusEnum => VacationStatusMapper.fromApi(status);

  String get statusLabel => VacationStatusMapper.label(statusEnum);

  int get statusColorValue => VacationStatusMapper.colorValue(statusEnum);

  String get formattedFromDate => _formattedDate(fromDate);

  static int _intValue(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is String) {
      final parsed = int.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
    return fallback;
  }

  static String _formattedDate(String value) {
    final parsed = DateTime.tryParse(value);
    if (parsed == null) {
      return value;
    }
    return '${parsed.day}-${parsed.month}-${parsed.year}';
  }

  static List<VacationAttachment> _attachmentsValue(dynamic value) {
    if (value is! List) {
      return <VacationAttachment>[];
    }

    return value
        .whereType<Map<String, dynamic>>()
        .map(VacationAttachment.fromJson)
        .toList();
  }
}

class VacationAttachment {
  final int id;
  final int vacationId;
  final String filePath;
  final String fileUrl;
  final String documentProvider;

  VacationAttachment({
    required this.id,
    required this.vacationId,
    required this.filePath,
    required this.fileUrl,
    required this.documentProvider,
  });

  factory VacationAttachment.fromJson(Map<String, dynamic> json) {
    return VacationAttachment(
      id: VacationRequest._intValue(json['id']),
      vacationId: VacationRequest._intValue(json['vecation_id']),
      filePath: json['file_path']?.toString() ?? '',
      fileUrl: json['file_url']?.toString() ?? '',
      documentProvider: json['document_provider']?.toString() ?? '',
    );
  }
}

class VacationPaginationMeta {
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;

  VacationPaginationMeta({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });

  factory VacationPaginationMeta.fromJson(Map<String, dynamic> json) {
    return VacationPaginationMeta(
      total: VacationRequest._intValue(json['total']),
      count: VacationRequest._intValue(json['count']),
      perPage: VacationRequest._intValue(json['per_page']),
      currentPage: VacationRequest._intValue(json['current_page']),
      totalPages: VacationRequest._intValue(json['total_pages']),
    );
  }
}

class VacationRequestsPage {
  final List<VacationRequest> items;
  final VacationPaginationMeta? meta;

  VacationRequestsPage({required this.items, required this.meta});

  factory VacationRequestsPage.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final items = data is List
        ? data
            .whereType<Map<String, dynamic>>()
            .map(VacationRequest.fromJson)
            .toList()
        : <VacationRequest>[];

    final metaJson = json['meta'];
    final meta = metaJson is Map<String, dynamic>
        ? VacationPaginationMeta.fromJson(metaJson)
        : null;

    return VacationRequestsPage(items: items, meta: meta);
  }
}

class VacationRequestDetailResponse {
  final VacationRequest request;

  VacationRequestDetailResponse({required this.request});

  factory VacationRequestDetailResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) {
      return VacationRequestDetailResponse(request: VacationRequest.fromJson(data));
    }

    throw FormatException('Invalid vacation detail response');
  }
}

enum VacationStatus { pending, approved, rejected, unknown }

class VacationStatusMapper {
  static VacationStatus fromApi(String? value) {
    switch (value?.trim().toLowerCase()) {
      case 'pending':
        return VacationStatus.pending;
      case 'approved':
        return VacationStatus.approved;
      case 'rejected':
        return VacationStatus.rejected;
      default:
        return VacationStatus.unknown;
    }
  }

  static String label(VacationStatus status) {
    switch (status) {
      case VacationStatus.pending:
        return 'قيد الانتظار';
      case VacationStatus.approved:
        return 'موافق عليه';
      case VacationStatus.rejected:
        return 'مرفوض';
      case VacationStatus.unknown:
        return 'غير معروف';
    }
  }

  static int colorValue(VacationStatus status) {
    switch (status) {
      case VacationStatus.pending:
        return 0xFFF57C00;
      case VacationStatus.approved:
        return 0xFF2E7D32;
      case VacationStatus.rejected:
        return 0xFFC62828;
      case VacationStatus.unknown:
        return 0xFF607D8B;
    }
  }
}
