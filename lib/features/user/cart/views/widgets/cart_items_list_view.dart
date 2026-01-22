import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/cart/view_models/cubit/order_product_cubit.dart';
import 'package:disan/features/user/cart/views/widgets/cart_order_card.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';

class CartItemsListView extends StatelessWidget {
  const CartItemsListView({
    super.key,
    required this.cubit,
  });

  final OrderProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cubit.carts.length,
      itemBuilder: (context, index) {
        var cart = cubit.carts[index];
        return Dismissible(
          key: Key(cart.product.id.toString()),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(LocaleKeys.delete_product.tr()),
                content: Text(LocaleKeys.delete_product.tr()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(LocaleKeys.cancel.tr()),
                  ),
                  TextButton(
                    onPressed: () {
                      cubit.deleteProduct(id: cart.product.id);
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      LocaleKeys.delete_product.tr(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
          onDismissed: (direction) {
            cubit.deleteProduct(id: cart.product.id);
            quickAlert(
              type: QuickAlertType.success,
              text: LocaleKeys.success.tr(),
              title: LocaleKeys.success.tr(),
            );
          },
          background: Container(
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16,
                ),
                color: Colors.red),
            padding: EdgeInsets.only(right: SizeConfig.width * 0.05),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: SizeConfig.width * 0.07,
            ),
          ),
          child: CartOrderCard(
            cart: cart,
            orderProductCubit: cubit,
          ),
        );
      },
    );
  }
}
