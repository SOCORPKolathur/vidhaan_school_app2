import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaan_school_app/assignmentsreports.dart';
import 'package:vidhaan_school_app/records2.dart';
import 'examreports.dart';



class Records extends StatefulWidget {
  String staffregno;
   Records(this.staffregno);

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              GestureDetector(
                onTap: () {

                },
                child: Text(
                  "R & R",
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
                        fontSize:width/24,
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
                        fontSize:width/24,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    elevation:5,
                    borderRadius: BorderRadius.circular(15),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>Records2())
                        );


                      },
                      child: Container(
                          width: width/1.1,
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
                                    padding:  EdgeInsets.only(left: width/30,top: height/94.5,bottom: height/151.2),
                                    child: Text("Students Attendance",style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: width/18,
                                        fontWeight: FontWeight.w700

                                    ),
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: width/30),
                                    child: Text("View",style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: width/20,
                                        fontWeight: FontWeight.w600

                                    ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.only(right: width/30),
                                child: Icon(Icons.school,color: Colors.white,size: width/9,),
                              )
                            ],
                          )
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top:height/50.4),
                    child: Material(
                      elevation:5,
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>ExamReports())
                          );
                        },
                        child: Container(
                            width: width/1.1,
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
                                      padding:  EdgeInsets.only(left: width/30,top: height/94.5,bottom: height/151.2),
                                      child: Text("Exam Reports",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: width/18,
                                          fontWeight: FontWeight.w700

                                      ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(left:width/30),
                                      child: Text("View",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: width/20,
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
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top:height/50.4),
                    child: Material(
                      elevation:5,
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>AssignmentReports(widget.staffregno))
                          );
                        },
                        child: Container(
                            width: width/1.1,
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
                                      padding:  EdgeInsets.only(left: width/30,top: height/94.5,bottom: height/151.2),
                                      child: Text("Assignments Reports",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: width/18,
                                          fontWeight: FontWeight.w700

                                      ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(left:width/30),
                                      child: Text("View",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: width/20,
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
                  ),
                ],
              ),
              /*StreamBuilder(
                  stream: _firestore2db.collection("ExamMaster").snapshots(),
                  builder: (context,snap){
                    if(snap.hasData==null){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(!snap.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snap.data!.docs.length,
                        itemBuilder: (context,index){
                          return ;
                        });
                  })

               */




            ],
          ),
        ),
      ),
    );
  }
}
FirebaseApp _secondaryApp = Firebase.app('SecondaryApp');
final FirebaseFirestore _firestoredb = FirebaseFirestore.instance;
FirebaseFirestore _firestore2db = FirebaseFirestore.instanceFor(app: _secondaryApp);
FirebaseAuth _firebaseauth2db = FirebaseAuth.instanceFor(app: _secondaryApp);