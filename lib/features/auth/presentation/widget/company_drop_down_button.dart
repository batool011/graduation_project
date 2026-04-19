import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../data/model/company_model.dart';
import '../getx/controller/register_controller.dart';

class CompanyDropdown extends GetView<RegisterController> {
  final bool readOnly;

  CompanyDropdown({super.key, this.readOnly = false});

  final TextEditingController textController = TextEditingController();

  void _openCompanyPicker(BuildContext context) {
    final allCompanies = List.of(controller.allCompanies);
    controller.filteredCompanies.value = allCompanies;

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
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.07.w(context),
                        vertical: 0.05.h(context),
                      ),
                      child: TextField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: AppString.search.tr,
                          prefixIcon: const Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          final query = value.trim().toLowerCase();

                          if (query.isEmpty) {
                            controller.filteredCompanies.value = allCompanies;
                          } else {
                            controller.filteredCompanies.value =
                                allCompanies.where((company) {
                                  final name = company.name.toLowerCase();
                                  final location =
                                      company.location.toLowerCase();
                                  return name.contains(query) ||
                                      location.contains(query);
                                }).toList();
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child:
                          controller.filteredCompanies.isEmpty
                              ? Center(
                                child: Text(
                                  'لا توجد شركات متاحة',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              )
                              : ListView.builder(
                                controller: scrollController,
                                itemCount: controller.filteredCompanies.length,
                                itemBuilder: (_, index) {
                                  final CompanyModel company =
                                      controller.filteredCompanies[index];
                                  return ListTile(
                                    title: Text(company.name),
                                    subtitle:
                                        company.location.isEmpty
                                            ? null
                                            : Text(company.location),
                                    onTap: () {
                                      controller.selectCompany(company);
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
        padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
        child: TextFormField(
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(color: AppColor.darkGrey),
          controller:
              textController..text = controller.selectedCompanyName.value,
          readOnly: true,
          onTap: readOnly ? null : () => _openCompanyPicker(context),
          decoration: InputDecoration(
            hintText: AppString.selectCompany.tr,
            hintStyle: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColor.darkGrey),
            filled: true,
            fillColor: AppColor.lightGrey,
            prefixIcon: SvgPicture.asset(
              AppAsset.company,
              fit: BoxFit.scaleDown,
            ),
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 22,
              color: AppColor.secondryColor,
            ),
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
        ),
      ),
    );
  }
}
