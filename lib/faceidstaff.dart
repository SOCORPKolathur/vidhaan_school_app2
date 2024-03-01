import 'dart:io';

import 'package:flutter/material.dart';

import 'package:face_camera/face_camera.dart';
import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'View Staff Report/Staff_View_Reports.dart';

class DemoFaceid extends StatefulWidget {
  const DemoFaceid({Key? key}) : super(key: key);

  @override
  State<DemoFaceid> createState() => _DemoFaceidState();
}

class _DemoFaceidState extends State<DemoFaceid> {
  File? _capturedImage;

  @override
  void initState() {

    getstaffdetails();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('Enroll Your Face'),
          ),
          body: Builder(
              builder: (context) {
          /*  if (_capturedImage != null) {
              return Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.file(
                      _capturedImage!,
                      width: double.maxFinite,
                      fit: BoxFit.fitWidth,
                    ),
                   *//* ElevatedButton(
                        onPressed: () => setState(() => _capturedImage = null),
                        child: const Text(
                          'Capture Now',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ))*//*
                  ],
                ),
              );
            }*/
            return SmartFaceCamera(


                defaultCameraLens: CameraLens.front,
                onCapture: (File? image) {
                  setState(() => _capturedImage = image
                  );
                  enroll();

                },
                onFaceDetected: (Face? face) {
                  //Do something
                },
                messageBuilder: (context, face) {
                  if (face == null) {
                    return _message('Place your face in the camera');
                  }
                  if (!face.wellPositioned) {
                    return _message('Center your face in the square');
                  }
                  return const SizedBox.shrink();
                });
          }));

  }

  enroll() async {

    print("Fun 2 Starteddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    final faceDetector = FaceDetector(    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.accurate,
      enableContours: true,
      enableLandmarks: true,
      enableTracking: true,
    ),);

    // Detect faces in an image.

    final inputImage = InputImage.fromFile(_capturedImage!);
    final faces = await faceDetector.processImage(inputImage);

    // Get the face data as a string.

    final faceData2 = faces.map((face) async {
      final leftEyeLandmark = face.landmarks[FaceLandmarkType.leftEye];
      final leftEyePosition = leftEyeLandmark?.position;
      final rightEyeLandmark = face.landmarks[FaceLandmarkType.rightEye];
      final rightEyePosition = rightEyeLandmark?.position;
      final bottommouthLandmark = face.landmarks[FaceLandmarkType.bottomMouth];
      final bottommouthPosition = bottommouthLandmark?.position;
      final rightmouthLandmark = face.landmarks[FaceLandmarkType.rightMouth];
      final rightmouthPosition = rightmouthLandmark?.position;
      final leftmouthLandmark = face.landmarks[FaceLandmarkType.leftMouth];
      final leftmouthPosition = leftmouthLandmark?.position;
      final nouseLandmark = face.landmarks[FaceLandmarkType.noseBase];
      final nousePosition = nouseLandmark?.position;


      final leftcheekLandmark = face.landmarks[FaceLandmarkType.leftCheek];
      final leftcheekPosition = leftcheekLandmark?.position;

      final rightcheekLandmark = face.landmarks[FaceLandmarkType.rightCheek];
      final rightcheekPosition = rightcheekLandmark?.position;

      final leftearLandmark = face.landmarks[FaceLandmarkType.leftEar];
      final leftearPosition = leftearLandmark?.position;

      final rightearLandmark = face.landmarks[FaceLandmarkType.rightEar];
      final rightearPosition = rightearLandmark?.position;

      _firestore2db.collection("Staffs").doc(staffid).collection("Facedate").doc(staffid).set({
        "leftEyePositionx":leftEyePosition!.x,
        "rightEyePositionx":rightEyePosition!.x,
        "bottommouthPositionx":bottommouthPosition!.x,
        "rightmouthPositionx":rightmouthPosition!.x,
        "leftmouthPositionx":leftmouthPosition!.x,
        "nousePositionx":nousePosition!.x,
        "leftEyePositiony":leftEyePosition!.y,
        "rightEyePositiony":rightEyePosition!.y,
        "bottommouthPositiony":bottommouthPosition!.y,
        "rightmouthPositiony":rightmouthPosition!.y,
        "leftmouthPositiony":leftmouthPosition!.y,
        "nousePositiony":nousePosition!.y,

        "leftcheekPositiony":leftcheekPosition!.y,
        "rigthcheekPositiony":rightcheekPosition!.y,
        "leftearPositiony":leftearPosition!.y,
        "rightearPositiony":rightearPosition!.y,

        "leftcheekPositionx":leftcheekPosition!.x,
        "rigthcheekPositionx":rightcheekPosition!.x,
        "leftearPositionx":leftearPosition!.x,
        "rightearPositionx":rightearPosition!.x,
      });


      return 'Face id: ${leftEyePosition!.y},${rightEyePosition!.y},${bottommouthPosition!.y},${rightmouthPosition!.y},${leftmouthPosition!.y},${nousePosition!.y},';
    }).join('\n');


    _firestore2db.collection("Staffs").doc(staffid).update({
      "faceid":true
    });
    showsucess();


    print(faceData2);
    getstaffdetails();

    print("Fun 2 Completedddddddddddddddddddddddddddddddddddddddddddddd");
  }
  String staffid="";
  String staffname="";
  String staffregno="";
  String staffimg="";
  int status=0;

  getstaffdetails() async {



    var document = await _firestore2db.collection("Staffs").get();
    for(int i=0;i<document.docs.length;i++){
      if(document.docs[i]["userid"]==_firebaseauth2db.currentUser!.uid){
        setState(() {
          staffid=document.docs[i].id;
        });
        print("Saffid:${staffid}");
        print(staffid);
      }
      if(staffid.isNotEmpty){
        var staffdocument= await _firestore2db.collection("Staffs").doc(staffid).get();
        Map<String,dynamic>?staffvalue=staffdocument.data();
        var document2 = await  _firestore2db.collection("Staffs").doc(staffid).
        collection("Attendance").where("Date",isEqualTo: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}").get();

        setState(() {
          staffname=staffvalue!['stname'];
          staffregno=staffvalue['regno'];
          staffimg=staffvalue['imgurl'];
          /*    if(document2.docs.length>0){
            status = 1;
            showpopup();
          }
          else {*/
          if (staffvalue['faceid'] == true) {

            status = 1;
          }
          else {
            status = 2;
          }
          //}
          print(staffvalue['faceid']);
          print("Staff Face ============================================================");
        });
      }
    };



    print("staffname stff id staff img");

    print(staffname);
    print(staffregno);
    print(staffimg);
  }


  showsucess(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
        width: width/0.8,
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Face Enrolled Successfully',
        desc: "",
        btnOkOnPress: () {
          Navigator.of(context).pop();
        },
        btnOkText: "Ok"
    )..show();
  }

  Widget _message(String msg) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 25),
    child: Text(msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
  );
}

class DemoFaceid2 extends StatefulWidget {
  int val;
  DemoFaceid2(this.val);

  @override
  State<DemoFaceid2> createState() => _DemoFaceid2State();
}

class _DemoFaceid2State extends State<DemoFaceid2> {
  File? _capturedImage;

  @override
  void initState() {
    cmonth = getMonth(DateTime.now().month);
    getstaffdetails();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Verify your Face ID'),
        ),
        body: Builder(
            builder: (context) {
              /*  if (_capturedImage != null) {
              return Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.file(
                      _capturedImage!,
                      width: double.maxFinite,
                      fit: BoxFit.fitWidth,
                    ),
                   *//* ElevatedButton(
                        onPressed: () => setState(() => _capturedImage = null),
                        child: const Text(
                          'Capture Now',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ))*//*
                  ],
                ),
              );
            }*/
              return SmartFaceCamera(
                captureControlIcon: Container(),
                showCaptureControl: false,
                autoCapture: true,
                  showCameraLensControl: false,
                  showControls: false,
                  showFlashControl: false,

                  defaultCameraLens: CameraLens.front,
                  onCapture: (File? image) {
                    setState(() => _capturedImage = image
                    );
                    if(facedec==false){
                    verfiy(widget.val);
                    }
                  },
                  onFaceDetected: (Face? face) {
                    //Do something
                  },
                  messageBuilder: (context, face) {
                    if (face == null) {
                      return _message('Place your face in the camera');
                    }
                    if (!face.wellPositioned) {
                      return _message('Center your face in the square');
                    }
                    return const SizedBox.shrink();
                  });


            }));

  }
  bool facedec= false;
  verfiy(val) async {
    setState(() {
      facedec = true;
    });
    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        enableContours: true,
        enableLandmarks: true,
        enableTracking: true,
      ),
    );

    // Detect faces in an image.

    final inputImage = InputImage.fromFile(_capturedImage!);
    final faces = await faceDetector.processImage(inputImage);

    // Get the face data as a string.

    final faceData2 = faces.map((face) async {
      final leftEyeLandmark = face.landmarks[FaceLandmarkType.leftEye];
      final leftEyePosition = leftEyeLandmark?.position;
      final rightEyeLandmark = face.landmarks[FaceLandmarkType.rightEye];
      final rightEyePosition = rightEyeLandmark?.position;
      final bottommouthLandmark = face.landmarks[FaceLandmarkType.bottomMouth];
      final bottommouthPosition = bottommouthLandmark?.position;
      final rightmouthLandmark = face.landmarks[FaceLandmarkType.rightMouth];
      final rightmouthPosition = rightmouthLandmark?.position;
      final leftmouthLandmark = face.landmarks[FaceLandmarkType.leftMouth];
      final leftmouthPosition = leftmouthLandmark?.position;
      final nouseLandmark = face.landmarks[FaceLandmarkType.noseBase];
      final nousePosition = nouseLandmark?.position;

      final leftcheekLandmark = face.landmarks[FaceLandmarkType.leftCheek];
      final leftcheekPosition = leftcheekLandmark?.position;

      final rightcheekLandmark = face.landmarks[FaceLandmarkType.rightCheek];
      final rightcheekPosition = rightcheekLandmark?.position;

      final leftearLandmark = face.landmarks[FaceLandmarkType.leftEar];
      final leftearPosition = leftearLandmark?.position;

      final rightearLandmark = face.landmarks[FaceLandmarkType.rightEar];
      final rightearPosition = rightearLandmark?.position;



      var documet = await _firestore2db.collection("Staffs").doc(staffid).collection("Facedate").doc(staffid).get();
      Map<String, dynamic>?  value= documet.data();
      int i =0;
      setState(() {
        i=0;
      });
      if(value!["leftEyePositionx"]<=leftEyePosition!.x+25&&value!["leftEyePositionx"]>=leftEyePosition!.x-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["rightEyePositionx"]<=rightEyePosition!.x+25&&value!["rightEyePositionx"]>=rightEyePosition!.x-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["bottommouthPositionx"]<=bottommouthPosition!.x+25&&value!["bottommouthPositionx"]>=bottommouthPosition!.x-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["rightmouthPositionx"]<=rightmouthPosition!.x+25&&value!["rightmouthPositionx"]>=rightmouthPosition!.x-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["leftmouthPositionx"]<=leftmouthPosition!.x+25&&value!["leftmouthPositionx"]>=leftmouthPosition!.x-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["nousePositionx"]<=nousePosition!.x+25&&value!["nousePositionx"]>=nousePosition!.x-25){
        setState(() {
          i=i+1;
        });
      }

      if(value!["leftEyePositiony"]<=leftEyePosition!.y+25&&value!["leftEyePositiony"]>=leftEyePosition!.y-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["rightEyePositiony"]<=rightEyePosition!.y+25&&value!["rightEyePositiony"]>=rightEyePosition!.y-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["bottommouthPositiony"]<=bottommouthPosition!.y+25&&value!["bottommouthPositiony"]>=bottommouthPosition!.y-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["rightmouthPositiony"]<=rightmouthPosition!.y+25&&value!["rightmouthPositiony"]>=rightmouthPosition!.y-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["leftmouthPositiony"]<=leftmouthPosition!.y+25&&value!["leftmouthPositiony"]>=leftmouthPosition!.y-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["nousePositiony"]<=nousePosition!.y+25&&value!["nousePositiony"]>=nousePosition!.y-25){
        setState(() {
          i=i+1;
        });
      }

      if(value!["leftcheekPositiony"]<=leftcheekPosition!.y+25&&value!["leftcheekPositiony"]>=leftcheekPosition!.y-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["rigthcheekPositiony"]<=rightcheekPosition!.y+25&&value!["rigthcheekPositiony"]>=rightcheekPosition!.y-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["leftearPositiony"]<=leftearPosition!.y+25&&value!["leftearPositiony"]>=leftearPosition!.y-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["rightearPositiony"]<=rightearPosition!.y+25&&value!["rightearPositiony"]>=rightearPosition!.y-25){
        setState(() {
          i=i+1;
        });
      }

      if(value!["leftcheekPositionx"]<=leftcheekPosition!.x+25&&value!["leftcheekPositionx"]>=leftcheekPosition!.x-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["rigthcheekPositionx"]<=rightcheekPosition!.x+25&&value!["rigthcheekPositionx"]>=rightcheekPosition!.x-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["leftearPositionx"]<=leftearPosition!.x+25&&value!["leftearPositionx"]>=leftearPosition!.x-25){
        setState(() {
          i=i+1;
        });
      }
      if(value!["rightearPositionx"]<=rightearPosition!.x+25&&value!["rightearPositionx"]>=rightearPosition!.x-25){
        setState(() {
          i=i+1;
        });
      }




      print("Face Matched =======================================================================================");
      print(i);
      if(i==20||i==19||i==18||i==17){
        val==1?
        Marktheattendancefun():
        Marktheattendancefun2();

      }
      else{
        showwwaring2();
      }
      return 'Face id: ${leftEyePosition!.y},${rightEyePosition!.y},${bottommouthPosition!.y},${rightmouthPosition!.y},${leftmouthPosition!.y},${nousePosition!.y},';
    }).join('\n');
    getstaffdetails();

    // Print the face data.

    print(faceData2);
  }
  Marktheattendancefun(){
    _firestore2db.collection("Staffs").
    doc(staffid).
    update(
        {
          "absent":false,
        }
    );

    _firestore2db.collection("Staffs").doc(staffid).
    collection("Attendance").doc("${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}").
    set(
        {
          "Staffattendance":true,
          "Class":section,
          "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "checkIntime":DateFormat("h:mma").format(DateTime.now()),
          "checkOuttime":"-",
          "timstamp":DateTime.now().millisecondsSinceEpoch,
          "month": cmonth


        }
    );

    _firestore2db.collection("Staff_attendance").
    doc("${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}").
    collection("Staffs").doc(staffid).
    set(
        {
          "Staffattendance":true,
          "Staffname":staffname,
          "Staffregno":staffregno,
          "Staffid":staffid,
          "Class":section,
        "month": cmonth,
          "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "checkIntime":DateFormat("h:mma").format(DateTime.now()),
          "checkOuttime":"-",
          "timstamp":DateTime.now().millisecondsSinceEpoch,
        }

    );
    showmarked();


  }
  String section = "";
  String cmonth = "";

  String getMonth(int currentMonthIndex) {
    return DateFormat('MMM').format(DateTime(0, currentMonthIndex)).toString();
  }
  showmarked(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
        width: width/0.8,
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Attendance Marked Successfully',
        desc: "",
        btnOkOnPress: () {

          Navigator.of(context).pop();
        },
        btnOkText: "Ok"
    )..show();
  }

  Marktheattendancefun2() async {
    var document = await _firestore2db.collection("Staffs").doc(staffid).collection("Attendance").where("Date",isEqualTo: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}").get();

    if(document.docs.length>0) {
      _firestore2db.collection("Staffs").
      doc(staffid).
      update(
          {
            "absent": false,
          }
      );

      _firestore2db.collection("Staffs").doc(staffid).
      collection("Attendance").doc("${DateTime
          .now()
          .day}${DateTime
          .now()
          .month}${DateTime
          .now()
          .year}").
      update(
          {
            "checkOuttime": DateFormat("h:mma").format(DateTime.now()),
          }
      );

      _firestore2db.collection("Staff_attendance").
      doc("${DateTime
          .now()
          .day}${DateTime
          .now()
          .month}${DateTime
          .now()
          .year}").
      collection("Staffs").doc(staffid).
      set(
          {
            "checkOuttime": DateFormat("h:mma").format(DateTime.now()),
          }

      );
      showmarked();
    }
    else{
      checkinpopup();
    }

  }
  checkinpopup(){

    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
        width: width/0.8,
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: "Check Out can't be marked",
        desc: "Please mark Check IN record",




        btnOkOnPress: () {

        },
        btnOkText: "Ok"
    )..show();
  }
  showwwaring2(){
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
        width: width/0.8,
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'Sorry wrong face,Try Again',

        descTextStyle: TextStyle(

        ),

        btnOkOnPress: () {
        Navigator.of(context).pop();
        },
        btnOkText: "Ok"
    )..show();


  }
  String staffid="";
  String staffname="";
  String staffregno="";
  String staffimg="";
  int status=0;

  getstaffdetails() async {



    var document = await _firestore2db.collection("Staffs").get();
    for(int i=0;i<document.docs.length;i++){
      if(document.docs[i]["userid"]==_firebaseauth2db.currentUser!.uid){
        setState(() {
          staffid=document.docs[i].id;
        });
        print("Saffid:${staffid}");
        print(staffid);
      }
      if(staffid.isNotEmpty){
        var staffdocument= await _firestore2db.collection("Staffs").doc(staffid).get();
        Map<String,dynamic>?staffvalue=staffdocument.data();
        var document2 = await  _firestore2db.collection("Staffs").doc(staffid).
        collection("Attendance").where("Date",isEqualTo: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}").get();

        setState(() {
          staffname=staffvalue!['stname'];
          staffregno=staffvalue['regno'];
          staffimg=staffvalue['imgurl'];
          /*    if(document2.docs.length>0){
            status = 1;
            showpopup();
          }
          else {*/
          if (staffvalue['faceid'] == true) {

            status = 1;
          }
          else {
            status = 2;
          }
          //}
          print(staffvalue['faceid']);
          print("Staff Face ============================================================");
        });
      }
    };



    print("staffname stff id staff img");

    print(staffname);
    print(staffregno);
    print(staffimg);
  }




  Widget _message(String msg) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 25),
    child: Text(msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
  );
}


FirebaseApp _secondaryApp = Firebase.app('SecondaryApp');
final FirebaseFirestore _firestoredb = FirebaseFirestore.instance;
FirebaseFirestore _firestore2db = FirebaseFirestore.instanceFor(app: _secondaryApp);
FirebaseAuth _firebaseauth2db = FirebaseAuth.instanceFor(app: _secondaryApp);