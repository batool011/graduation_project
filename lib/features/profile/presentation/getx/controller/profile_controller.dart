// profile_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  RxMap<String, String> userData = <String, String>{}.obs;
  RxBool loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileFromLocal();
  }

  // تحميل البيانات من التخزين المحلي
  Future<void> loadProfileFromLocal() async {
    loading.value = true;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // جلب جميع البيانات المحفوظة
      userData['id'] = prefs.getString('user_id') ?? '';
      userData['name'] = prefs.getString('user_name') ?? '';
      userData['username'] = prefs.getString('user_username') ?? '';
      userData['email'] = prefs.getString('user_email') ?? '';
      userData['phone'] = prefs.getString('user_phone') ?? '';
      userData['address'] = prefs.getString('user_address') ?? '';
      userData['gender'] = prefs.getString('user_gender') ?? '';
      userData['maritalStatus'] = prefs.getString('user_marital_status') ?? '';
      userData['dateOfBirth'] = prefs.getString('user_date_of_birth') ?? '';
      userData['salary'] = prefs.getString('user_salary') ?? '';
      userData['company'] = prefs.getString('user_company') ?? '';
      userData['department'] = prefs.getString('user_department') ?? '';
      userData['role'] = prefs.getString('user_role') ?? 'employee';
      userData['status'] = prefs.getString('user_status') ?? 'pending';
      
      loading.value = false;
    } catch (e) {
      loading.value = false;
      Get.snackbar(
        "خطأ",
        "حدث خطأ في تحميل البيانات",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  // تحديث البيانات محلياً (بعد التعديل)
  Future<void> updateProfile(Map<String, String> newData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      newData.forEach((key, value) {
        prefs.setString('user_$key', value);
        userData[key] = value;
      });
      
      Get.snackbar(
        "نجاح",
        "تم تحديث الملف الشخصي بنجاح",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "خطأ",
        "حدث خطأ في تحديث البيانات",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  // تسجيل الخروج - حذف التوكن فقط
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      // لا نحذف بيانات المستخدم عشان تبقى محفوظة
      Get.offAllNamed('/login');
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}