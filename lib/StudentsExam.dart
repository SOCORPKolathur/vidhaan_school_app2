import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Studentexamrimetable.dart';
import 'const_file.dart';
import 'examtimetable.dart';

class StudentExam extends StatefulWidget {
  String schoolId;
   StudentExam(this.schoolId);

  @override
  State<StudentExam> createState() => _StudentExamState();
}

class _StudentExamState extends State<StudentExam> {
  late Constants constants;


  String Studentid = "";
  String Studentname = '';
  String Studentregno = '';
  String Studentimg = '';

  studentdetails() async {
    var document =
    await constants.firestore2db?.collection("Students").get();
    for (int i = 0; i < document!.docs.length; i++) {
      if (document.docs[i]["studentid"] == constants.firebaseAuth2db?.currentUser!.uid) {
        setState(() {
          Studentid = document.docs[i].id;
        });
        print("Student:${Studentid}");
        print(Studentid);
      }
      if (Studentid.isNotEmpty) {
        var studentdocument = await constants.firestore2db?.collection("Students")
            .doc(Studentid)
            .get();
        Map<String, dynamic>? stuvalue = studentdocument!.data();
        final split = stuvalue!['stname'].split(' ');
        final Map<int, String> values = {
          for (int k = 0; k < split.length; k++)
            k: split[k]
        } ;
        print("ghdfghdfghdfugdfgdfgfdggdfg");
        setState((){
          Studentname=values[0]!;
        });
        print(values[0]);
        setState(() {
          Studentregno = stuvalue['regno'];
          Studentimg = stuvalue['imgurl'];
        });
      }
    }
    ;
  }
  @override
  void initState() {
    constants = Constants(widget.schoolId);
    studentdetails();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: Padding(
        padding:  EdgeInsets.only(
            left: width/36, right: width/36, top: height/15.12),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              GestureDetector(
                onTap: () {

                },
                child: Text(
                  "Exams",
                  style: GoogleFonts.poppins(
                      color:Color(0xff0873C4),
                      fontSize: width/20,
                      fontWeight:
                      FontWeight.w600),
                ),
              ),

              Row(
                children: [
                  Text(
                    "For this academic year",
                    style: GoogleFonts.poppins(
                        color: Colors
                            .grey.shade700,
                        fontSize: width/24,
                        fontWeight:
                        FontWeight.w500),
                  ),
                  SizedBox(
                    width: width / 33.33,
                  ),

                  SizedBox(
                    width: width / 33.33,
                  ),
                  Text(
                    "",
                    style: GoogleFonts.poppins(
                        color: Colors
                            .grey.shade700,
                        fontSize: width/24,
                        fontWeight:
                        FontWeight.w500),
                  ),
                ],
              ),

              /// date/day

              SizedBox(height: height / 36.85),

              Divider(
                color: Colors.grey.shade400,
                thickness: 1.5,
              ),
              StreamBuilder(
                  stream: constants.firestore2db?.collection("Students").doc(Studentid).collection("Exams").snapshots(),
                  builder: (context,snap){

                    if(!snap.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(snap.hasData==null){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }


                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snap.data!.docs.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return
                            Padding(
                            padding:  EdgeInsets.only(bottom: height/94.5),
                            child: Material(
                              elevation:5,
                              borderRadius: BorderRadius.circular(15),
                              child: GestureDetector(
                                onTap: (){

                                  print(Studentid.toString());
                                  Navigator.of(context).push(

                                      MaterialPageRoute(builder: (context)=>StudentExamTime(
                                          snap.data!.docs[index]["name"].toString(),
                                          snap.data!.docs[index].id.toString(),
                                          Studentid.toString(), widget.schoolId))
                                  );


                                },
                                child:
                                Container(
                                    width: width/1.2,
                                    height: height/7.56,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xff0873C4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left: width/30,top:height/94.5,bottom: height/151.2),
                                              child: Text(snap.data!.docs[index]["name"],style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: width/14.4,
                                                  fontWeight: FontWeight.w700

                                              ),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left: width/30),
                                              child: Text("View",style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: width/18,
                                                  fontWeight: FontWeight.w600

                                              ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(right: width/30),
                                          child: Icon(Icons.text_snippet_rounded,color: Colors.white,size: width/9,),
                                        )
                                      ],
                                    )
                                ),
                              ),
                            ),
                          );
                        });
                  })


            ],
          ),
        ),
      ),
    );
  }
}
/*
FirebaseApp _secondaryApp = Firebase.app('SecondaryApp');
final FirebaseFirestore _firestoredb = FirebaseFirestore.instance;
FirebaseFirestore constants.firestore2db? = FirebaseFirestore.instanceFor(app: _secondaryApp);
FirebaseAuth _firebaseauth2db = FirebaseAuth.instanceFor(app: _secondaryApp);*/
