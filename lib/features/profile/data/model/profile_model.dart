
class ProfileModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final double? salary;
  final String status;
  final int? companyId;
  final int? departmentId;
  final Department? department;
  final Documents documents;
  final Shift? shift;
  final String createdAt;
  final String updatedAt;

  ProfileModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.salary,
    required this.status,
    this.companyId,
    this.departmentId,
    this.department,
    required this.documents,
    this.shift,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      salary: json['salary']?.toDouble(),
      status: json['status'] ?? 'pending',
      companyId: json['company_id'],
      departmentId: json['department_id'],
      department: json['department'] != null
          ? Department.fromJson(json['department'])
          : null,
      documents: Documents.fromJson(json['documents'] ?? {}),
      shift: json['shifts'] != null
          ? Shift.fromJson(json['shifts'])
          : null,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  bool get isApproved => status == 'approved';
  bool get isPending => status == 'pending';
  bool get isRejected => status == 'rejected';

  String get statusLabel {
    switch (status) {
      case 'approved':
        return 'مفعل';
      case 'pending':
        return 'قيد الانتظار';
      case 'rejected':
        return 'مرفوض';
      default:
        return status;
    }
  }
}

class Department {
  final int id;
  final String name;

  Department({required this.id, required this.name});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class Documents {
  final List<String> personalIdPhoto;
  final List<String> employmentContract;

  Documents({
    required this.personalIdPhoto,
    required this.employmentContract,
  });

  factory Documents.fromJson(Map<String, dynamic> json) {
    return Documents(
      personalIdPhoto: _parseList(json['personal_id_photo']),
      employmentContract: _parseList(json['employment_contract']),
    );
  }

  static List<String> _parseList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }

  int get totalDocuments => personalIdPhoto.length + employmentContract.length;
}

class Shift {
  final int id;
  final String name;
  final String startTime;
  final String endTime;

  Shift({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
    );
  }

  String get formattedTime => '$startTime - $endTime';
}