import 'dart:async';
import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/components/show_toast.dart';

import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/features/search/cubit/search_cubit_cubit.dart';
import 'package:disan/features/search/cubit/search_cubit_state.dart';
import 'package:disan/features/user/hom/view_models/cubit/get_categories_cubit.dart';
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
    return BlocProvider(
      create: (context) => ProductSearchCubit(),
      child: const _SearchBarBody(),
    );
  }
}

class _SearchBarBody extends StatefulWidget {
  const _SearchBarBody();

  @override
  State<_SearchBarBody> createState() => _SearchBarBodyState();
}

class _SearchBarBodyState extends State<_SearchBarBody> {
  final TextEditingController controller = TextEditingController();
  Timer? debounce;

  @override
  void dispose() {
    controller.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            onChanged: (value) {
              context.read<ProductSearchCubit>().searchProducts(value);
              setState(() {});
            },
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: LocaleKeys.search_any_product.tr(),
              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              prefixIcon: Icon(Icons.search, color: AppColors.kPrimaryColor),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (controller.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        controller.clear();
                        setState(() {});
                      },
                      child: Icon(Icons.close, color: Colors.grey.shade500),
                    ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (sheetContext) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: context.read<ProductSearchCubit>(),
                                  ),
                                  BlocProvider(
                                    create: (_) => GetCategoriesCubit(),
                                  ),
                                ],
                                child: CategoriesFilterSheet(
                                  sheetContext: sheetContext,
                                ),
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.tune_rounded,
                          color: AppColors.kPrimaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<ProductSearchCubit, ProductSearchState>(
          builder: (context, state) {
            if (controller.text.isEmpty) {
              return const SizedBox();
            }

            if (state is ProductSearchLoading) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              );
            }

            if (state is ProductSearchSuccess) {
              final products = state.products;

              if (products.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("No products found"),
                );
              }

              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width * .03,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 10,
                    ),
                  ],
                ),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, i) {
                    final product = products[i];

                    return ListTile(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.pushScreen(
                          RouteNames.productDetailsScreen,
                          arguments: product,
                        );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product['image_url'] ?? '',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 20,
                              ),
                            );
                          },
                        ),
                      ),
                      title: Text(product['name'] ?? ''),
                      subtitle: Text("${product['price'] ?? ''}"),
                    );
                  },
                ),
              );
            }

            if (state is ProductSearchError) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Text(state.message),
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}

class CategoriesFilterSheet extends StatelessWidget {
  final BuildContext sheetContext;

  const CategoriesFilterSheet({super.key, required this.sheetContext});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
      builder: (context, state) {
        if (state is GetCategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final categories = context.read<GetCategoriesCubit>().categories;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: categories.map((cat) {
            return ListTile(
              title: Text(cat.name),
              onTap: () {
                final searchCubit = context.read<ProductSearchCubit>();

                searchCubit.changeCategory(cat.name);
                searchCubit.searchProducts(searchCubit.lastSearchText);

                Navigator.pop(sheetContext);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
