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
  required int totalPrice,
  required int approveAmount,
}) async {
  final fontBytes =
      await rootBundle.load('assets/fonts/NotoSansKhmer-Regular.ttf');
  final fontBase64 = base64.encode(fontBytes.buffer.asUint8List());

  return '''
  <div id="pdfContent">
    <html>
    <head>
                    <meta charset="utf-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />              
                    <meta http-equiv="cache-control" content="max-age=0"/>
                    <meta http-equiv="cache-control" content="no-cache"/>
                    <meta http-equiv="expires" content="0"/>
                    <meta http-equiv="pragma" content="no-cache"/>
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link href="https://fonts.googleapis.com/css2?family=Battambang&family=Moul&display=swap" rel="stylesheet">
                    <style type="text/css" media="all">
                        @page {
                            margin: 15px; 
                        }
                        * { -webkit-print-color-adjust: exact !important; /* Chrome, Safari */ color-adjust: exact !important; /*Firefox*/ }
                        body { 
							color: #000; 
							font-family: "Battambang", "Khmer OS Battambang";
							font-size: 14px;
							line-height: 1.42857143;
							margin: 0 5px;
						}
						p {
							margin:5px 0;
						}
						.text-right {
							text-align: right;
                            padding-right: 10px !important;
						}
                        #wrapper { margin: 0 auto; padding-top: 20px; }
                        .btn { margin-bottom: 5px; }
                        .table { border-radius: 3px; width:100%; border-collapse: collapse; margin-bottom:-10px;}
                        thead.mythead, tr.mythead {color:#000; }
                        tr.mythead, tr.mytotal {color:#000 !important;}
                        tr.mythead th, tr.mytotal th {color:#000 !important;}
                        tr.mytotal th {font-size: 14px;}
                        tr.mythead th.text-right {padding-right:10px !important;}
						thead.mythead th { padding:10px 0; color:#000 !important;}
						tfoot.mytfoot { border-top: 1px solid #000;}
                        .table th, .table td { vertical-align: middle !important; padding:5px; border:1px solid;}
                        h3 { margin: 5px 0; }
                        
						a {
							text-decoration: none;
							color: #fff;
						}
						.btn-primary {
							background-color: #3c8dbc;
							border-color: #367fa9;
						}
						.btn-success {
							background-color: #00a65a;
							border-color: #008d4c;
						}
						.btn-warning {
							background-color: #f39c12;
							border-color: #e08e0b;
						}
						.btn-block {
							display: block;
							width: 100%;
						}
						.btn-primary {
							color: #fff;
						}
						.btn {
							border-radius: 3px;
                            font-family: "Battambang", "Khmer OS Battambang";
							margin-bottom: 5px;
							-webkit-box-shadow: none;
							box-shadow: none;
							border: 0px solid transparent;
							display: inline-block;
							padding: 6px 0;
							margin-bottom: 0;
							font-size: 14px;
							font-weight: 400;
							line-height: 1.42857143;
							text-align: center;
							white-space: nowrap;
							-ms-touch-action: manipulation;
							touch-action: manipulation;
							cursor: pointer;
							-webkit-user-select: none;
							-moz-user-select: none;
							-ms-user-select: none;
							user-select: none;
							margin-bottom: 5px;
						}
						.well-sm {
							padding: 5px;
							border-radius: 3px;
						}
						.well {
							min-height: 20px;
							border: 1px solid #000;
							border-radius: 4px;
							-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
							box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
						}
						.alert-success {
							background-color: #00a65a!important;
							border-color: #008d4c!important;
						}
						.alert, .callout {
							border-radius: 3px;
						}
						.alert {
							padding: 15px;
							border: 1px solid transparent;
						}
						.alert, .thumbnail {
							margin-bottom: 20px;
						}
						.alert .close {
							color: #000;
							opacity: .2;
							filter: alpha(opacity=20);
						}
						button.close {
							-webkit-appearance: none;
							padding: 0;
							cursor: pointer;
							background: 0 0;
							border: 0;
						}
						.close {
							float: right;
							font-size: 21px;
							line-height: 1;
							color: #000;
							text-shadow: 0 1px 0 #fff;
							filter: alpha(opacity=20);
							opacity: .2;
						}
                        a[href^=tel] {
                            color: inherit;
                            text-decoration: none;
                        }
						.alert .alert-link, .close {
							font-weight: 700;
						}						
                        @media print {
                            .no-print { display: none; }
                            #wrapper { max-width: 700px; min-width: 250px; margin: 0 auto; padding-top:0 !important;}	
                            thead {display: table-header-group;}
                            tfoot {display: table-footer-group;}
                            tr { page-break-inside:avoid; page-break-after:auto; }
                            td { page-break-inside:avoid; page-break-after:auto; }		
                            div#receipt-data {padding-right:0 !important;}			
                        }
                        @media only screen and (max-device-width: 480px) {
                            #wrapper {
                                max-width: 100% !important;
                                margin: 0 auto;
                                padding-top: 10px;
                            }
                            div#receiptData {
                                max-width: 100% !important;
                                margin: 0 auto;
                                padding : 10px;
                            }
                        }
                   
                    </style>
                </head>
<body>

              <div id="wrapper">
                    <div id="receiptData" style="width: auto; max-width: 700px; margin: 0 auto;">                       
                        <div id="receipt-data" style="padding-right:10px;">
                            <div><img src="http://moto.cpos.cc/header.png" alt="" width="100%"></div>
                              <table width="100%">                                 
                                <tr>
                      <b><p style="font-size:20px; font-family:Khmer OS Battambang;text-align:center; color:#282D91">ទិញ លក់ និងបង់រំលស់ម៉ូតូគ្រប់ប្រភេទ</p>
                        <p style="font-size:17px; font-family:Khmer OS Battambang;text-align:center;color:#282D91">ផ្ទះលេខ 268 & 269 ផ្លូវវេងស្រេង ភូមិត្រពាំងថ្លឹង សង្កាត់ចោមចៅ ខណ្ឌពោធ៍សែនជ័យ រាជធានីភ្នំពេញ </p></b>
                                </tr>                                 
       
                                    
                                </table>

                                 <table width="100%" style="font-size:17px; font-family:Khmer OS Battambang;color:#282D91"> 
                          <tr>
                          <td rowspan="3" width="50%"><img src="http://moto.cpos.cc/phone.png" alt="" width="50%"></td>
                          <td><b>វិក្កយបត្រលេខ</b></td>

                          </tr>
                          <tr>
                          <td><b>កាលបរិច្ឆេទ</b></td>

                          </tr>
                                        <tr>

                          <td><b>ពន្ធ  /ស្លាកលេខ</b></td>
                          </tr>
                                  </table>

 <table width="100%" style="font-size:17px; font-family:Khmer OS Battambang;color:#282D91"> 
                     
                                    <tr>
                                        <td width="50%">លក់ជូនអតិថិជន $customerName  
                                        </td>
                                        <td> ភេទ​    អាយុ $customerAge   ឆ្នាំ</td>
                                    </tr>
                                  <tr>
                                       <td>  លេខអត្តសញ្ញាណប័ណ្ណ $customerId    </td>
                                     <td>លេខទូរស័ព្ទ </td>
                                    </tr>
                                      <tr>
                                       <td>អាសយដ្ឋាន $customerAddress</td>
                                    
                                    </tr>
                                      <tr>
                                       <td>ម៉ាក់ម៉ូតូ</td>
                                    <td>ឆ្នាំផលិត</td>
                                    </tr>
                                      <tr>
                                       <td>កំលាំង     </td>
                                     <td>ពណ៍</td>
                                    </tr>
                                      <tr>
                                       <td>លេខតួ </td>
                                     <td>លេខម៉ាស៊ីន</td>
                                    </tr>
                                        
  </table>

  <div style="font-size:14px; font-family:Khmer OS Battambang;color:#282D91">បញ្ជាក់: ទំនីញទិញហើយមិនអាចដូរវិញបានទេ!</div>

<table width="40%" align="right">
<td style="border: 1px solid black;border-radius: 10px;font-size:17px; font-family:Khmer OS Battambang;color:#282D91" bgcolor="#CEEDFB">
<b>&nbsp;&nbsp; តម្លៃសរុប $totalPrice</b>
<hr style="border: 1px solid black">
<b>&nbsp;&nbsp;  អនុម័ត $approveAmount</b>
</td>
</table>

  <table width="100%"  style="font-size:17px; font-family:Khmer OS Battambang;color:#282D91">	
                                    <tr>
                                        <td style="text-align:center;"><b>ហត្ថលេខាអតិថិជន<br>Customer Signature</b>
                                         <br><br><br><br><br>
                                        .....................................
                                        
                                        </td>
                                        <td style="text-align:center;"><b>ត្រាហាងម៉ូតូ<br>Store Stamp</b>
                                          <br><br><br><br><br>
                                        .....................................</td>
                                    </tr>                                
                                   
                                    
                                </table>



        </div>
    </div>
   </div>
</body>
 </html>
    
  ''';
}

void downloadPdf() async {
  final htmlContent = await generateHtmlContent(
      customerName: 'Sovongdy',
      customerAge: '30',
      customerId: '098765432',
      customerAddress: 'PP',
      totalPrice: 2000,
      approveAmount: 1900,
  );

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
    customerName: 'Sovongdy',
    customerAge: '25',
    customerId: '123456789',
    customerAddress: 'Phnom Penh, Cambodia',
    totalPrice: 2000,
    approveAmount: 1900,
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
