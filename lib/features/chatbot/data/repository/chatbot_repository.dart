import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:dartz/dartz.dart';

class ChatbotReply {
  final String intent;
  final String reply;

  ChatbotReply({required this.intent, required this.reply});

  factory ChatbotReply.fromJson(Map<String, dynamic> json) {
    return ChatbotReply(
      intent: json['intent']?.toString() ?? 'fallback',
      reply: json['reply']?.toString() ?? '',
    );
  }
}

class ChatbotRepository {
  Future<Either<AppException, ChatbotReply>> ask(String message) async {
    final result = await ApiHandler.request(
      () => DioHelper.postData(
        url: ApiEndPoints.chatbotQuery,
        data: {'message': message},
        requiresToken: true,
      ),
    );

    return result.fold(
      Left.new,
      (response) {
        try {
          final data = response.data['data'];
          return Right(ChatbotReply.fromJson(data as Map<String, dynamic>));
        } catch (e) {
          return Left(AppException('تعذر الحصول على رد من المساعد'));
        }
      },
    );
  }
}
