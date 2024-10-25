import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class OpenPrinterDaiLogController extends GetxController {
  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();
    // final fontData = await rootBundle.load('assets/fonts/Inter-Bold.ttf');
    // final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Container(
              width: 1,
            ),
            pw.Text('ទិញ លក់ និង បង់រំលស់ម៉ូតូគ្រប់ប្រភេទ'),
            // pw.Text('Invoice', style: const pw.TextStyle(fontSize: 30)),
            // pw.SizedBox(height: 20),
            // pw.Text('HSP Motor Shop'),
            // pw.SizedBox(height: 20),
            // pw.Text('Invoice Number: 001'),
            // pw.Text('Date: ${DateTime.now().toLocal()}'),
            // pw.SizedBox(height: 20),
            // pw.Text('Customer Name: John Doe'),
            // pw.Text('Address: 123 Main St.'),
            // pw.Text('Phone: 123-456-7890'),
            // pw.SizedBox(height: 20),
            // pw.Divider(),
            // pw.Text('Items:'),
            // pw.Row(
            //   children: [
            //     pw.Text('Vehicle Model:'),
            //     pw.SizedBox(width: 10),
            //     pw.Text('Motorbike XYZ'),
            //   ],
            // ),
            // pw.Row(
            //   children: [
            //     pw.Text('Price:'),
            //     pw.SizedBox(width: 10),
            //     pw.Text('\$1000'),
            //   ],
            // ),
            // pw.SizedBox(height: 20),
            // pw.Divider(),
            // pw.Text('Thank you for your business!'),
          ],
        ),
      ),
    );
    return pdf.save();
  }

  void printPdf(Uint8List pdfData) {
    final blob = html.Blob([pdfData], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute('target', '_blank')
      ..click();

    Future.delayed(
      const Duration(seconds: 1),
      () => html.Url.revokeObjectUrl(url),
    );
  }
}
