import 'package:fada_alhalij_web/core/functions/launch_url.dart';
import 'package:fada_alhalij_web/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustomIconShare extends StatefulWidget {
  const CustomIconShare({
    super.key,
    required this.title,
    required this.urlPreview,
    required this.details,
  });

  final String title;
  final String urlPreview;
  final String details;

  @override
  State<CustomIconShare> createState() => _CustomIconShareState();
}

class _CustomIconShareState extends State<CustomIconShare> {
  bool _isSharing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isSharing = true;
        });

        try {
          await CustomLaunchUrl.launchUrlShareApp(
            title: widget.title,
            urlPreview: widget.urlPreview,
            details: widget.details,
          );
        } catch (e) {
          // ممكن تعرض SnackBar أو رسالة خطأ
        } finally {
          setState(() {
            _isSharing = false;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorManager.primaryColor,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder:
              (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
          child:
              _isSharing
                  ? const SizedBox(
                    key: ValueKey("loading"),
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                  : Icon(
                    key: ValueKey("icon"),
                    size: 20,
                    Icons.share, // استخدم أيقونة المشاركة
                    color: ColorManager.white,
                  ),
        ),
      ),
    );
  }
}
