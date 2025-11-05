
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint, Uint8List;
import 'package:fada_alhalij_web/core/api/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class CustomLaunchUrl {
  static Future<void> launchUrlShare({
    required String title,
    required String urlPreview,
    String? details,
    String? phone,
  }) async {
    try {
      // بناء رابط الصورة
      Uri url = Uri.parse('${ApiConstants.baseUrlImage}$urlPreview');

      // تحميل الصورة من الرابط
      var response = await http.get(url);

      // مشاركة الصورة مع النصوص
      await Share.shareXFiles(
        [
          XFile.fromData(
            response.bodyBytes,
            name: title,
            mimeType: 'image/png',
          ),
        ],
        subject: 'منارة أمجاد - ${title.trim()}',
        text: '''
         ---------------         
         
        📌 ${title.trim()}
          
          📄 التفاصيل:
          $details
          
          📞 للتواصل: -----------
          
                   ---------------         
          
          🌐 https://manarat-amjad.artawiya.com/
      
      تطبيق منارة أمجاد
            ''',
        sharePositionOrigin: Rect.fromCircle(
          center: Offset(10, 10),
          radius: 20,
        ),
      );
    } catch (e) {
      print('Error while sharing: $e');
    }
  }
  static Future<void> launchUrlShareWeb({
    required String title,
    required String urlPreview,
    String? details,
    String? phone,
  }) async {

    if (title.trim().isEmpty || urlPreview.trim().isEmpty) {
      debugPrint('⚠️ تحذير: بيانات مفقودة');
      return;
    }

    final String imageUrl = urlPreview.startsWith('http')
        ? urlPreview
        : '${ApiConstants.baseUrlImage}$urlPreview';

    try {
      if (kIsWeb) {
        await _shareOnWeb(title, details, phone);
      } else {
        await _shareOnMobile(title, imageUrl, details, phone);
      }
    } catch (error) {
      debugPrint('❌ خطأ: $error');
    }
  }

/* ═══════════════════════════════════════════════════════════════════
   🎯 الجمل التسويقية - اختر ما يناسبك
   ═══════════════════════════════════════════════════════════════════ */



/* ═══════════════════════════════════════════════════════════════════
   🌐 مشاركة على الويب
   ═══════════════════════════════════════════════════════════════════ */

  static Future<void> _shareOnWeb(
  String title,
  String? details,
  String? phone,
  ) async {

  final shortLink ='https://manarat-amjad.artawiya.com';

  final content = StringBuffer()
  // العنوان الرئيسي
  ..writeln('✨ $title ✨')
  ..writeln()

  // التفاصيل أو جملة تسويقية
  ..writeln(details?.trim().isNotEmpty ?? false
  ? '📋 ${details!.trim()}'
      : '📋 ${_MarketingPhrases.getRandom(_MarketingPhrases.offers)}')
  ..writeln()

  // جملة تحفيزية
  ..writeln(_MarketingPhrases.getRandom(_MarketingPhrases.callToAction))
  ..writeln();

  if (phone?.trim().isNotEmpty ?? false) {
  content
  ..writeln('📞 للتواصل: ${phone!.trim()}')
  ..writeln();
  }

  content
  ..writeln('━━━━━━━━━━━━━━━━━')
  ..writeln()
  ..writeln('🌟 تطبيق منارة أمجاد')
  ..writeln(_MarketingPhrases.getRandom(_MarketingPhrases.closingLines))
  ..writeln()
  ..writeln('┌─────────────────────┐')
  ..writeln('│  🚀 ادخل التطبيق 🚀 │')
  ..writeln('└─────────────────────┘')
  ..writeln('      ⬇️  ⬇️  ⬇️')
  ..writeln('      $shortLink')
  ..writeln()
  ..writeln('━━━━━━━━━━━━━━━━━');

  await Share.share(content.toString(), subject: title.trim());
  debugPrint('✅ مشاركة ويب ناجحة');
  }

/* ═══════════════════════════════════════════════════════════════════
   📱 مشاركة على الموبايل
   ═══════════════════════════════════════════════════════════════════ */

  static Future<void> _shareOnMobile(
  String title,
  String imageUrl,
  String? details,
  String? phone,
  ) async {

  try {
  final imageData = await _downloadImage(imageUrl);
  final content = await _buildMobileContent(title, details, phone);
  final fileName = _cleanFileName(title);

  await Share.shareXFiles(
  [XFile.fromData(imageData, name: fileName, mimeType: 'image/jpeg')],
  subject: title.trim(),
  text: content,
  sharePositionOrigin: const Rect.fromLTWH(0, 0, 10, 10),
  );

  debugPrint('✅ مشاركة موبايل ناجحة');

  } catch (error) {
  debugPrint('⚠️ فشل تحميل الصورة، المشاركة بالنص فقط');
  final content = await _buildMobileContent(title, details, phone);
  await Share.share(content, subject: title.trim());
  }
  }

/* ═══════════════════════════════════════════════════════════════════
   ✨ بناء المحتوى مع جمل تسويقية
   ═══════════════════════════════════════════════════════════════════ */

  static Future<String> _buildMobileContent(
  String title,
  String? details,
  String? phone,
  ) async {

  final shortLink = await _shortenUrl('https://manarat-amjad.artawiya.com/');

  final content = StringBuffer()
  // رأس جذاب
  ..writeln('╔═══════════════════════════╗')
  ..writeln('║  🌟 منارة أمجاد 🌟   ║')
  ..writeln('║   بقالتك الذكية   ║')
  ..writeln('╚═══════════════════════════╝')
  ..writeln()

  // العنوان
  ..writeln('✨ $title ✨')
  ..writeln()

  // التفاصيل أو جملة تسويقية
  ..writeln(details?.trim().isNotEmpty ?? false
  ? '📋 ${details!.trim()}'
      : '📋 ${_MarketingPhrases.getRandom(_MarketingPhrases.offers)}')
  ..writeln()

  // جملة تحفيزية إضافية
  ..writeln('⚡ ${_MarketingPhrases.getRandom(_MarketingPhrases.callToAction)}')
  ..writeln();

  if (phone?.trim().isNotEmpty ?? false) {
  content
  ..writeln('📞 للتواصل: ${phone!.trim()}')
  ..writeln();
  }

  content
  // دعوة للعمل
  ..writeln()
  ..writeln('╔═══════════════════════════╗')
  ..writeln('║  👇 اضغط للدخول 👇    ║')
  ..writeln('╚═══════════════════════════╝')
  ..writeln()
  ..writeln('       🔗 $shortLink')
  ..writeln()

  // جملة ختامية جذابة
  ..writeln(_MarketingPhrases.getRandom(_MarketingPhrases.closingLines))
  ..writeln()
  ..writeln('━━━━━━━━━━━━━━━━━━━━━━━━━');

  return content.toString();
  }

/* ═══════════════════════════════════════════════════════════════════
   🔗 اختصار الرابط
   ═══════════════════════════════════════════════════════════════════ */

  static Future<String> _shortenUrl(String longUrl) async {
  try {
  final response = await http.get(
  Uri.parse('https://tinyurl.com/api-create.php?url=$longUrl'),
  ).timeout(const Duration(seconds: 10));

  if (response.statusCode == 200 && response.body.isNotEmpty) {
  return response.body.replaceAll('https://', '').replaceAll('http://', '');
  }
  } catch (e) {
  debugPrint('⚠️ فشل اختصار الرابط: $e');
  }

  return 'manarat-amjad.com';
  }

/* ═══════════════════════════════════════════════════════════════════
   📥 تحميل الصورة
   ═══════════════════════════════════════════════════════════════════ */

  static Future<Uint8List> _downloadImage(String url) async {
  final response = await http.get(
  Uri.parse(url),
  headers: {'User-Agent': 'ManaratAmjad/1.0'},
  ).timeout(const Duration(seconds: 30));

  if (response.statusCode != 200) {
  throw HttpException('فشل التحميل (${response.statusCode})');
  }

  return response.bodyBytes;
  }

/* ═══════════════════════════════════════════════════════════════════
   🧹 تنظيف اسم الملف
   ═══════════════════════════════════════════════════════════════════ */

  static String _cleanFileName(String name) {
  return name
      .trim()
      .replaceAll(RegExp(r'[^\w\s\u0600-\u06FF-]'), '')
      .replaceAll(RegExp(r'\s+'), '_')
      .substring(0, name.length > 50 ? 50 : name.length);
  }






  static Future<void> launchUrlShareApp({
    required String title,
    required String urlPreview,
    String? details,
    String? phone,
  }) async {
    final String shareText = '''

📌 ${title.trim()}

📄 التفاصيل:
$details

📞 للتواصل: $phone
            ⚡💯💯💯💯💯💯💯⚡
🌐 https://manarat-amjad.artawiya.com/
           ⚡💯💯💯💯💯💯💯⚡

      ''';

    if (kIsWeb) {
      // مشاركة النصوص والرابط فقط على الويب
      await Share.share(shareText);
    } else {
      try {
        // بناء رابط الصورة
        Uri url = Uri.parse('${ApiConstants.baseUrlImage}$urlPreview');

        // تحميل الصورة
        var response = await http.get(url);

        // مشاركة الصورة مع النصوص على المنصات الأخرى
        await Share.shareXFiles(
          [
            XFile.fromData(
              response.bodyBytes,
              name: title,
              mimeType: 'image/png',
            ),
          ],
          subject: 'منارة أمجاد - ${title.trim()}',
          text: shareText,
          sharePositionOrigin: Rect.fromCircle(
            center: Offset(10, 10),
            radius: 20,
          ),
        );
      } catch (e) {
      throw('Error while sharing: $e');
      }
    }
  }









}
class _MarketingPhrases {

  // 🔥 جمل العنوان الرئيسية (غيّر حسب المنتج)
  static const List<String> mainTitles = [

    '🏪 منارة أمجاد - بقالتك الذكية على تطبيقك',
    '💫 كل احتياجاتك اليومية بضغطة زر',
    '🎯 تسوق ذكي، أسعار أذكى، توصيل أسرع',
    '✨ بقالة منارة أمجاد - جودة تثق بها',
  ];

  // 🎁 جمل العروض والمميزات
  static const List<String> offers = [
    '🎁 عروض يومية حصرية على التطبيق',
    '⚡ توصيل سريع في نفس اليوم',
    '💰 أسعار تنافسية على جميع المنتجات',
    '🚀 اطلب الآن واستلم باسرع وقت',
    '✨ منتجات طازجة وجودة مضمونة',
    '🏆 أفضل الأسعار في المنطقة',
    '💯 آلاف المنتجات بين يديك',
  ];

  // 🔥 جمل تحفيزية للشراء
  static const List<String> callToAction = [
    '🛍️ اطلب الآن ووفر وقتك',
    '📱 ادخل التطبيق وابدأ التسوق',
    '🎯 جرب التسوق الذكي اليوم',
    '⚡ لا تفوت العروض الحصرية',
  ];

  // ✨ جمل نهاية جذابة
  static const List<String> closingLines = [
    'منارة أمجاد - وجهتك للتسوق الذكي 🌟',
    'احتياجاتك كلها في مكان واحد 🛒',
    'نصلك أينما كنت، في أي وقت ⏰',
    'جودة عالية، أسعار منافسة، خدمة ممتازة 💯',
    'تسوق بثقة مع منارة أمجاد ✨',
  ];

  // 📝 دالة للحصول على جملة عشوائية
  static String getRandom(List<String> list) {
    return list[(DateTime.now().millisecondsSinceEpoch % list.length)];
  }
}