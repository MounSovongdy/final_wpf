import 'dart:html' as html;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;

class ReportController extends GetxController {
  Future<void> downloadExcel() async {
    final excel.Workbook workbook = excel.Workbook();
    final excel.Worksheet sheet = workbook.worksheets[0];

    final excel.Style headerStyle = workbook.styles.add('HeaderStyle');
    headerStyle.bold = true;
    headerStyle.fontName = 'Times New Roman';
    headerStyle.hAlign = excel.HAlignType.center;
    headerStyle.borders.all.lineStyle = excel.LineStyle.thin;

    final excel.Style dataStyle = workbook.styles.add('DataStyle');
    dataStyle.fontName = 'Times New Roman';
    dataStyle.hAlign = excel.HAlignType.center;
    dataStyle.borders.all.lineStyle = excel.LineStyle.thin;

    sheet.getRangeByIndex(1, 1).setText('Header 1');
    sheet.getRangeByIndex(1, 2).setText('Header 2');
    sheet.getRangeByIndex(1, 3).setText('Header 3');
    sheet.getRangeByIndex(1, 4).setText('Header 4');
    sheet.getRangeByIndex(1, 5).setText('Header 5');
    sheet.getRangeByIndex(1, 6).setText('Header 6');

    sheet.getRangeByIndex(2, 1).setText('Data 1');
    sheet.getRangeByIndex(2, 2).setText('Data 2');
    sheet.getRangeByIndex(2, 3).setText('Data 3');
    sheet.getRangeByIndex(2, 4).setText('Data 4');
    sheet.getRangeByIndex(2, 5).setText('Data 5');
    sheet.getRangeByIndex(2, 6).setText('Data 6');

    final List<int> bytes = workbook.saveAsStream();
    if (kIsWeb) {
      await _downloadFileWeb(bytes);
    } else {
      await _saveFileLocal(bytes);
    }
  }

  Future<void> _downloadFileWeb(List<int> bytes) async {
    try {
      final blob = html.Blob([bytes],
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", 'booking.xlsx') // Corrected file extension
        ..style.display = "none";
      html.document.body?.append(anchor);
      anchor.click();
      anchor.remove();

      html.Url.revokeObjectUrl(url);
    } catch (e) {
      debugPrint("Error while handling web download: $e");
    }
  }

  Future<void> _saveFileLocal(List<int> bytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/booking.xlsx';

      final File file = File(filePath);
      await file.writeAsBytes(bytes, flush: true);

      await OpenFile.open(filePath);
    } catch (e) {
      debugPrint("Error in local save logic: $e");
    }
  }
}
