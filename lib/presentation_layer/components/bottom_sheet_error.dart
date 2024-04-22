// import 'package:flutter/material.dart';

// import 'package:quickfood/infra/infra.dart';

// abstract class BottomSheetError {
//   static Future show({
//     required BuildContext context,
//     required String title,
//     String? message,
//     String? actionMessage,
//     bool enableDrag = true,
//     VoidCallback? onAction,
//   }) {
//     return showModalBottomSheet(
//       isScrollControlled: true,
//       enableDrag: enableDrag,
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(
//             16.0,
//           ),
//           topRight: Radius.circular(
//             16.0,
//           ),
//         ),
//       ),
//       builder: (_) => SizedBox(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: 24.height),
//               child: _slider(color: design.neutral600),
//             ),
//             SizedBox(height: 27.height),
//             PathImages.warning(
//               width: 78.23,
//               height: 72,
//             ),
//             SizedBox(height: 16.height),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: design
//                   .h4(
//                     color: design.neutral100,
//                   )
//                   .copyWith(
//                     fontWeight: FontWeight.w700,
//                   ),
//             ),
//             SizedBox(height: 16.height),
//             Text(
//               message != null && message.isNotEmpty
//                   ? message
//                   : 'fail_server'.translate(),
//               textAlign: TextAlign.center,
//               style: design
//                   .paragraphS(
//                     color: design.neutral300,
//                   )
//                   .copyWith(
//                     fontWeight: FontWeight.w400,
//                   ),
//             ),
//             SizedBox(height: 16.height),
//             TBDefaultButton(
//               label: actionMessage != null && actionMessage.isEmpty
//                   ? actionMessage
//                   : 'continue'.translate(),
//               primaryColor: design.secondary300,
//               onPressed: onAction ?? Navigator.of(context).pop,
//             )
//           ],
//         ),
//       ).addPadding(
//         EdgeInsets.only(
//           left: 32.width,
//           right: 32.width,
//           bottom: 40.height,
//         ),
//       ),
//     );
//   }
// }

// Container _slider({required Color color}) {
//   return Container(
//     height: 5,
//     width: 48,
//     decoration: BoxDecoration(
//       color: color,
//       borderRadius: BorderRadius.circular(20),
//     ),
//   );
// }
