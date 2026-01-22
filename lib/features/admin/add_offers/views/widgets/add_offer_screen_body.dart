import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/add_offers/view_models/cubit/add_offer_cubit.dart';
import 'package:disan/features/admin/add_offers/views/widgets/add_offer_form_fields.dart';
import 'package:disan/features/admin/add_offers/views/widgets/pick_offer_image.dart';
import 'package:disan/features/admin/add_product_and_category/view_models/cubit/add_product_cubit.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_failure_message.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_loading.dart';
import 'package:disan/generated/locale_keys.g.dart';

class AddOfferScreenBody extends StatelessWidget {
  const AddOfferScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.03,
            vertical: SizeConfig.height * 0.015,
          ),
          child: BlocProvider(
            create: (context) => AddOfferCubit(),
            child: BlocConsumer<AddOfferCubit, AddOfferState>(
              listener: (context, state) {
                if (state is AddOfferSuccess) {
                  context.popScreen();
                  quickAlert(
                    type: QuickAlertType.success,
                    title: LocaleKeys.success.tr(),
                    text: LocaleKeys.offer_added_successfully.tr(),
                  );
                } else if (state is AddOfferFailure) {
                  quickAlert(
                    type: QuickAlertType.error,
                    title: LocaleKeys.error.tr(), // "Error",
                    text: state.error,
                  );
                } else if (state is FieldEmpty) {
                  quickAlert(
                      type: QuickAlertType.warning,
                      title: LocaleKeys.warning.tr(),
                      text: state.message);
                }
              },
              builder: (context, state) {
                var cubit = context.read<AddOfferCubit>();
                if (state is EmptyProducts) {
                  return CustomFailureMesage(
                    errorMessage: LocaleKeys.no_products_available.tr(),
                  );
                }
                if (state is GetProductsFailure) {
                  return CustomFailureMesage(errorMessage: state.error);
                }
                if (state is AddProductLoading || state is GetProductsLoading) {
                  return CustomLoading();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PickOfferImage(
                        image: cubit.offerImage,
                        onTap: () {
                          cubit.pickOfferImage();
                        }),
                    SizedBox(height: SizeConfig.height * 0.03),
                    AddOfferFormFields(
                      cubit: cubit,
                    ),
                    SizedBox(height: SizeConfig.height * 0.04),
                    state is AddOfferLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.kPrimaryColor,
                            ),
                          )
                        : CustomElevatedButton(
                            name: LocaleKeys.add_offer.tr(),
                            onPressed: () {
                              cubit.addOffer();
                            })
                  ],
                );
              },
            ),
          ),
        ),
    );
  }
}
