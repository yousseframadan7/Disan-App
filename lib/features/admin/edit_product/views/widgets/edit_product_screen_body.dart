import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/edit_product/view_models/cubit/update_product_cubit.dart';
import 'package:disan/features/admin/edit_product/views/widgets/edit_product_form_fields.dart';
import 'package:disan/features/admin/edit_product/views/widgets/pick_product_image.dart';

import 'package:disan/generated/locale_keys.g.dart';

class EditProductScreenBody extends StatelessWidget {
  const EditProductScreenBody({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => UpdateProductCubit(product: product),
        child: BlocConsumer<UpdateProductCubit, UpdateProductState>(
          listener: (context, state) {
            if (state is UpdateProductSuccess) {
              context.popScreen();
              context.popScreen();
              quickAlert(
                type: QuickAlertType.success,
                text: LocaleKeys.product_updated_successfully.tr(),
                title: LocaleKeys.success.tr(),
              );
            }
            if (state is UpdateProductFailure) {
              quickAlert(
                type: QuickAlertType.error,
                text: state.message,
                title: LocaleKeys.error.tr(),
              );
            }
          },
          builder: (context, state) {
            var cubit = context.read<UpdateProductCubit>();
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.03,
                vertical: SizeConfig.height * 0.01,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PickProductImage(product: product),
                  SizedBox(height: SizeConfig.height * 0.03),
                  EditProductFormFields(cubit: cubit),
                  SizedBox(height: SizeConfig.height * 0.05),
                  state is UpdateProductLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomElevatedButton(
                          name: 'Update',
                          onPressed: () {
                            cubit.updateProduct();
                          },
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
