import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Statff_Leave_Page extends StatefulWidget {
  String section;
   Statff_Leave_Page(this.section);

  @override
  State<Statff_Leave_Page> createState() => _Statff_Leave_PageState();
}

class _Statff_Leave_PageState extends State<Statff_Leave_Page> {

  String staffid="";
  String staffname="";
  String staffregno="";
  String staffimg="";

  getstaffdetails() async {
    var document = await FirebaseFirestore.instance.collection("Staffs").get();
    for(int i=0;i<document.docs.length;i++){
      if(document.docs[i]["userid"]==FirebaseAuth.instance.currentUser!.uid){
        setState(() {
          staffid=document.docs[i].id;
        });
      }
      if(staffid.isNotEmpty){
        var document2 =  await FirebaseFirestore.instance.collection("Staffs").doc(staffid).get();
        Map<String,dynamic>? value = document2.data();
        setState(() {
          staffname=value!["stname"];
          staffregno=value["regno"];
          staffimg=value["imgUrl"];
        });
      }
    };

  }

  @override
  void initState() {
    getstaffdetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Column(
        children: [

          Container(
              height: height/2.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/Rectangle.png")
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(height: height/15.12,),

                  Row(
                    children: [
                      SizedBox(width:width/36.0,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height:height/21.6,
                          width: width/10.285,
                          child: Material(
                              elevation: 15,
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                              child
                                  : Icon(Icons.arrow_back)),
                        ),
                      ),
                      SizedBox(width:width/36.0,),
                      Text("Today Attendance",style: GoogleFonts.montserrat(
                          fontSize: width/20,
                          fontWeight: FontWeight.w700,color: Colors.white),)
                    ],
                  ),
                  
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 25.745, left: width / 40.4),
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage:  NetworkImage(
                          staffimg
                      ),
                    ),
                  ),

                   SizedBox(height: height/151.2,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width / 10),
                        child: Text(
                          staffname, style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: width/16.3636,
                            fontWeight: FontWeight.bold

                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width / 15),
                        child: Text("ID : ${staffregno}",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize:width/22.5,
                              fontWeight: FontWeight.w500

                          ),),
                      )
                    ],
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(

                      horizontal: width/45,
                      vertical: height/94.5
                    ),
                    child: Text("Today - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w700,fontSize: width/20),),
                  ),
                  
                ],
              )),
          SizedBox(height: height/15.12,),
          
          GestureDetector(
            onTap: (){
              Marktheattendancefun();
              staffSuccessdialog();
            },
            child: Material(
              elevation: 50,
              shadowColor: Colors.black26,
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(5),
              child: Container(
                  height: height/15.12,
                  width: width/1.8,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(child: Text("Mark the Attendance",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),))),
            ),
          ),

          SizedBox(height: height/37.8,),

          GestureDetector(
            onTap: (){
              staffleaveSuccessdialog();
            },
            child: Material(
              elevation: 50,
              shadowColor: Colors.black26,
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                  height: height/15.12,
                  width: width/1.8,
                  decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(child: Text("Apply Leave",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),))),
            ),
          )
          
          
        ],
      ),

    );
  }


  Marktheattendancefun(){
    FirebaseFirestore.instance.collection("Staff_attendance").doc("${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}").
    set(
        {
          "Staffattendance":true,
          "Staffname":staffname,
          "Staffregno":staffregno,
          "Staffid":staffid,
          "Class":widget.section,
          "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "Time":DateFormat("h:mma").format(DateTime.now()),
          "timstamp":DateTime.now().millisecondsSinceEpoch,
        });

    FirebaseFirestore.instance.collection("Staffs").doc(FirebaseAuth.instance.currentUser!.uid).collection("Attendance").doc("${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}").
    update(
        {
          "Staffattendance":true,
          "Staffname":staffname,
          "Staffregno":staffregno,
          "Staffid":staffid,
          "Class":widget.section,
          "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "Time":DateFormat("h:mma").format(DateTime.now()),
          "timstamp":DateTime.now().millisecondsSinceEpoch,
        });

    FirebaseFirestore.instance.collection("Staff Attendance").doc("${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}").
    collection("Staffs").doc(staffregno).
    set(
        {
          "Staffattendance":true,
          "Staffname":staffname,
          "Staffregno":staffregno,
          "Staffid":staffid,
          "Class":widget.section,
          "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "Time":DateFormat("h:mma").format(DateTime.now()),
          "timstamp":DateTime.now().millisecondsSinceEpoch,
        });
  }

  staffSuccessdialog(){
    double width=MediaQuery.of(context).size.width;
    return AwesomeDialog(
      width: width/0.8,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Attendance Submitted Successfully',
      desc: 'Attendance Submitted for - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ',
      btnCancelOnPress: () {

      },
      btnOkOnPress: () {


      },
    )..show();
  }


  leavestfffunction(){
    FirebaseFirestore.instance.collection("Staff_Leave").doc("${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}").
    set(
        {
          "Staffattendance":true,
          "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "Time":DateFormat("h:mma").format(DateTime.now()),
          "timstamp":DateTime.now().millisecondsSinceEpoch,
          "Staffname":staffname,
          "Staffregno":staffregno,
        });
  }

  staffleaveSuccessdialog(){

    double width=MediaQuery.of(context).size.width;

    return AwesomeDialog(
      width: width/0.8,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Are You Sure Want Apply Leave',
      desc: 'Leve Submitted for - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ',
      btnCancelOnPress: () {

      },
      btnOkOnPress: () {
        leavestfffunction();
      },
    )..show();
  }




  }






