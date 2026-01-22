import 'package:disan/core/helper/date_picker.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/customer_requests/models/customer_request_model.dart';
import 'package:disan/features/user/my_orders/views/widgets/status_ribbon_painter.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final CustomerRequestModel order;
  const OrderCard({super.key, required this.order});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.green;
      case 'delivered':
        return Colors.blueAccent;
      case 'shipped':
        return Colors.lightGreenAccent;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    order.orders!.first.product!.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: Icon(Icons.broken_image,
                          size: SizeConfig.width * 0.1),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width * 0.02,
                  vertical: SizeConfig.height * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order.totalAmount.toInt()} ${LocaleKeys.items.tr()}',
                      style: AppTextStyles.title16BlackBold,
                    ),
                    SizedBox(height: SizeConfig.height * 0.005),
                    Text(
                      "From: ${order.orders!.first.product!.shopName}",style: AppTextStyles.title14Black38,
                    ),
                    SizedBox(height: SizeConfig.height * 0.005),
                    Text(
                      DateHelper.formatDate(DateTime.parse(order.createdAt!)),
                      style: AppTextStyles.title12GreyShade600,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: SizeConfig.height * 0.005,
            left: SizeConfig.width * 0.01,
            child: CustomPaint(
              size: Size(SizeConfig.width * 0.35, SizeConfig.height * 0.05),
              painter: StatusRibbonPainter(
                text: order.status!,
                color: _getStatusColor(order.status!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
