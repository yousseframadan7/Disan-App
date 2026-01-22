import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/custom_text_form_field_with_title.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/add_product_and_category/view_models/cubit/add_category_cubit.dart';
import 'package:disan/features/admin/add_product_and_category/views/widgets/pick_image.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryFormFiels extends StatelessWidget {
  const AddCategoryFormFiels({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCategoryCubit, AddCategoryState>(
      builder: (context, state) {
        var cubit = context.read<AddCategoryCubit>();
        return SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.height * 0.03),
                CustomTextFormFieldWithTitle(
                  hintText:LocaleKeys.enter_category_name.tr(), // "enter category name",
                  title:LocaleKeys.category_name.tr(), // "Category Name",
                  controller: cubit.nameController,
                ),
                SizedBox(height: SizeConfig.height * 0.015),
                CustomTextFormFieldWithTitle(
                  hintText:LocaleKeys.enter_category_description.tr(), // "enter category description",
                  title:LocaleKeys.category_description.tr(), // "Category Description",
                  controller: cubit.descriptionController,
                ),
                SizedBox(height: SizeConfig.height * 0.015),
                Text( LocaleKeys.category_images.tr(), style: AppTextStyles.title18BlackBold),
                SizedBox(height: SizeConfig.height * 0.015),
                PickImage(
                  imageFile: cubit.categoryImage,
                  onPickImage: () => cubit.pickCategoryImage(),
                ),
                SizedBox(height: SizeConfig.height * 0.04),
                state is AddCategoryLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      )
                    : CustomElevatedButton(
                        name:LocaleKeys.add_category.tr(), 
                        onPressed: () {
                          cubit.addCategory();
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
