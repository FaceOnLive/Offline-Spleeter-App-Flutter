// import 'package:flutter/material.dart';
// import 'package:sleek_circular_slider/sleek_circular_slider.dart';

// import '../../../../core/constants/constants.dart';

// class ModifersSlider extends StatelessWidget {
//   const ModifersSlider({
//     Key? key,
//     required this.label,
//     required this.icon,
//     required this.onChange,
//     this.initialValue = 50,
//   }) : super(key: key);

//   final String label;
//   final IconData icon;
//   final Function(double) onChange;
//   final double initialValue;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SleekCircularSlider(
//           appearance: CircularSliderAppearance(
//             customColors: CustomSliderColors(
//               progressBarColor: AppColors.primary,
//               trackColor: AppColors.primary.withOpacity(0.3),
//             ),
//           ),
//           onChange: onChange,
//           initialValue: initialValue,
//         ),
//         Row(
//           children: [
//             Icon(
//               icon,
//               size: 16,
//             ),
//             AppUiBox.w10,
//             Text(label),
//           ],
//         )
//       ],
//     );
//   }
// }
