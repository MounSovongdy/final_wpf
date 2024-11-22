import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:motor/constants/firebase.dart';

Future<String> generateHtmlContent({
  required String invoiceNum,
  required String invoiceDate,
  required String plateNo,
  required String customerName,
  required String customerAge,
  required String customerId,
  required String customerAddress,
  required String totalPrice,
  required String gender,
  required String tel,
  required String model,
  required String yearProduct,
  required String power,
  required String color,
  required String frameNo,
  required String machinNo,
}) async {
  
  return '''
  <div id="pdfCashInvoice">
  <html lang="en">
  <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta http-equiv="cache-control" content="no-cache">
      <meta http-equiv="expires" content="0">
      <meta http-equiv="pragma" content="no-cache">
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Battambang&family=Moul&display=swap" rel="stylesheet">
      
      <style type="text/css" media="all">
          @page {
              margin: 15px;
          }
          body {
              color: #000;
              font-family: "Battambang", "Khmer OS Battambang", sans-serif;
              font-size: 14px;
              line-height: 1.4;
              margin: 0;
              padding: 5px;
          }
          p {
              margin: 5px 0;
          }
          .text-center { text-align: center; }
          .text-right { text-align: right; padding-right: 10px; }
          
          #wrapper {
              margin: 0 auto;
              max-width: 700px;
          }

          .table {
              width: 100%;
              border-collapse: collapse;
              margin-bottom: 10px;
          }
          .table th, .table td {
              padding: 5px;
              font-size: 17px;
              text-align: left;
              color: #282D91;
          }
          .header-text {
              font-size: 19px;
              color: #282D91;
          }
          .sub-header-text {
              font-size: 18px;
              color: #282D91;
          }
          .well {
              padding: 10px;
              background-color: #CEEDFB;
              color: #282D91;
              text-align: right;
              border-radius: 4px;
          }
          
          /* Print-specific styles */
          @media print {
              .no-print { display: none; }
              #wrapper {
                  margin: 0 auto;
                  padding: 0;
              }
              .text-right { text-align: right; }
              .well { color: #282D91; font-size: 15px; }
          }

          .table .text-right {
            text-align: right;
          }
      </style>
  </head>

  <body>
      <div id="wrapper">
          <div id="receiptData" style="margin: 0 auto; text-align: center;">
          <br>
              <!-- Header Image -->
              <div><img src="http://moto.cpos.cc/header.png" alt="Header Image" style="width: 100%;"></div>
              <br>
            <table width="100%" border-spacing: 0; >                                 
                                <tr>
                      <b><p style="font-size:23px;text-align:center; color:#282D91">ទិញ លក់ និងបង់រំលស់ម៉ូតូគ្រប់ប្រភេទ</p>
                        <p style="font-size:19px;text-align:center;color:#282D91">ផ្ទះលេខ 268 & 269 ផ្លូវវេងស្រេង ភូមិត្រពាំងថ្លឹង សង្កាត់ចោមចៅ ខណ្ឌពោធិ៍សែនជ័យ រាជធានីភ្នំពេញ </p></b>
                                </tr>                                 
                                </table>

                                <br>

                                 <table width="100%" style="font-size:17px;color:#282D91"> 
                                    <tr>
                                    <td rowspan="3" width="65%"><img src="http://moto.cpos.cc/phone.png" alt="" width="50%"></td>
                                    <td>វិក្កយបត្រលេខ :  <b>$invoiceNum</b></td>
                                    </tr>
                                    <tr>
                                    <td>កាលបរិច្ឆេទ :  <b>$invoiceDate</b></td>
                                    </tr>
                                    <tr>
                                    <td>ពន្ធ/ស្លាកលេខ : <b>$plateNo</b></td>
                                    </tr>
                                  </table>

                                  <br>

              <!-- Customer Information -->
              <br>
              <table class="table" border-spacing: 0;>
                  <tr>
                      <td>លក់ជូនអតិថិជន : <b>$customerName</td>
                      <td>ភេទ : <b>$gender</td>
                      <td>អាយុ : <b>$customerAge</b> ឆ្នាំ</td>
                  </tr>
                  <tr>
                      <td>លេខអត្តសញ្ញាណប័ណ្ណ : <b>$customerId</td>
                      <td>លេខទូរស័ព្ទ : <b>$tel</td>
                  </tr>
                  <tr>
                      <td colspan="3">អាសយដ្ឋាន : <b>$customerAddress</td>
                  </tr>
                  <tr>
                      <td>ម៉ាកម៉ូតូ : <b>$model</td>
                      <td>ឆ្នាំផលិត : <b>$yearProduct</td>
                  </tr>
                  <tr>
                      <td>កំលាំង : <b>$power cc</td>
                      <td>ពណ៍ : <b>$color</td>
                  </tr>
                  <tr>
                      <td>លេខតួ : <b>$frameNo</td>
                      <td>លេខម៉ាស៊ីន : <b>$machinNo</td>
                  </tr>
              </table>

              <table class="table">
                <tr>
                    <td><b>បញ្ជាក់:</b> ទំនិញទិញហើយមិនអាចដូរវិញបានទេ! </td>
                </tr>
              </table>

              <table width="100%"; margin: auto;">
                <tr>
                  <td width = "70%"></td>
                  <td width="30%"; style="border: 0.5px solid black; border-radius: 10px; font-size: 17px;color: #282D91; background-color: #CEEDFB; text-align: center; vertical-align: middle; height: 40px;"> តម្លៃសរុប : <b>&nbsp;&nbsp;&nbsp;$totalPrice\$</b></td>
                </tr>
              </table>
              <br>
              <!-- Signatures -->
              <table width="100%" class="table">
                  <tr>
                      <td class="text-center">ហត្ថលេខាអតិថិជន<br>Customer Signature</td>
                      <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      </td>
                      <td class="text-center">ត្រាហាងម៉ូតូ<br>Store Stamp</td>
                  </tr>
                  <tr>
                    <td><br></td>
                    <td><br></td>
                  </tr>
                  <tr>
                    <td><br></td>
                    <td><br></td>
                  </tr>
                  <tr>
                      <td class="text-center">............................</td>
                      <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      </td>
                      <td class="text-center">............................</td>
                  </tr>
              </table>
          </div>
      </div>
  </body>
</html>
    
  ''';
}

void printCashInvoice(int id) async {
  await getByCash(id);

  final htmlContent = await generateHtmlContent(
    invoiceNum: '${byCash[0].id}',
    invoiceDate: byCash[0].date,
    plateNo: byCash[0].plateNo == '' ? 'ក្រដាសពន្ធ' : byCash[0].plateNo,
    customerName: byCash[0].name,
    customerAge: byCash[0].age,
    customerId: byCash[0].idCard,
    customerAddress: byCash[0].address,
    totalPrice: byCash[0].price,
    gender: byCash[0].gender,
    tel: byCash[0].tel,
    model: byCash[0].model,
    yearProduct: byCash[0].year,
    power: byCash[0].power,
    color: byCash[0].color,
    frameNo: byCash[0].frameNo,
    machinNo: byCash[0].engineNo,
  );

  final div = html.DivElement()
    ..setInnerHtml(htmlContent, treeSanitizer: html.NodeTreeSanitizer.trusted);
  html.document.body?.append(div);

  try {
    js.context.callMethod('printContent1');
  } catch (e) {
    debugPrint('Error calling printContent1: $e');
  }

  await Future.delayed(const Duration(seconds: 1));
  div.remove();
}
