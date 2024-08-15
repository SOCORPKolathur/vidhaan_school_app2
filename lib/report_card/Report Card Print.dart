
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;


Future<Uint8List> generateProgressReportPdf(PdfPageFormat pageFormat,List<ExamWithSubjectModel> exams,Map<String,dynamic> student,String schoolName,String schAddress,String schlLogo) async {

  print("S2");
  final attendance = FeesModelforPdfPrint(
      accentColor: PdfColors.pink,
      baseColor: PdfColors.purple900,
      customerAddress: '',
      customerName: '',
      invoiceNumber: '',
      paymentInfo: '',
      tax: 1,
      title: "Attendance",
      exams: exams,
      products: [],
      schlAddress: schAddress,
      schlLogo: schlLogo,
      schlName: schoolName,
      student: student
  );

  return await attendance.buildPdf(pageFormat);
}

class FeesModelforPdfPrint{

  FeesModelforPdfPrint(
      {
        required this.schlAddress, required this.schlLogo, required this.schlName, required this.student,required this.products,required this.customerName, required this.customerAddress,required  this.invoiceNumber,required  this.tax,required  this.paymentInfo,required  this.baseColor,required  this.accentColor, required this.title, required this.exams});
  String? title;
  List<ExamWithSubjectModel> exams;

  final String customerName;
  final List products;
  final String customerAddress;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final String schlName;
  final String schlLogo;
  final String schlAddress;
  final PdfColor baseColor;
  final PdfColor accentColor;
  final Map<String,dynamic> student;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;






  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    print("S3");
    final studentImage = await networkImage(student['imgurl']);
    final schoolLogoUrl = await networkImage(schlLogo);



    final doc = pw.Document();
    List<pw.Widget> widgets = [];


    // return doc.save();


    // var fontsemipoppoins = await PdfGoogleFonts.poppinsSemiBold();
//Profile image

    // final Clockimage = p.Image(
    //     await imageFromAssetBundle('assets/Clock Image.png'),
    //     fit: p.BoxFit.contain,
    //     height: 30,
    //     width:30
    //
    //
    // );

    final contentrsss=pw.Column(
        children: [
          pw.Container(
            height: 80,
            width: 600,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                  height: 40,
                  width: 40,
                  child:pw.Image(
                    schoolLogoUrl,
                    height: 40,
                    width:40,
                  ),
                ),
                pw.SizedBox(width: 10),
                pw. Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw. Text(
                      schlName,
                      style:pw.TextStyle(
                          color: PdfColors.black
                      ),
                    ),
                    pw. Text(
                      schlAddress,
                      style:pw. TextStyle(
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
                //pw.SizedBox(width: 100),
              ],
            ),
          ),
          pw.SizedBox(
              height: 20
          ),
          pw.Container(
              height: 100,
              width: 600,
              child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      height: 90,
                      width: 80,
                      decoration: pw.BoxDecoration(
                          border: pw.Border.all()
                      ),
                      //// picture
                      child: pw.Image(studentImage),
                    ),
                    pw.SizedBox(
                      width: 20,
                    ),
                    pw.Container(
                        height: 150,
                        width: 200,
                        child: pw.Column(
                            children: [
                              pw.Row(
                                  children: [
                                    pw.Container(
                                        width: 70,
                                        height: 20,
                                        child: pw.Text(
                                            "Roll No",
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                            )
                                        )
                                    ),
                                    pw.Text(
                                        " : "
                                    ),
                                    pw.Container(
                                        child: pw.Center(
                                            child: pw.Text(
                                                student["regno"],
                                                style: pw.TextStyle(
                                                  fontWeight: pw.FontWeight.normal,
                                                )
                                            )
                                        )
                                    ),
                                  ]
                              ),
                              pw.Row(
                                  children: [
                                    pw.Container(
                                        width: 70,
                                        height: 20,
                                        child: pw.Text(
                                            "Name",
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                            )
                                        )
                                    ),
                                    pw.Text(
                                        " : "
                                    ),
                                    pw.Container(
                                        child: pw.Center(
                                            child: pw.Text(
                                                student["stname"],
                                                style: pw.TextStyle(
                                                  fontWeight: pw.FontWeight.normal,
                                                )
                                            )
                                        )
                                    ),
                                  ]
                              ),
                              pw.Row(
                                  children: [
                                    pw.Container(
                                        width: 70,
                                        height: 20,
                                        child: pw.Text(
                                            "DOB",
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                            )
                                        )
                                    ),
                                    pw.Text(
                                        " : "
                                    ),
                                    pw.Container(
                                        child: pw.Center(
                                            child: pw.Text(
                                                student["dob"],
                                                style: pw.TextStyle(
                                                  fontWeight: pw.FontWeight.normal,
                                                )
                                            )
                                        )
                                    ),
                                  ]
                              ),
                              pw.Row(
                                  children: [
                                    pw.Container(
                                        width: 70,
                                        height: 20,
                                        child: pw.Text(
                                            "Mobile",
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                            )
                                        )
                                    ),
                                    pw.Text(
                                        " : "
                                    ),
                                    pw.Container(
                                        child: pw.Center(
                                            child: pw.Text(
                                                student["mobile"],
                                                style: pw.TextStyle(
                                                  fontWeight: pw.FontWeight.normal,
                                                )
                                            )
                                        )
                                    ),
                                  ]
                              ),
                            ]
                        )
                    ),
                    pw.SizedBox(
                      width: 10,
                    ),
                    pw.Container(
                        width: 200,
                        child: pw.Column(
                            children: [
                              pw.Row(
                                  children: [
                                    pw.Container(
                                        width: 70,
                                        height: 20,
                                        child: pw.Text(
                                            "Father",
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                            )
                                        )
                                    ),
                                    pw.Text(
                                        " : "
                                    ),
                                    pw.Container(
                                        child: pw.Center(
                                            child: pw.Text(
                                                student["fathername"],
                                                style: pw.TextStyle(
                                                  fontWeight: pw.FontWeight.normal,
                                                )
                                            )
                                        )
                                    ),
                                  ]
                              ),
                              pw.Row(
                                  children: [
                                    pw.Container(
                                        width: 70,
                                        height: 20,
                                        child: pw.Text(
                                            "Mother",
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                            )
                                        )
                                    ),
                                    pw.Text(
                                        " : "
                                    ),
                                    pw.Container(
                                      child: pw.Center(
                                          child: pw.Text(
                                              student["mothername"],
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.normal,
                                              )
                                          )
                                      ),
                                    ),
                                  ]
                              ),
                              pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                        width: 70,
                                        height: 30,
                                        child: pw.Text(
                                            "Address",
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                            )
                                        )
                                    ),
                                    pw.SizedBox(
                                      height: 30,
                                      child: pw.Text(
                                          " : "
                                      ),
                                    ),
                                    pw.Container(
                                        width: 100,
                                        height: 30,
                                        child: pw.Center(
                                            child: pw.Text(
                                                student["address"],
                                                style: pw.TextStyle(
                                                  fontWeight: pw.FontWeight.normal,
                                                )
                                            )
                                        )
                                    ),
                                  ]
                              ),
                            ]
                        )
                    ),
                  ]
              )
          ),
          pw.Container(
            width: 600,
            height: 500,
            child: pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 00, vertical: 0),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 10),
                  pw.SizedBox(height: 30),
                  pw.Text(
                    "Exam Reports",
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 30),
                  pw.Row(
                    children: [
                      for(int i = 0; i < exams.length+1; i++)
                        pw.Column(
                          children: [
                            for(int j = 0; j < exams.first.subjects.length+1; j++)
                              j == 0
                                  ? pw.Container(
                                height: j==0 ? 60 : 50,
                             //   width: (i==0 && j==0) ? 100 : i==0 ? 100 : 180,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(),
                                ),
                                child: pw.Column(
                                  children: [
                                    pw.Container(
                                      height: (i == 0 && j == 0) ? 58 : 30,
                                      //padding: pw.EdgeInsets.all(2),
                                      width:60,
                                      child: pw.Center(
                                        child: pw.Text(
                                          (i == 0 && j == 0)
                                              ? "Exams\nSubject"
                                              : j == 0
                                              ? exams[i-1].examName
                                              : "",
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            color: PdfColors.black,
                                            fontSize: 10,
                                            //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                            fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    i != 0 ? pw.Row(
                                      children: [
                                        pw.Container(
                                          height: 28,
                                          padding: pw.EdgeInsets.all(3),
                                          decoration: const pw.BoxDecoration(
                                              border: pw.Border(
                                                right: pw.BorderSide(),
                                                top: pw.BorderSide(),
                                              )
                                          ),
                                          child: pw.Center(
                                            child: pw.Text(
                                              "Max",
                                              textAlign: pw.TextAlign.center,
                                              style: pw.TextStyle(
                                                color: PdfColors.black,
                                                fontSize: 10,
                                                //color: (i == 0 || j == 0) ? PdfColors.white : PdfColors.black,
                                                fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          height: 28,
                                          padding: pw.EdgeInsets.all(3),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border(
                                                right: pw.BorderSide(),
                                                top: pw.BorderSide(),
                                              )
                                          ),
                                          child: pw.Center(
                                            child: pw.Text(
                                              "Mark",
                                              textAlign: pw.TextAlign.center,
                                              style: pw.TextStyle(
                                                color: PdfColors.black,
                                                fontSize: 10,
                                                //color: (i == 0 || j == 0) ? PdfColors.white : PdfColors.black,
                                                fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          height: 28,
                                          padding: pw.EdgeInsets.all(3),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border(
                                                top: pw.BorderSide(),
                                              )
                                          ),
                                          child: pw.Center(
                                            child: pw.Text(
                                              "Grade",
                                              textAlign: pw.TextAlign.center,
                                              style: pw.TextStyle(
                                                color: PdfColors.black,
                                                fontSize: 10,
                                                //color: (i == 0 || j == 0) ? PdfColors.white : PdfColors.black,
                                                fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ) : pw.Column(),
                                  ],
                                ),
                              )
                                  : i == 0
                                  ? pw.Container(
                                height: j==0 ? 30 : 30,
                               // width: i ==0 ? 100 : 180,
                                padding: pw.EdgeInsets.all(3),
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(),
                                ),
                                child: pw.Center(
                                  child: pw.Text(
                                    (i == 0 && j == 0)
                                        ? ""
                                        : j == 0
                                        ? exams[i-1].examName
                                        : i == 0
                                        ? exams[0].subjects[j-1].name
                                        : exams[i-1].subjects[j-1].mark,
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                      color: PdfColors.black,
                                      fontSize: 10,
                                      //color: (i == 0 || j == 0) ? PdfColors.white : PdfColors.black,
                                      fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                    ),
                                  ),
                                ),
                              )
                                  : pw.Row(
                                children: [
                                  pw.Container(
                                    height: j==0 ? 30 : 30,
                                   // width: 60,
                                    padding: pw.EdgeInsets.all(3),
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(),
                                    ),
                                    child: pw.Center(
                                      child: pw.Text(
                                        (i == 0 && j == 0)
                                            ? ""
                                            : j == 0
                                            ? exams[i-1].examName
                                            : i == 0
                                            ? exams[0].subjects[j-1].name
                                            : exams[i-1].subjects[j-1].totalMark,
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 10,
                                          //color: (i == 0 || j == 0) ? PdfColors.white : PdfColors.black,
                                          fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    height: j==0 ? 30 : 30,
                                   // width: 60,
                                    padding: pw.EdgeInsets.all(3),
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(),
                                    ),
                                    child: pw.Center(
                                      child: pw.Text(
                                        (i == 0 && j == 0)
                                            ? ""
                                            : j == 0
                                            ? exams[i-1].examName
                                            : i == 0
                                            ? exams[0].subjects[j-1].name
                                            : exams[i-1].subjects[j-1].mark,
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 10,
                                          //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                          fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    height: j==0 ? 30 : 30,
                                  //  width: 60,
                                    padding: pw.EdgeInsets.all(3),
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(),
                                    ),
                                    child: pw.Center(
                                      child: pw.Text(
                                        (i == 0 && j == 0)
                                            ? ""
                                            : j == 0
                                            ? exams[i-1].examName
                                            : i == 0
                                            ? exams[0].subjects[j-1].name
                                            : getGrade(exams[i-1].subjects[j-1].mark,exams[i-1].subjects[j-1].totalMark),
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 10,
                                          //color: (i == 0 || j == 0) ? Colors.white : Colors.black,
                                          fontWeight: (i == 0 || j == 0) ? pw.FontWeight.bold : pw.FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                    ],
                  ),
                  pw.SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ]
    );




    final thumbupicon = pw.Image(
      await imageFromAssetBundle('assets/icons8-thumbs-up-96 1.png'),
      fit: pw.BoxFit.contain,
      height: 40,
      width:40,
    );


//container for profile image decoration


    final staffeedback=
    pw.Container(
        height: 700,
        padding: pw.EdgeInsets.all(20),
        child:pw.Column(
            children: [
              pw.SizedBox(height: 20),
              pw.Container(
                height: 50,
                width: 50,
                child:pw.Image(
                  schoolLogoUrl,
                  height: 50,
                  width:50,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(schlName),
              pw.SizedBox(height: 5),
              pw.Text(schlAddress),
              pw.SizedBox(height: 20),
              pw.Container(
                height: 200,
                width: 400,
                child: pw.Stack(
                    children: [
                      pw.Container(
                        height: 600,
                        width: 600,
                        child: pw.Image(
                            await imageFromAssetBundle('assets/Tiles.png')
                        ),
                      ),
                      ///container-1
                      pw.Padding(
                          padding: pw.EdgeInsets.only(left:30,top:20),
                          child: pw.Container(
                              width:110,
                              height:60,
                              child: pw.Text("Your are good at \nMaths and \nSocial",
                              )
                          )
                      ),
                      ///container-2
                      pw.Padding(
                          padding: pw.EdgeInsets.only(left:30,top: 120),
                          child: pw.Container(
                              width:110,
                              height:60,
                              child: pw.Text("You need to\nImprove your\nLanguage skills",)
                          )
                      ),
                      ///contaner-3
                      pw.Padding(
                          padding: pw.EdgeInsets.only(left:290,top:20),
                          child: pw.Container(
                              width:110,
                              height:60,
                              child: pw.Text("Your are weak at tamil and\nenglish")
                          )
                      ),
                      ///container-4
                      pw.Padding(
                          padding: pw.EdgeInsets.only(left:290,top:120),
                          child: pw.Container(
                              width:110,
                              height:60,
                              child: pw.Text("Low marks\nin Tamil will\nresult bad in finals")
                          )
                      ),
                    ]
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                  children: [
                    pw.Text("Staff's Feedback"),
                  ]
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                child: pw.ListView.builder(
                  itemCount: 3,//staffFeedbackList.length,
                  itemBuilder:(context, index) {
                    return pw.Padding(
                        padding: pw.EdgeInsets.only(bottom:8),
                        child:pw.Container(
                            height:50,
                            width:500,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromHex("40C502")
                                ),
                                borderRadius: pw.BorderRadius.circular(8)
                            ),
                            child:pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.SizedBox(width: 10),
                                  pw.SizedBox(
                                    height:50,
                                    width:50,
                                    child:thumbupicon,
                                  ),
                                  pw.SizedBox(width: 10),
                                  pw.SizedBox(
                                      height:50,
                                      width: 230,
                                      child:  pw.Column(
                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                                          children: [
                                            pw.SizedBox(height:8),
                                            //pw.Text("staffFeedbackList[index].value.toString()"),
                                            pw.Text("Good Keep Going"),
                                            pw.SizedBox(height:5),
                                            //pw.Text("staffFeedbackList[index].remarks.toString()"),
                                            pw.Text("Well habit and doing great in all subjects"),
                                            pw.SizedBox(height:8),
                                          ]
                                      )
                                  ),
                                  pw.Column(
                                      mainAxisAlignment: pw.MainAxisAlignment.end,
                                      children: [
                                        pw.Row(
                                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                                            children: [
                                              pw.Container(
                                                width: 70,
                                                //child: pw.Text("staffFeedbackList[index].staffname.toString()"),
                                                child: pw.Text("Gowtham"),
                                              ),
                                              pw.SizedBox(width:2),
                                              pw.Container(
                                                width:15,
                                                height:15,

                                              ),
                                              pw.SizedBox(width:2),

                                              pw.Container(
                                                width: 70,
                                                //child: pw.Text("staffFeedbackList[index].date.toString()"),
                                                child: pw.Text("16/11/2023"),
                                              ),
                                            ]
                                        ),
                                        pw.SizedBox(height:8),
                                      ]
                                  )
                                ]
                            )
                        )
                    );
                  },
                ),
              ),
              pw.SizedBox(height: 20),
            ]
        )
    );



    //widgets.add(Contents);
    widgets.add(contentrsss);
    widgets.add(staffeedback);

    //widgets.add(pw.SizedBox(height: 0));

    print("S4");
    doc.addPage(
      pw.MultiPage(
        // pageTheme: _buildTheme(
        //   pageFormat,
        //   await PdfGoogleFonts.robotoRegular(),
        //   await PdfGoogleFonts.robotoBold(),
        //   await PdfGoogleFonts.robotoItalic(),
        // ),

        build: (context)=> widgets,
      ),
    );
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
    print("S5");
    return doc.save();

  }

/*  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.SvgImage(svg: _bgShape!),
      ),
    );
  }*/


  String getGrade(String mark, String totalMark){
    String grade = '';
    double gradeVal = (mark != '' && totalMark != '') ? (int.parse(mark)/int.parse(totalMark)) * 100 : 0.0;
    if(gradeVal == 0.0){
      grade = '';
    }else if(gradeVal >= 91){
      grade = 'A1';
    }else if(gradeVal >= 81){
      grade = 'A2';
    }else if(gradeVal >= 71){
      grade = 'B1';
    }else if(gradeVal >= 61){
      grade = 'B2';
    }else if(gradeVal >= 51){
      grade = 'C1';
    }else if(gradeVal >= 41){
      grade = 'C2';
    }else if(gradeVal >= 33){
      grade = 'D';
    }else if(gradeVal >= 21){
      grade = 'E1';
    }else if(gradeVal <= 20){
      grade = 'E2';
    }
    else if(gradeVal == 0.0){
      grade = '';
    }
    return grade;
  }




}
class Stafffeebackclass {
  Stafffeebackclass({
    required this.staffname,
    required this.value,
    required this.date,
    required this.remarks,
    required this.time,
  });
  String staffname;
  String value;
  String date;
  String remarks;
  String time;
}

class ResultModel{
  ResultModel({required this.MainList, required this.staffFeedbackList});
  List staffFeedbackList;
  List MainList;
}


class ExamWithSubjectModel {
  ExamWithSubjectModel({required this.examName, required this.subjects});
  String examName;
  List<Subjects> subjects;
}

class Subjects{
  Subjects({required this.name, required this.mark, required this.totalMark});
  String name;
  String mark;
  String totalMark;
}