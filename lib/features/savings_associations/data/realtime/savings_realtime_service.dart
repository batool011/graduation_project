import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/token_storage.dart';

/// Payload of a `cycle.spin.result` broadcast.
class SavingsSpinResult {
  final int associationId;
  final int cycleId;
  final int cycleNumber;
  final int recipientUserId;
  final String recipientName;

  SavingsSpinResult({
    required this.associationId,
    required this.cycleId,
    required this.cycleNumber,
    required this.recipientUserId,
    required this.recipientName,
  });

  factory SavingsSpinResult.fromJson(Map<String, dynamic> json) {
    final recipient = json['recipient'] as Map<String, dynamic>? ?? {};
    return SavingsSpinResult(
      associationId: json['association_id'] ?? 0,
      cycleId: json['cycle_id'] ?? 0,
      cycleNumber: json['cycle_number'] ?? 0,
      recipientUserId: recipient['user_id'] ?? 0,
      recipientName: recipient['name']?.toString() ?? '-',
    );
  }
}

/// Thin wrapper around `pusher_channels_flutter` for Reverb (Reverb speaks
/// the Pusher protocol, so the same client library works for both).
///
/// Requires (run once): flutter pub add pusher_channels_flutter
///
/// Auth for private channels goes through Laravel's own
/// `/broadcasting/auth` endpoint with the employee's normal Bearer token -
/// exactly the same auth guard as every other API call, so
/// routes/channels.php is what actually decides who can listen (a plain
/// employee can only join an association channel if they're a genuine
/// member of it - department/training managers are rejected outright).
class SavingsRealtimeService {
  SavingsRealtimeService._();
  static final SavingsRealtimeService instance = SavingsRealtimeService._();

  PusherChannelsFlutter? _pusher;
  String? _subscribedChannel;

  Future<void> _ensureConnected() async {
    if (_pusher != null) return;

    _pusher = PusherChannelsFlutter.getInstance();

    await _pusher!.init(
      apiKey: ApiEndPoints.reverbAppKey,
      cluster: 'mt1',
      useTLS: ApiEndPoints.reverbScheme == 'https',
      onAuthorizer: _authorizer,
    );

    await _pusher!.connect();

    await _pusher!.connect();
  }

  /// Custom authorizer for private channels - forwards the request to
  /// Laravel's /broadcasting/auth with the same Bearer token used
  /// everywhere else in the app.
  Future<dynamic> _authorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    final token = await TokenStorage.getToken();

    final response = await Dio().post(
      ApiEndPoints.broadcastingAuth,
      data: {'channel_name': channelName, 'socket_id': socketId},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return response.data;
  }

  /// Subscribes to one association's live channel and invokes [onSpin]
  /// each time a spin result arrives. Automatically leaves any
  /// previously-subscribed association channel first (an employee only
  /// ever needs to watch one association's detail screen at a time).
  Future<void> listenToAssociation(
    int associationId,
    void Function(SavingsSpinResult) onSpin,
  ) async {
    await _ensureConnected();

    final channelName = 'private-savings-association.$associationId';
    if (_subscribedChannel == channelName) return;

    if (_subscribedChannel != null) {
      await _pusher!.unsubscribe(channelName: _subscribedChannel!);
    }

    await _pusher!.subscribe(
      channelName: channelName,
      onEvent: (event) {
        if (event.eventName != 'cycle.spin.result') return;
        final data = jsonDecode(event.data) as Map<String, dynamic>;
        onSpin(SavingsSpinResult.fromJson(data));
      },
    );

    _subscribedChannel = channelName;
  }

  Future<void> stop() async {
    if (_subscribedChannel != null && _pusher != null) {
      await _pusher!.unsubscribe(channelName: _subscribedChannel!);
      _subscribedChannel = null;
    }
  }
}
