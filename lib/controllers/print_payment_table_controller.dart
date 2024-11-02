import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

Future<String> generateHtmlContent() async {

  return '''
  <div id="pdfPaymentTable">
    <html>
    
                    
    </html>
    
  ''';
}

void printPaymentTable() async {

  final htmlContent = await generateHtmlContent();

  final div = html.DivElement()
    ..setInnerHtml(htmlContent, treeSanitizer: html.NodeTreeSanitizer.trusted);
  html.document.body?.append(div);

  try {
    js.context.callMethod('printPaymentTable');
  } catch (e) {
    debugPrint('Error calling printContent: $e');
  }

  await Future.delayed(const Duration(seconds: 1));
  div.remove();
}
