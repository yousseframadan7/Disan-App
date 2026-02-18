// import 'package:disan/core/components/show_toast.dart';
// import 'package:disan/features/user/hom/views/widgets/title_with_view_all.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:disan/core/utilies/sizes/sized_config.dart';
// import 'package:disan/generated/locale_keys.g.dart';

// class ReviewsListView extends StatelessWidget {
//   const ReviewsListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<String> avatarUrls = [
//       'https://i.pravatar.cc/150?img=1',
//       'https://i.pravatar.cc/150?img=5',
//       'https://i.pravatar.cc/150?img=10',
//       'https://i.pravatar.cc/150?img=15',
//       'https://i.pravatar.cc/150?img=20',
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TitleWithViewAll(
//           title: LocaleKeys.reviews.tr(),
//           onPressed: () {
//             showToast('Coming soon');
//           },
//         ),
//         SizedBox(height: SizeConfig.height * 0.02),
//         SizedBox(
//           height: SizeConfig.height * 0.08,
//           child: ListView.builder(
//             itemCount: avatarUrls.length,
//             padding: EdgeInsets.zero,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: EdgeInsets.only(right: SizeConfig.width * 0.02),
//                 child: CircleAvatar(
//                   radius: SizeConfig.width * 0.08,
//                   backgroundImage: NetworkImage(avatarUrls[index]),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
