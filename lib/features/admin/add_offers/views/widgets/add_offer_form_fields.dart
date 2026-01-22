import 'package:disan/features/admin/add_offers/views/widgets/buy_get_row.dart';
import 'package:disan/features/admin/add_offers/views/widgets/custom_date_picker_form_field.dart';
import 'package:disan/features/admin/add_offers/views/widgets/discount_field.dart';
import 'package:disan/features/admin/add_offers/views/widgets/gift_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/add_offers/view_models/cubit/add_offer_cubit.dart';
import 'package:disan/features/admin/add_offers/views/widgets/custom_drop_down_button_form_filed.dart';
import 'package:disan/features/admin/add_offers/views/widgets/custom_offer_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:intl/intl.dart';

class AddOfferFormFields extends StatelessWidget {
  final AddOfferCubit cubit;
  const AddOfferFormFields({super.key, required this.cubit});

  String get offerType => getIt<CacheHelper>().getData(key: "offerType");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomOfferTextField(
          label: LocaleKeys.offer_title.tr(),
          hint: LocaleKeys.enter_offer_title.tr(),
          maxLines: 1,
          keyboardType: TextInputType.text,
          isRequired: true,
          icon: Icons.title_rounded,
          controller: cubit.titleController,
        ),
        SizedBox(height: SizeConfig.height * 0.025),
        CustomOfferTextField(
          label: LocaleKeys.offer_description.tr(),
          hint: LocaleKeys.enter_offer_description.tr(),
          maxLines: 4,
          keyboardType: TextInputType.text,
          icon: Icons.description_rounded,
          controller: cubit.descriptionController,
        ),
        SizedBox(height: SizeConfig.height * 0.025),
        CustomOfferDropDownButtonFormField(
          items: cubit.products,
          hintText: LocaleKeys.select_product.tr(),
          title: LocaleKeys.product_name.tr(),
          primaryColor: AppColors.kPrimaryColor,
          onChanged: (value) {
            cubit.selectedProduct =
                cubit.products.firstWhere((p) => p.id == value!.id);
          },
        ),
        SizedBox(height: SizeConfig.height * 0.025),
        if (offerType == 'discount') DiscountField(cubit: cubit),
        if (offerType == 'gift') GiftDropdown(cubit: cubit),
        if (offerType == 'buyXgetYSame') BuyGetRow(cubit: cubit),
        if (offerType == 'buyXgetYDifferent') ...[
          GiftDropdown(cubit: cubit),
          SizedBox(height: SizeConfig.height * 0.025),
          BuyGetRow(cubit: cubit),
        ],

        SizedBox(height: SizeConfig.height * 0.025),
        BlocBuilder<AddOfferCubit, AddOfferState>(
          buildWhen: (previous, current) => current is PickDateSuccess,
          builder: (context, state) {
            return CustomDatePickerFormField(
              hintText: LocaleKeys.select_end_date.tr(),
              title: LocaleKeys.end_date.tr(),
              controller: TextEditingController(
                text: cubit.selectedEndDate != null
                    ? DateFormat('yyyy-MM-dd').format(cubit.selectedEndDate!)
                    : '',
              ),
              onDateSelected: (date) {
                cubit.selectedEndDate = date;
                cubit.emit(PickDateSuccess());
              },
            );
          },
        ),
      ],
    );
  }
}



