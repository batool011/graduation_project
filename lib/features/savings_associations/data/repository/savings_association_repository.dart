import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:dartz/dartz.dart';
import '../model/savings_association_model.dart';

class SavingsAssociationRepository {
  Future<Either<AppException, List<SavingsAssociationModel>>> getAll() async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(url: ApiEndPoints.savingsAssociations, requiresToken: true),
    );
    return result.fold(Left.new, (response) {
      try {
        final data = response.data['data'] as List<dynamic>? ?? [];
        return Right(data.whereType<Map<String, dynamic>>().map(SavingsAssociationModel.fromJson).toList());
      } catch (e) {
        return Left(AppException('تعذر تحميل جمعيات الادخار'));
      }
    });
  }

  Future<Either<AppException, SavingsAssociationModel>> getOne(int id) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(url: ApiEndPoints.savingsAssociationDetail(id), requiresToken: true),
    );
    return result.fold(Left.new, (response) {
      try {
        return Right(SavingsAssociationModel.fromJson(response.data['data']));
      } catch (e) {
        return Left(AppException('تعذر تحميل تفاصيل الجمعية'));
      }
    });
  }

  Future<Either<AppException, SavingsAssociationModel>> respond({
    required int associationId,
    required bool accept,
  }) async {
    final result = await ApiHandler.request(
      () => DioHelper.postData(
        url: ApiEndPoints.savingsAssociationRespond(associationId),
        data: {'accept': accept},
        requiresToken: true,
      ),
    );

    if (result.isLeft()) {
      return Left(result.swap().getOrElse(() => AppException('تعذر إرسال ردّك')));
    }

    // The respond endpoint only returns the member row - refetch the full
    // association so the UI reflects the new membership status right away.
    return getOne(associationId);
  }

  Future<Either<AppException, List<SavingsMessageModel>>> getMessages(int associationId) async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(url: ApiEndPoints.savingsAssociationMessages(associationId), requiresToken: true),
    );
    return result.fold(Left.new, (response) {
      try {
        final data = response.data['data'] as List<dynamic>? ?? [];
        return Right(data.whereType<Map<String, dynamic>>().map(SavingsMessageModel.fromJson).toList());
      } catch (e) {
        return Left(AppException('تعذر تحميل الرسائل'));
      }
    });
  }

  Future<Either<AppException, SavingsMessageModel>> postMessage({
    required int associationId,
    required String message,
  }) async {
    final result = await ApiHandler.request(
      () => DioHelper.postData(
        url: ApiEndPoints.savingsAssociationMessages(associationId),
        data: {'message': message},
        requiresToken: true,
      ),
    );
    return result.fold(Left.new, (response) {
      try {
        return Right(SavingsMessageModel.fromJson(response.data['data']));
      } catch (e) {
        return Left(AppException('تعذر إرسال الرسالة'));
      }
    });
  }
}
