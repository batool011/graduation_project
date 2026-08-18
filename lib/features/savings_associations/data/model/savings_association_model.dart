class SavingsMemberModel {
  final int id;
  final int userId;
  final String? username;
  final String? name;
  final String invitationStatus; // invited | joined | declined | removed
  final int? payoutOrder;
  final bool hasCollected;
  final DateTime? collectedAt;
  final DateTime? respondedAt;

  SavingsMemberModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.name,
    required this.invitationStatus,
    required this.payoutOrder,
    required this.hasCollected,
    required this.collectedAt,
    required this.respondedAt,
  });

  factory SavingsMemberModel.fromJson(Map<String, dynamic> json) {
    return SavingsMemberModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      username: json['username']?.toString(),
      name: json['name']?.toString(),
      invitationStatus: json['invitation_status']?.toString() ?? 'invited',
      payoutOrder: json['payout_order'],
      hasCollected: json['has_collected'] == true,
      collectedAt: _date(json['collected_at']),
      respondedAt: _date(json['responded_at']),
    );
  }

  bool get isInvited => invitationStatus == 'invited';
  bool get isJoined => invitationStatus == 'joined';
  bool get isDeclined => invitationStatus == 'declined';

  static DateTime? _date(dynamic v) =>
      v is String && v.trim().isNotEmpty ? DateTime.tryParse(v) : null;
}

class SavingsCycleModel {
  final int id;
  final int cycleNumber;
  final int month;
  final int year;
  final double potAmount;
  final String status; // pending | determined | paid | skipped
  final String? determinedBy; // manual | spin
  final DateTime? determinedAt;
  final int? recipientMemberId;
  final int? recipientUserId;
  final String? recipientName;

  SavingsCycleModel({
    required this.id,
    required this.cycleNumber,
    required this.month,
    required this.year,
    required this.potAmount,
    required this.status,
    required this.determinedBy,
    required this.determinedAt,
    required this.recipientMemberId,
    required this.recipientUserId,
    required this.recipientName,
  });

  factory SavingsCycleModel.fromJson(Map<String, dynamic> json) {
    final recipient = json['recipient'] as Map<String, dynamic>?;
    return SavingsCycleModel(
      id: json['id'] ?? 0,
      cycleNumber: json['cycle_number'] ?? 0,
      month: json['month'] ?? 0,
      year: json['year'] ?? 0,
      potAmount: (json['pot_amount'] as num?)?.toDouble() ?? 0,
      status: json['status']?.toString() ?? 'pending',
      determinedBy: json['determined_by']?.toString(),
      determinedAt: SavingsMemberModel._date(json['determined_at']),
      recipientMemberId: recipient?['member_id'],
      recipientUserId: recipient?['user_id'],
      recipientName: recipient?['name']?.toString(),
    );
  }

  bool get isPending => status == 'pending';
  bool get isDetermined => status == 'determined';
  bool get isPaid => status == 'paid';
}

class SavingsMessageModel {
  final int id;
  final int userId;
  final String? username;
  final String? name;
  final String message;
  final DateTime? createdAt;

  SavingsMessageModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.name,
    required this.message,
    required this.createdAt,
  });

  factory SavingsMessageModel.fromJson(Map<String, dynamic> json) {
    return SavingsMessageModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      username: json['username']?.toString(),
      name: json['name']?.toString(),
      message: json['message']?.toString() ?? '',
      createdAt: SavingsMemberModel._date(json['created_at']),
    );
  }
}

class SavingsAssociationModel {
  final int id;
  final String name;
  final String? description;
  final double monthlyAmount;
  final String memberSelectionMode; // fixed_count | open_until_deadline
  final int? targetMemberCount;
  final DateTime? joinDeadline;
  final String payoutOrderType; // fixed | random
  final String status; // draft | open_for_joining | active | completed | cancelled
  final int? startMonth;
  final int? startYear;
  final int joinedMembersCount;
  final List<SavingsMemberModel> members;
  final List<SavingsCycleModel> cycles;
  final SavingsMemberModel? myMembership;

  SavingsAssociationModel({
    required this.id,
    required this.name,
    required this.description,
    required this.monthlyAmount,
    required this.memberSelectionMode,
    required this.targetMemberCount,
    required this.joinDeadline,
    required this.payoutOrderType,
    required this.status,
    required this.startMonth,
    required this.startYear,
    required this.joinedMembersCount,
    required this.members,
    required this.cycles,
    required this.myMembership,
  });

  factory SavingsAssociationModel.fromJson(Map<String, dynamic> json) {
    return SavingsAssociationModel(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
      monthlyAmount: (json['monthly_amount'] as num?)?.toDouble() ?? 0,
      memberSelectionMode: json['member_selection_mode']?.toString() ?? 'fixed_count',
      targetMemberCount: json['target_member_count'],
      joinDeadline: SavingsMemberModel._date(json['join_deadline']),
      payoutOrderType: json['payout_order_type']?.toString() ?? 'fixed',
      status: json['status']?.toString() ?? 'draft',
      startMonth: json['start_month'],
      startYear: json['start_year'],
      joinedMembersCount: json['joined_members_count'] ?? 0,
      members: (json['members'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(SavingsMemberModel.fromJson)
          .toList(),
      cycles: (json['cycles'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(SavingsCycleModel.fromJson)
          .toList(),
      myMembership: json['my_membership'] is Map<String, dynamic>
          ? SavingsMemberModel.fromJson(json['my_membership'] as Map<String, dynamic>)
          : null,
    );
  }

  bool get isOpenForJoining => status == 'open_for_joining';
  bool get isActive => status == 'active';
  bool get isCompleted => status == 'completed';
  bool get isRandomOrder => payoutOrderType == 'random';
  bool get isFixedOrder => payoutOrderType == 'fixed';

  /// Whether the current employee can still respond (invited but hasn't
  /// answered yet).
  bool get canRespond => myMembership != null && myMembership!.isInvited;

  SavingsCycleModel? get nextPendingCycle {
    for (final c in cycles) {
      if (c.isPending) return c;
    }
    return null;
  }
}
