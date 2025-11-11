import 'package:manarat_amjad/core/api/api_constants.dart';
import 'package:manarat_amjad/features/products/data/models/response/get_products_by_category_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;



Future<Uint8List> _downloadImage(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.bodyBytes;
  } else {
    throw Exception("فشل تحميل الصورة");
  }
}



Future<void> createPdf({required List<ProductsRelations> products}) async {
  final pdf = pw.Document();

  // تحميل الخط العربي
  final arabicFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Cairo-SemiBold.ttf"));

  List<Uint8List> imageBytesList = [];

  // تحميل الصور
  for (var product in products) {
    try {
      final imageUrl = '${ApiConstants.baseUrlImage}${product.imageCover}';
      final imageBytes = await _downloadImage(imageUrl);
      imageBytesList.add(imageBytes);
    } catch (e) {
      print("⚠️ خطأ في تحميل الصورة: $e");
      imageBytesList.add(Uint8List(0)); // صورة فارغة في حالة الخطأ
    }
  }

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.GridView(
          crossAxisCount: 2, // عرض 2 منتج في كل صف
          crossAxisSpacing: 10, // المسافة بين الأعمدة
          mainAxisSpacing: 10, // المسافة بين الصفوف
          children: List.generate(
            products.length,
                (index) {
              return pw.Container(
                margin: const pw.EdgeInsets.all(6),
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  border: pw.Border.all(color: PdfColors.grey),
                  borderRadius: pw.BorderRadius.circular(12),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    // صورة المنتج
                    pw.Container(
                      width: 80,
                      height: 80,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.rectangle,
                        border: pw.Border.all(color: PdfColors.grey),
                        borderRadius: pw.BorderRadius.circular(8),
                      ),
                      child: imageBytesList[index].isNotEmpty
                          ? pw.Image(pw.MemoryImage(imageBytesList[index]))
                          : pw.Container(),
                    ),
                    pw.SizedBox(height: 8),
                    // اسم المنتج
                    pw.Text(
                      products[index].productName ?? 'منتج غير معروف',
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.SizedBox(height: 4),
                    // وصف المنتج
                    pw.Text(
                      products[index].description ?? 'لا يوجد وصف',
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 10,
                        color: PdfColors.grey700,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.SizedBox(height: 4),
                    // السعر
                    pw.Text(
                      "السعر: ${products[index].productPrice} جنيه",
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    // السعر بعد الخصم
                    pw.Text(
                      "السعر بعد الخصم: ${products[index].productPriceAfterDiscount} جنيه",
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    ),
  );


  final directory = await getApplicationDocumentsDirectory();
  final filePath = "${directory.path}/products.pdf";
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());

  print("✅ PDF تم إنشاؤه بنجاح: $filePath");
  OpenFilex.open(filePath);
}


