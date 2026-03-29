import 'dart:convert';
import 'dart:io';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/model/country_model.dart';

class RegisterController extends GetxController {
  var currentStep = 0.obs;
  final int totalSteps = 6;
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  final genderItems = <String>[
    AppString.female.tr,
    AppString.male.tr
  ].obs;
  final selectedGender = RxnString();

  Future<void> pickImageFromGallery() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      imageFile = File(picked.path);
      update();
    }
  }

  RxList<CountryModel> countries = <CountryModel>[].obs;
  var allCountries = <CountryModel>[].obs;
  var filteredCountries = <CountryModel>[].obs;
  RxString selectedCountryName = ''.obs;
 //
  RxList<TextEditingController> linkControllers = <TextEditingController>[].obs;
  RxList<TextEditingController> numberControllers = <TextEditingController>[].obs;
  void addNumberField() {
    numberControllers.add(TextEditingController());
  }

  void removeNumberField(int index) {
    numberControllers[index].dispose();
    numberControllers.removeAt(index);
  }
  void addLinkField() {
    linkControllers.add(TextEditingController());
  }

  void removeLinkField(int index) {
    linkControllers[index].dispose();
    linkControllers.removeAt(index);
  }

  void selectCountry(CountryModel country) {
    selectedCountryName.value =  country.en;
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

  Future<void> loadCountries({String? initialCode}) async {
    final String data = await rootBundle.loadString(
      'assets/data/countries.json',
    );
    final List<dynamic> jsonList = json.decode(data);
    countries.value = jsonList.map((e) => CountryModel.fromJson(e)).toList();
    allCountries.value = jsonList.map((e) => CountryModel.fromJson(e)).toList();
    filteredCountries.value = jsonList
        .map((e) => CountryModel.fromJson(e))
        .toList();

    if (initialCode != null && initialCode.isNotEmpty) {
      final found = countries.firstWhere(
            (c) => c.code.toUpperCase() == initialCode.toUpperCase(),
        orElse: () =>
            CountryModel(code: initialCode, en: initialCode, ar: initialCode),
      );
      selectedCountryName.value = found.en;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadCountries();
  }
}
