import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/edit_product/view_models/cubit/update_product_cubit.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';

class PickProductImage extends StatelessWidget {
  const PickProductImage({
    super.key,
    required this.product,
  });

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProductCubit, UpdateProductState>(
      builder: (context, state) {
        var cubit = context.read<UpdateProductCubit>();
        return Stack(
          children: [
            Container(
              height: SizeConfig.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                image: DecorationImage(
                  image: cubit.image != null
                      ? FileImage(cubit.image!)
                      : NetworkImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            state is PickImageLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
            Positioned(
              bottom: SizeConfig.height * 0.01,
              right: SizeConfig.width * 0.01,
              child: CircleAvatar(
                backgroundColor: AppColors.kPrimaryColor,
                child: IconButton(
                  icon: Icon(
                    Icons.upload,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    cubit.pickProductImage();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
