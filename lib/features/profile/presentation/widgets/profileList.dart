import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:flutter/material.dart';


class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var iconColor = ColorManager.primaryColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        onTap: onPress,
        shape: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withAlpha(20),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: iconColor.withAlpha(20),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title,
            style: getSemiBoldStyle(color: textColor?? ColorManager.black, fontSize: 14)
                ),
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withAlpha(20),
                ),
                child: const Icon(Icons.chevron_right_rounded,
                    size: 18.0, color: Colors.grey))
            : null,
      ),
    );
  }
}
