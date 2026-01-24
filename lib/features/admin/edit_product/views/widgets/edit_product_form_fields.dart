import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:disan/core/components/custom_drop_down_button_form_field.dart';
import 'package:disan/core/components/custom_text_form_field.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/edit_product/view_models/cubit/update_product_cubit.dart';

class EditProductFormFields extends StatelessWidget {
  const EditProductFormFields({
    super.key,
    required this.cubit,
  });

  final UpdateProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Name',
            style: AppTextStyles.title18PrimaryColorW500,
          ),
          SizedBox(height: SizeConfig.height * 0.005),
          CustomTextFormField(
            prefixIcon: Icon(
              Icons.label_outlined,
              color: AppColors.kPrimaryColor,
            ),
            controller: cubit.nameController,
            hintText: 'product name',
          ),
          SizedBox(height: SizeConfig.height * 0.015),
          Text(
            'Product Description',
            style: AppTextStyles.title18PrimaryColorW500,
          ),
          SizedBox(height: SizeConfig.height * 0.005),
          CustomTextFormField(
            prefixIcon: Icon(
              Icons.description,
              color: AppColors.kPrimaryColor,
            ),
            controller: cubit.descriptionController,
            hintText: 'product description',
          ),
          SizedBox(height: SizeConfig.height * 0.015),
          Text(
            'Product Price',
            style: AppTextStyles.title18PrimaryColorW500,
          ),
          SizedBox(height: SizeConfig.height * 0.005),
          CustomTextFormField(
            prefixIcon: Icon(
              Icons.label,
              color: AppColors.kPrimaryColor,
            ),
            controller: cubit.priceController,
            hintText: 'product price',
          ),
          SizedBox(height: SizeConfig.height * 0.015),
          Text(
            'Stock',
            style: AppTextStyles.title18PrimaryColorW500,
          ),
          SizedBox(height: SizeConfig.height * 0.005),
          CustomTextFormField(
            prefixIcon: Icon(
              Icons.inventory,
              color: AppColors.kPrimaryColor,
            ),
            controller: cubit.quantityController,
            hintText: 'stock',
          ),
          SizedBox(height: SizeConfig.height * 0.015),
          Text(
            'Category',
            style: AppTextStyles.title18PrimaryColorW500,
          ),
          SizedBox(height: SizeConfig.height * 0.005),
          BlocBuilder<UpdateProductCubit, UpdateProductState>(
              builder: (context, state) {
            return state is GetCategoriesLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomDropDownButtonFormField(
                    userRoles: cubit.categories.map((e) => e.name).toList(),
                    onChanged: (value) {
                      cubit.categoryController.text = value.toString();
                    },
                    hintText: cubit.categoryController.text,
                    fillColor: Colors.grey.shade300,
                  );
          }),
          SizedBox(height: SizeConfig.height * 0.01),
        ],
      ),
    );
  }
}
