import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../getx/controller/register_controller.dart';

class CountryDropdown extends GetView<RegisterController> {
  final bool readOnly;
  final bool withIcon;

  CountryDropdown({super.key, this.readOnly = false, this.withIcon = true});

  final TextEditingController textController = TextEditingController();

  // LanguageController languageController = Get.find<LanguageController>();
  void _openCountryPicker(BuildContext context) {
    // Make a local copy of all countries
    final allCountries = List.of(controller.allCountries);
    controller.filteredCountries.value = allCountries;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Obx(
                  () => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal:0.07.w(context) ,vertical: 0.05.h(context)),
                      child: TextField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'AppString.searchCountry.tr',
                          // hintStyle: Styles.textStyle14.copyWith(
                          //   color: AppColors.lightGray,
                          // ),
                          prefixIcon: const Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          final query = value.trim().toLowerCase();

                          if (query.isEmpty) {
                            controller.filteredCountries.value = allCountries;
                          } else {
                            controller.filteredCountries.value = allCountries
                                .where(
                                  (c) =>
                              // languageController.currentLang.value ==
                              //     'ar'
                              //     ? c.ar.contains(query)
                                 // :
                                c.en.toLowerCase().contains(query),
                            )
                                .toList();
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: controller.filteredCountries.length,
                        itemBuilder: (_, index) {
                          final country = controller.filteredCountries[index];
                          return ListTile(
                            title: Text(
                              // languageController.currentLang.value == 'en'
                              //     ?
                              country.en
                                 // : country.ar,
                              // style: Styles.textStyle14.copyWith(
                              //   color: AppColors.lightGray,
                              // ),
                            ),
                            onTap: () {
                              controller.selectCountry(country);
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Padding(
        padding:  EdgeInsets.symmetric(horizontal: 0.05.w(context) ),
        child: TextFormField(
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppColor.darkGrey,
          ),
          controller: textController
            ..text = controller.selectedCountryName.value,
          readOnly: true,
          onTap: readOnly ? null : () => _openCountryPicker(context),
          decoration: InputDecoration(
            hintText: AppString.nationality,
            hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: AppColor.darkGrey,
            ),

            filled: true,
            fillColor: AppColor.lightGrey,
            prefixIcon: SvgPicture.asset(AppAsset.nationality,fit: BoxFit.scaleDown,),
            suffixIcon: const  Icon(Icons.keyboard_arrow_down,
                size: 22, color: AppColor.lightCyan),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0.02.h(context)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return AppString.required.tr;
          //   }
          //   return null;
          // },
        ),
      ),
    );
  }
}
