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

class HomrScreenSearchBar extends StatelessWidget {
  const HomrScreenSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.03),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.02,
            vertical: SizeConfig.height * 0.015,
          ),
          hintText: LocaleKeys.search_any_product.tr(),
          hintStyle: AppTextStyles.title16White400,
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.white),
          suffixIcon: Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.height * 0.005,
              bottom: SizeConfig.height * 0.005,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: GestureDetector(
                child: Icon(
                  Icons.filter_alt_rounded,
                  color: AppColors.kPrimaryColor.withOpacity(0.5),
                ),
                onTap: () => showToast("Coming soon"),
                //_showFilterBottomSheet(context)
              ),
            ),
          ),
        ),
        onChanged: (value) {
          context.read<GetProductsCubit>().searchProducts(value);
        },
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (bottomSheetContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<GetCategoriesCubit>(),
          ),
          BlocProvider.value(
            value: context.read<GetProductsCubit>(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<GetCategoriesCubit>(),
            ),
            BlocProvider.value(
              value: context.read<GetProductsCubit>(),
            ),
          ],
          child: FilterBottomSheet(),
        ),
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
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

    return  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.03,
            vertical: SizeConfig.height * 0.01,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.height * 0.02),
              Text(
                LocaleKeys.filters.tr(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              SizedBox(height: SizeConfig.height * 0.03),
              Text(
                LocaleKeys.price_range.tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: SizeConfig.height * 0.015),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _minPriceController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.min_price.tr(),
                        prefixIcon:
                            Icon(Icons.monetization_on_outlined, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: SizeConfig.width * 0.03),
                  Expanded(
                    child: TextField(
                      controller: _maxPriceController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.max_price.tr(),
                        prefixIcon:
                            Icon(Icons.monetization_on_outlined, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.height * 0.03),
              Text(
                LocaleKeys.category.tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: SizeConfig.height * 0.015),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: Text(
                  LocaleKeys.select_category.tr(),
                  style: TextStyle(color: Colors.grey[600]),
                ),
                items: categories
                    .map((category) => DropdownMenuItem(
                          value: category.name,
                          child: Text(category.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              SizedBox(height: SizeConfig.height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.resetFilters();
                        _minPriceController.clear();
                        _maxPriceController.clear();
                        setState(() {
                          _selectedCategory = null;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.height * 0.02),
                        elevation: 2,
                      ),
                      child: Text(
                        LocaleKeys.reset.tr(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(width: SizeConfig.width * 0.03),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        double? minPrice = _minPriceController.text.isEmpty
                            ? null
                            : double.tryParse(_minPriceController.text);
                        double? maxPrice = _maxPriceController.text.isEmpty
                            ? null
                            : double.tryParse(_maxPriceController.text);
                        if (minPrice != null &&
                            maxPrice != null &&
                            minPrice > maxPrice) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text(LocaleKeys.invalid_price_range.tr()),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                          return;
                        }
                        cubit.filterByPrice(min: minPrice, max: maxPrice);
                        cubit.filterByCategory(_selectedCategory);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kPrimaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.height * 0.02),
                        elevation: 2,
                      ),
                      child: Text(
                        LocaleKeys.apply.tr(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.height * 0.03),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
    );
  }
}
