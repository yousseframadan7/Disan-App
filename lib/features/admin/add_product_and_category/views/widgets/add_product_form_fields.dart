import 'package:disan/core/components/custom_drop_down_button_form_field.dart';
import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/custom_text_form_field_with_title.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/add_product_and_category/view_models/cubit/add_product_cubit.dart';
import 'package:disan/features/admin/add_product_and_category/views/widgets/pick_image.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductFormFiels extends StatelessWidget {
  const AddProductFormFiels({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        var cubit = context.read<AddProductCubit>();
        return SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.height * 0.03),
                CustomTextFormFieldWithTitle(
                  hintText:LocaleKeys.enter_product_name.tr(), // "enter product name",
                  title:LocaleKeys.product_name.tr(), // "Product Name",
                  controller: cubit.nameController,
                ),
                SizedBox(height: SizeConfig.height * 0.015),
                CustomTextFormFieldWithTitle(
                  hintText:LocaleKeys.enter_product_description.tr(), // "enter product description",
                  title:LocaleKeys.description.tr(), // "Description",
                  controller: cubit.descriptionController,
                ),
                SizedBox(height: SizeConfig.height * 0.015),
                CustomTextFormFieldWithTitle(
                  hintText:LocaleKeys.enter_product_price.tr(), // "enter product price ( 0.00 LE)",
                  title:LocaleKeys.price.tr(), // "Price",
                  controller: cubit.priceController,
                ),
                SizedBox(height: SizeConfig.height * 0.015),
                state is GetCategoriesLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      )
                    : CustomDropDownButtonFormField(
                        userRoles: cubit.categories.map((e) => e.name).toList(),
                        title:LocaleKeys.category.tr(), // "Category",
                        controller: cubit.categoryController,
                        hintText: LocaleKeys.select_category.tr(),
                      ),
                SizedBox(height: SizeConfig.height * 0.015),
                CustomTextFormFieldWithTitle(
                  hintText:LocaleKeys.enter_product_quantity.tr(), // "enter product quantity",
                  title:LocaleKeys.quantity.tr(), // "Quantity",
                  controller: cubit.stockController,
                ),
                Text(LocaleKeys.product_images.tr(), style: AppTextStyles.title18BlackBold),
                SizedBox(height: SizeConfig.height * 0.015),
                PickImage(
                  imageFile: cubit.productImage,
                  onPickImage: () => cubit.pickProductImage(),
                ),
                SizedBox(height: SizeConfig.height * 0.04),
                state is AddProductLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      )
                    : CustomElevatedButton(
                        name:LocaleKeys.add_product.tr(), // "Add Product",
                        onPressed: () {
                          cubit.addProduct();
                        },
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
