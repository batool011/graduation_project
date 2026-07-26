import 'dart:convert';
import 'dart:io';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import '../../../../../core/network/token_storage.dart';
import '../../../../../core/widget/snak_bar_service.dart';
import '../../../../../core/widget/custom_date_picker_field.dart';
import '../../../data/model/company_model.dart';
import '../../../data/model/country_model.dart';
import '../../../data/repository/auth_repository.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var currentStep = 0.obs;
  final int totalSteps = 3;
  final selectedGender = RxnString();
  final selectedMaritalStatus = RxnString();
  final selectedCompanyId = RxnInt();
  
  File? imageFile;
  
  final Rx<File?> employmentContractFile = Rx<File?>(null);
  
  final ImagePicker _picker = ImagePicker();
  final AuthRepository repo = AuthRepository();
  
  late TextEditingController numberController;
  late TextEditingController addressController;
  late TextEditingController emailController;
  late TextEditingController fullNameController;
  late TextEditingController userNameController;
  late TextEditingController ageController;
  late TextEditingController dateOfBirthController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  
  final genderItems = <String>[AppString.female.tr, AppString.male.tr].obs;
  final maritalStatusItems = <String>[
    AppString.single.tr,
    AppString.married.tr,
    AppString.divorced.tr,
    AppString.widowed.tr,
  ].obs;
  final selectedCompanyName = ''.obs;
  RxList<CountryModel> countries = <CountryModel>[].obs;
  var allCountries = <CountryModel>[].obs;
  var filteredCountries = <CountryModel>[].obs;
  RxString selectedCountryName = ''.obs;
  RxList<CompanyModel> companies = <CompanyModel>[].obs;
  var allCompanies = <CompanyModel>[].obs;
  var filteredCompanies = <CompanyModel>[].obs;

  Future<void> register() async {
    final fullName = fullNameController.text.trim();
    final userName = userNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final gender = selectedGender.value?.trim() ?? '';
    final maritalStatus = selectedMaritalStatus.value?.trim() ?? '';
    final country = selectedCountryName.value.trim();
    final companyId = selectedCompanyId.value;
    final age = ageController.text.trim();
    final dateOfBirth = dateOfBirthController.text.trim();
    final address = addressController.text.trim();
    final contactNumber = numberController.text.trim();

    if (password != confirmPassword) {
      SnackbarService.error('كلمتا المرور غير متطابقتين');
      return;
    }

    errorMessage.value = '';
    isLoading.value = true;

    try {
      final data = dio.FormData.fromMap({
        'email': email,
        'name': fullName,
        'username': userName,
        'password': password,
        'password_confirmation': confirmPassword,
        'gender': gender,
        'marital_status': maritalStatus,
        'country': country,
        'company_id': companyId,
        'property_id': companyId,
        'age': age,
        'date': dateOfBirth,
        'address': address,
        'contact_number': contactNumber,
        if (imageFile != null)
          'image': await dio.MultipartFile.fromFile(
            imageFile!.path,
            filename: imageFile!.path.split(Platform.pathSeparator).last,
          ),
        if (employmentContractFile.value != null)
          'employment_contract': await dio.MultipartFile.fromFile(
            employmentContractFile.value!.path,
            filename: employmentContractFile.value!.path.split(Platform.pathSeparator).last,
          ),
      });

      final result = await repo.register(data: data);

      await result.fold<Future<void>>(
        (failure) async {
          errorMessage.value = failure.message;
          Get.log("Error: ${failure.statusCode} ${failure.message}");
          SnackbarService.error(failure.message);
          isLoading.value = false;
          return;
        },
        (response) async {
          try {
            final body = response.data;
            final isSuccess = body['status'] == true;
            
            if (!isSuccess) {
              final msg = body['message']?.toString() ?? 'فشل التسجيل';
              SnackbarService.error(msg);
              isLoading.value = false;
              return;
            }

            final userData = body['data'];
            if (userData != null) {
              final name = userData['name']?.toString() ?? '';
              if (name.isNotEmpty) {
                await TokenStorage.saveUserName(name);
              }
            }

            final message = body['message']?.toString() ?? 'تم التسجيل بنجاح';
            SnackbarService.success(message);

            isLoading.value = false;
            Get.offAllNamed(RoutesName.login);
            
          } catch (e) {
            Get.log("Error processing response: $e");
            SnackbarService.error('حدث خطأ أثناء معالجة البيانات');
            isLoading.value = false;
          }
        },
      );
    } catch (e) {
      Get.log("Register error: $e");
      SnackbarService.error('حدث خطأ أثناء التسجيل');
      isLoading.value = false;
    }
  }

  Future<void> pickImageFromGallery() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      imageFile = File(picked.path);
      update();
      SnackbarService.success('تم اختيار الصورة الشخصية');
    }
  }

  void removeImage() {
    imageFile = null;
    update();
  }

  Future<void> pickEmploymentContract() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null && result.files.isNotEmpty) {
        employmentContractFile.value = File(result.files.first.path!);
        SnackbarService.success('تم اختيار ملف عقد العمل');
      }
    } catch (e) {
      SnackbarService.error('حدث خطأ أثناء اختيار الملف');
    }
  }

  void removeEmploymentContract() {
    employmentContractFile.value = null;
  }

  void selectCountry(CountryModel country) {
    selectedCountryName.value = country.en;
  }

  void selectCompany(CompanyModel company) {
    selectedCompanyId.value = company.id;
    selectedCompanyName.value = company.name;
  }

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void setSelectedGender(String? value) {
    selectedGender.value = value;
  }

  void setSelectedMaritalStatus(String? value) {
    selectedMaritalStatus.value = value;
  }

  Future<void> pickDate(
    BuildContext context,
    TextEditingController controller, {
    DateTime? initialDate,
  }) async {
    final now = DateTime.now();
    final picked = await showAppDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null) {
      controller.text =
          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  Future<void> loadCountries({String? initialCode}) async {
    final String data = await rootBundle.loadString(
      'assets/data/countries.json',
    );
    final List<dynamic> jsonList = json.decode(data);
    countries.value = jsonList.map((e) => CountryModel.fromJson(e)).toList();
    allCountries.value = jsonList.map((e) => CountryModel.fromJson(e)).toList();
    filteredCountries.value =
        jsonList.map((e) => CountryModel.fromJson(e)).toList();

    if (initialCode != null && initialCode.isNotEmpty) {
      final found = countries.firstWhere(
        (c) => c.code.toUpperCase() == initialCode.toUpperCase(),
        orElse:
            () => CountryModel(
              code: initialCode,
              en: initialCode,
              ar: initialCode,
            ),
      );
      selectedCountryName.value = found.en;
    }
  }

  Future<void> loadCompanies({int page = 1, int perPage = 15}) async {
    final result = await repo.getCompanies(page: page, perPage: perPage);

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        Get.log(
          'Companies load error: ${failure.statusCode} ${failure.message}',
        );
      },
      (response) {
        final data = response.data;
        final List<dynamic> list =
            data is Map<String, dynamic>
                ? (data['data'] as List<dynamic>? ?? const [])
                : const [];

        final items =
            list
                .whereType<Map<String, dynamic>>()
                .map(CompanyModel.fromJson)
                .toList();

        companies.value = items;
        allCompanies.value = items;
        filteredCompanies.value = items;
      },
    );
  }

  @override
  void onInit() {
    numberController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    fullNameController = TextEditingController();
    userNameController = TextEditingController();
    ageController = TextEditingController();
    dateOfBirthController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.onInit();
    loadCountries();
    loadCompanies();
  }

  @override
  void onClose() {
    numberController.dispose();
    addressController.dispose();
    emailController.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    ageController.dispose();
    dateOfBirthController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}