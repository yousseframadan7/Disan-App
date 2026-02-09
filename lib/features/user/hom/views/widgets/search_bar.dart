import 'dart:async';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/hom/view_models/cubit/get_categories_cubit.dart';
import 'package:disan/features/user/hom/view_models/cubit/get_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

/// 🔥 SEARCH BAR
class HomrScreenSearchBar extends StatefulWidget {
  const HomrScreenSearchBar({super.key});

  @override
  State<HomrScreenSearchBar> createState() => _HomrScreenSearchBarState();
}

class _HomrScreenSearchBarState extends State<HomrScreenSearchBar> {
  final TextEditingController controller = TextEditingController();
  Timer? debounce;

  @override
  void dispose() {
    controller.dispose();
    debounce?.cancel();
    super.dispose();
  }

  void onSearchChanged(String value) {
    if (debounce?.isActive ?? false) debounce!.cancel();

    debounce = Timer(const Duration(milliseconds: 400), () {
      context.read<GetProductsCubit>().searchProducts(value);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.width * .03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onSearchChanged,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: LocaleKeys.search_any_product.tr(),
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 14,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),

          /// search icon
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.kPrimaryColor,
          ),

          /// clear + filter
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (controller.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    controller.clear();
                    context.read<GetProductsCubit>().searchProducts('');
                    setState(() {});
                  },
                  child: Icon(Icons.close, color: Colors.grey.shade500),
                ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => showToast('Coming soon'),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.tune_rounded,
                    color: AppColors.kPrimaryColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 OPEN FILTER
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<GetCategoriesCubit>()),
          BlocProvider.value(value: context.read<GetProductsCubit>()),
        ],
        child: const FilterBottomSheet(),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////
/// 🔥 FILTER BOTTOM SHEET
////////////////////////////////////////////////////////////////

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  String? _selectedCategory;

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetProductsCubit>();
    final categories = context.read<GetCategoriesCubit>().categories;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.04,
          vertical: SizeConfig.height * 0.02,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.height * .01),

            /// TITLE
            Text(
              LocaleKeys.filters.tr(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: SizeConfig.height * .03),

            /// PRICE TITLE
            Text(
              LocaleKeys.price_range.tr(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: SizeConfig.height * .015),

            /// PRICE ROW
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.min_price.tr(),
                      prefixIcon:
                          const Icon(Icons.monetization_on_outlined, size: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                  ),
                ),
                SizedBox(width: SizeConfig.width * .03),
                Expanded(
                  child: TextField(
                    controller: _maxPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.max_price.tr(),
                      prefixIcon:
                          const Icon(Icons.monetization_on_outlined, size: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: SizeConfig.height * .03),

            /// CATEGORY
            Text(
              LocaleKeys.category.tr(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: SizeConfig.height * .015),

            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: Text(LocaleKeys.select_category.tr()),
              items: categories
                  .map((c) =>
                      DropdownMenuItem(value: c.name, child: Text(c.name)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedCategory = v),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),

            SizedBox(height: SizeConfig.height * .04),

            /// BUTTONS
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.resetFilters();
                      _minPriceController.clear();
                      _maxPriceController.clear();
                      setState(() => _selectedCategory = null);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.height * .018),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(LocaleKeys.reset.tr()),
                  ),
                ),
                SizedBox(width: SizeConfig.width * .03),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      double? min = _minPriceController.text.isEmpty
                          ? null
                          : double.tryParse(_minPriceController.text);
                      double? max = _maxPriceController.text.isEmpty
                          ? null
                          : double.tryParse(_maxPriceController.text);

                      if (min != null && max != null && min > max) {
                        showToast(LocaleKeys.invalid_price_range.tr());
                        return;
                      }

                      cubit.filterByPrice(min: min, max: max);
                      cubit.filterByCategory(_selectedCategory);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.height * .018),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(LocaleKeys.apply.tr()),
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20),
          ],
        ),
      ),
    );
  }
}
