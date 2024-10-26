import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;
import 'dart:io';


  // Future<Uint8List> generatePdf() async {
  //   final pdf = pw.Document();
  //   final ByteData fontData = await rootBundle.load('assets/fonts/KhmerOS.ttf');
  //   final pw.Font khmerFont = pw.Font.ttf(fontData);
  //
  //   // Add a page to the PDF document
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) => pw.Column(
  //         children: [
  //           pw.Center(
  //             child: pw.Column(
  //               children: [
  //                 pw.Container(
  //                   height: 1,
  //                   color: invoiceText, // Ensure invoiceText is defined in your constants
  //                 ),
  //                 pw.Text(
  //                   'ទិញលក់ និង បង់រំលស់ម៉ូតូគ្រប់ប្រភេទ', // Khmer text
  //                   style: pw.TextStyle(
  //                       font: khmerFont, color: invoiceText
  //                   ),
  //                 ),
  //                 pw.SizedBox(height: 30),
  //                 pw.Row(
  //                   children: [
  //                     pw.Column(
  //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                       children: [
  //                         pw.Text('096 888 3369', style: pw.TextStyle(font: khmerFont, color: invoiceText)),
  //                         pw.Text('097 888 3369', style: pw.TextStyle(font: khmerFont, color: invoiceText)),
  //                         pw.Text('012 888 795', style: pw.TextStyle(font: khmerFont, color: invoiceText)),
  //                       ],
  //                     ),
  //                     pw.Spacer(),
  //                     pw.Column(
  //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                       children: [
  //                         pw.Row(
  //                           children: [
  //                             pw.Text('វិក្កយបត្រលេខ : ', style: pw.TextStyle(font: khmerFont, color: invoiceText)),
  //                             pw.Text('00001', style: pw.TextStyle(font: khmerFont, color: invoiceText)),
  //                           ],
  //                         ),
  //                         pw.Row(
  //                           children: [
  //                             pw.Text('កាលបរិច្ឆទ : ', style: pw.TextStyle(font: khmerFont, color: invoiceText)),
  //                             pw.Text('25 - 10 - 2024', style: pw.TextStyle(font: khmerFont, color: invoiceText)),
  //                           ],
  //                         ),
  //                         pw.Row(
  //                           children: [
  //                             pw.Text('ពន្ធ/ស្លាកលេខ : ', style: pw.TextStyle(font: khmerFont, color: invoiceText)),
  //                             pw.Text('0001', style: pw.TextStyle(font: khmerFont, color: invoiceText)),
  //                           ],
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //
  //   // Return the generated PDF document as a byte array
  //   return pdf.save();
  // }


// void printPdf(Uint8List pdfData) {
//   if (pdfData == null || pdfData.isEmpty) {
//     print("Error: PDF data is null or empty.");
//     return; // Exit if no valid PDF data
//   }
//
//   final blob = html.Blob([pdfData], 'application/pdf');
//   if (blob == null) {
//     print("Error: Blob creation failed.");
//     return; // Exit if blob creation failed
//   }
//
//   final url = html.Url.createObjectUrlFromBlob(blob);
//   if (url == null) {
//     print("Error: URL creation failed.");
//     return; // Exit if URL creation failed
//   }
//
//   html.AnchorElement(href: url)
//     ..setAttribute('target', '_blank')
//     ..click();
//
//   Future.delayed(
//     const Duration(seconds: 1),
//         () => html.Url.revokeObjectUrl(url),
//   );
// }



Future<Uint8List> generatePDF(BuildContext context) async {
  final pdf = pw.Document();
  final khmerFont = await loadKhmerFont();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("សហគ្រាសម៉ូតូ",
                      style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                          font: khmerFont)),
                  pw.Text("ទូរស័ព្ទ: 096 888 3369",
                      style: pw.TextStyle(font: khmerFont)),
                  pw.Text("អ៊ីមែល: example@company.com",
                      style: pw.TextStyle(font: khmerFont)),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text("វិក្កយបត្រ #0001",
                      style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                          font: khmerFont)),
                  pw.Text("កាលបរិច្ឆេទ: 25-10-2024",
                      style: pw.TextStyle(font: khmerFont)),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          // Additional content...
          pw.Text("នេះគឺជាសេចក្តីអធិប្បាយ", style: pw.TextStyle(font: khmerFont)),
        ],
      ),
    ),
  );

  return pdf.save();
}

Future<pw.Font> loadKhmerFont() async {
    final fontData = await rootBundle.load("assets/fonts/KhmerOS.ttf");
    return pw.Font.ttf(fontData);
}

void savePdfToFile(Uint8List pdfData) async {
  try {
    // Specify the file path where you want to save the PDF
    final directory = Directory.current.path; // Gets the current directory
    final filePath = '$directory/invoice.pdf';

    // Create a new file and write the PDF data to it
    final file = File(filePath);
    await file.writeAsBytes(pdfData);
    print("PDF saved to $filePath");
  } catch (e) {
    print("Error saving PDF: $e");
  }
}
.

