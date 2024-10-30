import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

Future<String> generateHtmlContent({
  required String customerName,
  required String customerAge,
  required String customerId,
  required String customerAddress,
  required int totalPrice,
  required int approveAmount,
  required String gender,
  required String tel,
  required String model,
  required String yearProduct,
  required String power,
  required String color,
  required String frameNo,
  required String machinNo,
}) async {
  // final fontBytes =
  //     await rootBundle.load('assets/fonts/NotoSansKhmer-Regular.ttf');
  // final fontBase64 = base64.encode(fontBytes.buffer.asUint8List());

  return '''
  <div id="pdfLeasingInvoice">
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
                                  <br>
                                  <b>
                                    <p style="font-size:18px; font-family:Khmer OS Battambang;text-align:center; color:#282D91">ទិញ លក់ និងបង់រំលស់ម៉ូតូគ្រប់ប្រភេទ</p>
                                    <p style="font-size:18px; font-family:Khmer OS Battambang;text-align:center;color:#282D91">ផ្ទះលេខ 268 & 269 ផ្លូវវេងស្រេង ភូមិត្រពាំងថ្លឹង សង្កាត់ចោមចៅ ខណ្ឌពោធ៍សែនជ័យ រាជធានីភ្នំពេញ </p>
                                  </b>
                                </tr>                                
                              </table>
                              <br>
                          <table width="100%" style="font-size:19px; font-family:Khmer OS Battambang;color:#282D91"> 
                            <tr>
                            <td rowspan="3" width="70%">
                              <img src="http://moto.cpos.cc/phone.png" alt="" width="50%">
                            </td>
                            <td>វិក្កយបត្រលេខ:&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                            <td>កាលបរិច្ឆេទ:&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                            <td>ពន្ធ  /ស្លាកលេខ:&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                          </table>
                          <br><br>

                                  <table width="100%" style="font-size:19px; font-family:Khmer OS Battambang;color:#282D91"> 
                     
                                    <tr>
                                      <td width="50%">លក់ជូនអតិថិជន:&nbsp;&nbsp;&nbsp;$customerName </td>
                                      <td>ភេទ:&nbsp;&nbsp;&nbsp;$gender </td>
                                      <td>អាយុ:&nbsp;&nbsp;&nbsp;$customerAge </td>
                                    </tr>
                                    <td> លេខអត្តសញ្ញាណប័ណ្ណ:&nbsp;&nbsp;&nbsp;$customerId</td>
                                    <td>លេខទូរស័ព្ទ:&nbsp;&nbsp;&nbsp;$tel</td>
                                    </tr>
                                    <tr>
                                      <td>អាសយដ្ឋាន:&nbsp;&nbsp;&nbsp;$customerAddress</td>
                                    </tr>
                                      <tr>
                                       <td>ម៉ាក់ម៉ូតូ:&nbsp;&nbsp;&nbsp;$model</td>
                                    <td>ឆ្នាំផលិត:&nbsp;&nbsp;&nbsp;$yearProduct</td>
                                    </tr>
                                      <tr>
                                       <td>កំលាំង:&nbsp;&nbsp;&nbsp;$power </td>
                                     <td>ពណ៍:&nbsp;&nbsp;&nbsp;$color</td>
                                    </tr>
                                      <tr>
                                       <td>លេខតួ:&nbsp;&nbsp;&nbsp;$frameNo</td>
                                     <td>លេខម៉ាស៊ីន:&nbsp;&nbsp;&nbsp;$machinNo</td>
                                    </tr>
                                        
                                  </table>
                                  <br>

<div style="font-size:17px; font-family:Khmer OS Battambang;color:#282D91">&nbsp;&nbsp;បញ្ជាក់: ទំនីញទិញហើយមិនអាចដូរវិញបានទេ!</div>

                                    <table width="30%" align="right">
                                      <td style="border: 1px solid black;border-radius: 10px;font-size:19px; font-family:Khmer OS Battambang;color:#282D91" bgcolor="#CEEDFB">
                                        <b>&nbsp;&nbsp; តម្លៃសរុប:&nbsp;&nbsp;&nbsp;$totalPrice</b>
                                        <hr style="border: 0.1px solid black">
                                        <b>&nbsp;&nbsp;  អនុម័ត:&nbsp;&nbsp;&nbsp;$approveAmount</b>
                                      </td>
                                    </table>
                                    <table width="100%"  style="font-size:19px; font-family:Khmer OS Battambang;color:#282D91">
                                    <br><br>
                                    <tr>
                                      <td style="text-align:center;"><b>ហត្ថលេខាអតិថិជន<br>Customer Signature</b>
                                         <br><br><br><br><br>
                                      .....................................
                          
                                        </td>
                                        <br>
                                          <td style="text-align:center;"><b>ត្រាហាងម៉ូតូ<br>Store Stamp</b>
                                            <br><br><br><br><br>
                                          .....................................
                                        </td>
                                    </tr>                                   
                                   </table>



        </div>
    </div>
   </div>
</body>
 </html>
    
  ''';
}

void printLeasingInvoice() async {
  final htmlContent = await generateHtmlContent(
    customerName: 'Sovongdy',
    customerAge: '25',
    customerId: '123456789',
    customerAddress: 'Phnom Penh, Cambodia',
    totalPrice: 2000,
    approveAmount: 1900,
    gender: 'Male',
    tel: '011425717',
    model: 'Dream',
    yearProduct: '2024',
    power: '125',
    color: 'white',
    frameNo: '123456543',
    machinNo: '9876543tdvvd',
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
