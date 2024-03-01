import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifications extends StatefulWidget {
  String ?Userdocid;
   Notifications({this.Userdocid});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body:SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height:height/50.6),

            StreamBuilder(
                stream:_firestore2db.collection("Staffs").doc(widget.Userdocid).collection("Notification").orderBy("timestamp",descending: true).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData==null){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }

                  if(snapshot.data!.docs.length==0){
                    return Center(child: Text("Notification are empty"),);
                  }
                  return
                    ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {

                      var notificationdata=snapshot.data!.docs[index];

                      return  GestureDetector(
                        onTap: (){
                          notificationdescriptionpopup(notificationdata['title'],notificationdata['body'],);
                          readstatus(notificationdata.id);

                        },
                        child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(

                            child: ListTile(
                              title:SizedBox(

                                height:height/37.8,
                                width: width /
                                    .6,
                                child:
                                Padding(
                                  padding:  EdgeInsets.only(left:width/180),
                                  child: Text(
                                    "${notificationdata["title"]}",
                                    style: GoogleFonts
                                        .poppins(
                                        color:
                                        Colors.black,
                                        textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                                        fontSize:
                                        width/24,
                                        fontWeight:
                                        FontWeight
                                            .w600),
                                  ),
                                ),
                              ),
                              subtitle:Column(
                                children: [
                                  Row(
                                    children: [

                                      SizedBox(
                                        height:height/42,
                                        width: width / 1.35,
                                        child: Text(
                                          " ${notificationdata["body"]}",
                                          style: GoogleFonts
                                              .poppins(color:
                                          Colors.black54,
                                              textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                                              fontSize:
                                              width/32.0,
                                              fontWeight:
                                              FontWeight
                                                  .w600),

                                        ),
                                      ),

                                    ],
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left:width/160),
                                    child: Row(
                                      children: [

                                        SizedBox(
                                          height:height/50.4,
                                          width: width /
                                              5.8,

                                          child: Text(
                                            "${notificationdata["date"]}",
                                            style: GoogleFonts
                                                .poppins(
                                                color:
                                                Colors.black54,textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                                                fontSize:
                                                width/36.0,
                                                fontWeight:
                                                FontWeight
                                                    .w600),

                                          ),
                                        ),

                                        SizedBox(
                                          height:height/50.4,
                                          width: width /
                                              4.6,

                                          child: Text(
                                            "- ${notificationdata["time"]}",
                                            style: GoogleFonts
                                                .poppins(
                                                color:
                                                Colors.black54,
                                                fontSize:
                                                10,
                                                fontWeight:
                                                FontWeight
                                                    .w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing:notificationdata["readstatus"]==false?
                              Icon(Icons.circle,size: width/24,color: Colors.green,):SizedBox(),

                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                                border: Border.all(

                                      color: Colors.black38,


                                )
                            ),
                          ),
                        ),
                      );

                  },);
                },),
            SizedBox(height:height/50.6),
          ],
        ),
      )
    );
  }

  readstatus(docid){
    _firestore2db.collection("Staffs").doc(widget.Userdocid).collection("Notification").doc(docid).update({
      "readstatus":true
    });
  }


  notificationdescriptionpopup(name, description) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return showDialog(context: context, builder: (ctx) =>
        AlertDialog(
          title: Container(
            child: Center(child: Column(
              children: [
                Text('Notification', style: TextStyle(
                    fontSize: width / 20.5, fontWeight: FontWeight.w700),),
                SizedBox(height: height / 200.2,),
                Text('Title:  ${name.toString()}', style: TextStyle(
                    fontSize: width / 30.5, fontWeight: FontWeight.w700),),
                SizedBox(height: height / 200.2,),

              ],
            )),
          ),
          content: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5)
          ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height / 189,
                      horizontal: width / 90,
                    ),
                    child: Container(
                        decoration: BoxDecoration(

                        ), padding: EdgeInsets.symmetric(
                      vertical: height / 189,
                      horizontal: width / 90,
                    ),
                        child: Text(description, style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: width / 25.714,
                            color: Colors.black),)),
                  ),
                  SizedBox(height: height / 50.4,),


                ],
              ),
            ),
          ),

          actions: [
           TextButton(onPressed: (){
             Navigator.pop(context);
           }, child:Text('Okay', style: TextStyle(
               fontWeight: FontWeight.w700),), )
          ],


        ));
  }





}
FirebaseApp _secondaryApp = Firebase.app('SecondaryApp');
final FirebaseFirestore _firestoredb = FirebaseFirestore.instance;
FirebaseFirestore _firestore2db = FirebaseFirestore.instanceFor(app: _secondaryApp);
FirebaseStorage _firebaseStorage2= FirebaseStorage.instanceFor(app: _secondaryApp);
FirebaseAuth _firebaseauth2db = FirebaseAuth.instanceFor(app: _secondaryApp);