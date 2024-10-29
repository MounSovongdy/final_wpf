// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:html' as html;
import 'dart:js' as js;

Future<String> generateHtmlContent({
  required String customerName,
  required String customerAge,
  required String customerId,
  required String customerAddress,
}) async {
  final fontBytes =
      await rootBundle.load('assets/fonts/NotoSansKhmer-Regular.ttf');
  final fontBase64 = base64.encode(fontBytes.buffer.asUint8List());

  return '''
  <div id="pdfContent">
    <style>
      @font-face {
        font-family: 'NotoSansKhmer';
        src: url(data:font/ttf;base64,$fontBase64) format('truetype');
      }
      body {
        font-family: 'NotoSansKhmer', sans-serif;
        color: #4a4a8c;
      }
      .container {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ddd;
      }
      .header {
        text-align: center;
      }
      .header .shop-name {
        font-size: 24px;
        font-weight: bold;
        color: #4a4a8c;
      }
      .header .tagline {
        font-size: 16px;
        color: #333;
      }
      .contact-info {
        text-align: center;
        margin-top: 10px;
        font-size: 14px;
      }
      .contact-info .phone {
        display: block;
        margin-top: 5px;
      }
      .form-field {
        margin: 15px 0;
        font-size: 14px;
      }
      .form-field label {
        display: inline-block;
        width: 150px;
        font-weight: bold;
      }
      .form-field span {
        display: inline-block;
        width: calc(100% - 160px);
        padding: 5px;
        border-bottom: 1px dotted #4a4a8c;
      }
      .signature-section {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
        text-align: center;
      }
      .signature-box {
        border: 1px solid #4a4a8c;
        padding: 20px;
        width: 45%;
      }
      .signature-box p {
        margin: 0;
        font-size: 14px;
        font-weight: bold;
        color: #4a4a8c;
      }
      .note {
        text-align: center;
        font-size: 12px;
        margin-top: 10px;
        color: #4a4a8c;
      }
    </style>
    <div class="container">
      <div class="header">
        <div class="shop-name">ហាងម៉ូតូ ហេង សុខបញ្ញា</div>
        <div class="tagline">Heng Sok Panha Motor Shop</div>
      </div>
      <div class="contact-info">
        <p>ទីតាំង លេខ 268 & 269...</p>
        <div class="phone">096 711 8000</div>
        <div class="phone">097 711 8000</div>
        <div class="phone">076 711 8000</div>
      </div>
      </div>
      <div class="form-field">
        <label>ឈ្មោះ:</label>
        <span>$customerName</span>
      </div>
      <div class="form-field">
        <label>អាយុ:</label>
        <span>$customerAge</span>
      </div>
      <div class="form-field">
        <label>លេខអត្តសញ្ញាណប័ណ្ណ:</label>
        <span>$customerId</span>
      </div>
      <div class="form-field">
        <label>អាសយដ្ឋាន:</label>
        <span>$customerAddress</span>
      </div>
      <div class="signature-section">
        <div class="signature-box">
          <p>ហត្ថលេខាអតិថិជន</p>
          <p>Customer Signature</p>
        </div>
        <div class="signature-box">
          <p>ហត្ថលេខាហាង</p>
          <p>Store Stamp</p>
        </div>
      </div>
      <div class="note">
        <p>ចំណាំ៖ សូមអនុវត្តតាមកិច្ចសន្យានេះយ៉ាងម៉្មត់ចត់!</p>
      </div>
    </div>
  </div>
  ''';
}

void downloadPdf() async {
  final htmlContent = await generateHtmlContent(
      customerName: 'Sovongdy',
      customerAge: '30',
      customerId: '098765432',
      customerAddress: 'PP');

  final div = html.DivElement()
    ..setInnerHtml(htmlContent, treeSanitizer: html.NodeTreeSanitizer.trusted);
  html.document.body?.append(div);

  try {
    js.context.callMethod('downloadPDF');
  } catch (e) {
    debugPrint('Error calling downloadPDF: $e');
  }

  div.remove();
}

void printPdf() async {
  final htmlContent = await generateHtmlContent(
    customerName: 'Customer Name',
    customerAge: '25',
    customerId: '123456789',
    customerAddress: 'Phnom Penh, Cambodia',
  );

  final div = html.DivElement()
    ..setInnerHtml(htmlContent, treeSanitizer: html.NodeTreeSanitizer.trusted);
  html.document.body?.append(div);

  try {
    js.context.callMethod('printContent');
  } catch (e) {
    debugPrint('Error calling printContent: $e');
  }

  await Future.delayed(const Duration(seconds: 1));
  div.remove();
}
