// lib/features/profile/data/repository/profile_repository.dart

import 'package:career/core/network/api_end_point.dart';
import 'package:career/core/network/api_handler.dart';
import 'package:career/core/network/dio_helper.dart';
import 'package:career/core/network/exceptions.dart';
import 'package:career/features/profile/data/model/profile_model.dart';
import 'package:dartz/dartz.dart';

class ProfileRepository {
  Future<Either<AppException, ProfileModel>> getProfile() async {
    final result = await ApiHandler.request(
      () => DioHelper.getData(
        url: ApiEndPoints.profile,
        requiresToken: true,
      ),
    );

    return result.fold(
      (failure) => Left(failure),
      (response) {
        try {
          final data = response.data['data'];
          final profile = ProfileModel.fromJson(data as Map<String, dynamic>);
          return Right(profile);
        } catch (e) {
          return Left(AppException('تعذر تحميل الملف الشخصي'));
        }
      },
    );
  }
}