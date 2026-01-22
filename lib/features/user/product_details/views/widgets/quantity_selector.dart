import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/product_details/view_model/cubit/add_to_cart_cubit.dart';
import 'package:disan/features/user/product_details/views/widgets/custom_vertical_divider.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.height * 0.02),
        child: BlocBuilder<AddToCartCubit, AddToCartState>(
          buildWhen: (previous, current) => current is UpdateQuantity,
          builder: (context, state) {
            var cubit = context.read<AddToCartCubit>();
            return Container(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.02),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: cubit.quantity > 1
                        ? () => cubit.decreaseQuantity()
                        : null,
                    icon: Icon(
                      Icons.remove,
                      size: SizeConfig.width * 0.05,
                      color: Colors.white,
                    ),
                    constraints: BoxConstraints(
                      minWidth: SizeConfig.width * 0.1,
                      minHeight: SizeConfig.width * 0.1,
                    ),
                  ),
                  CustomVerticalDivider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width * 0.04),
                    child: Text(
                      cubit.quantity.toString(),
                      style: TextStyle(
                        fontSize: SizeConfig.width * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CustomVerticalDivider(),
                  IconButton(
                    onPressed: () => cubit.increaseQuantity(),
                    icon: Icon(
                      Icons.add,
                      size: SizeConfig.width * 0.05,
                      color: Colors.white,
                    ),
                    constraints: BoxConstraints(
                      minWidth: SizeConfig.width * 0.1,
                      minHeight: SizeConfig.width * 0.1,
                    ),
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
