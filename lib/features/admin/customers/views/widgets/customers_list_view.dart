import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/customers/view_models/cubit/get_customers_cubit.dart';
import 'package:disan/features/admin/customers/views/widgets/customer_list_tile.dart';
import 'package:flutter/cupertino.dart';

class CustomerListView extends StatelessWidget {
  const CustomerListView({
    super.key,
    required this.cubit,
  });

  final GetCustomersCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.02,
          vertical: SizeConfig.height * 0.01,
        ),
        itemCount: cubit.customers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: SizeConfig.height * 0.01,
            ),
            child: CustomerListTile(userModel: cubit.customers[index]),
          );
        },
      ),
    );
  }
}

