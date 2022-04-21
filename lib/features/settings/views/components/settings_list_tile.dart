import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    Key? key,
    required this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: leading,
          title: title,
          trailing: trailing ?? const Icon(FeatherIcons.arrowRight),
        ),
        const Divider(),
      ],
    );
  }
}
