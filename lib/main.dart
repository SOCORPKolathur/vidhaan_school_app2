import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:face_camera/face_camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:splash_view/source/presentation/pages/pages.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:video_player/video_player.dart';
import 'Student_Landing_Page.dart';
import 'account_page.dart';
import 'firebase_options1.dart';
import 'firebase_options2.dart';
import 'firebase_options3.dart';
import 'homepage.dart';
import 'const_file.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp(
    name: 'SecondaryApp',
    options: SecondaryFirebaseOptions.currentPlatform,
  );
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize the secondary Firebase app if it hasn't been initialized
    FirebaseApp firstApp = Firebase.app('FirstApp');
  } catch (e) {
    await Firebase.initializeApp(
      name: 'FirstApp',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  try {
    // Initialize the secondary Firebase app if it hasn't been initialized
    FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
  } catch (e) {
    await Firebase.initializeApp(
      name: 'SecondaryApp',
      options: SecondaryFirebaseOptions.currentPlatform,
    );
  }

  try {
    // Initialize the third Firebase app if it hasn't been initialized
    FirebaseApp thirdApp = Firebase.app('ThirdApp');
  } catch (e) {
    await Firebase.initializeApp(
      name: 'ThirdApp',
      options: ThirdFirebaseOptions.currentPlatform,
    );
  }
  await FaceCamera.initialize();
  //initialize background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp( MyApp()));

}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {


  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    print("Init Stateeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    //usertypecheckfunction();
    setupInteractedMessage();
    // TODO: implement initState
    super.initState();

  }


 /* navigateToPage(String page) {
    print("Navigate the Firebase messing Pagessssssssssssssssssssssssssssssssssssssssss");
    // Implement your navigation logic here
    // For example, use Navigator.push to navigate to the desired page
    // You can replace the code below with your actual navigation logic

    BuildContext context = navigatorKey.currentContext!;

    if(userType=="Student"){
      if(page=="Home Work"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Student_landing_Page(page,true,)));
      }
      if(page=="Attendance"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Student_landing_Page(page,true)));
      }
      if(page=="Message"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Student_landing_Page(page,true)));
      }
      if(page=="Feed Back"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Student_landing_Page(page,true)));
      }
    }

    if(userType=="Teacher"){

      Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));

    }

  }*/


  setupInteractedMessage() async {
    print("1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

   _handleMessage(RemoteMessage message) {
    print(message.data['page'].toString());
    //navigateToPage(message.data['page'].toString());

  }






  String userType ="";
  String? _deviceId;
  String schoolurl="";

  /*  usertypecheckfunction() async {
    String? deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await UniqueIdentifier.serial;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _deviceId = deviceId;
      print("deviceId->$_deviceId");
    });
    if(_firebaseauth2db.currentUser!=null){
      var  result = await FirebaseFirestore.instance.collection('UserID').get();

      for(int i=0;i<result.docs.length;i++) {
        if (_deviceId == result.docs[i]["id"]) {
          setState(() {
            schoolurl = result.docs[i]["schoolurl"];
          });
        }
      }
    }

      if(_firebaseauth2db.currentUser!=null){
        var getdate=await _firestore2db.collection('deviceid').where("id",isEqualTo: _firebaseauth2db.currentUser!.uid).where("type",isEqualTo:"Student" ).get();
        var getdate2=await _firestore2db.collection('deviceid').where("id",isEqualTo: _firebaseauth2db.currentUser!.uid).where("type",isEqualTo:"Teacher" ).get();
        if(getdate.docs.length>0){
          Timer(Duration(seconds: 5),(){
            setState(() {
              userType="Student";
            });
          }
          );
        }
        if(getdate2.docs.length>0){
          Timer(Duration(seconds: 5),(){
            setState(() {
              userType="Teacher";
            });

          }
          );
        }
      }



  }*/

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Vidhaan',
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Color(0xff0271C5),
        ),
      ),

      home:  splashscreen(),
    );
  }
}


///Splashscreen
class splashscreen extends StatefulWidget {
  const splashscreen({Key ? key}) : super(key: key);

  @override
  _splashscreenState createState() => _splashscreenState();
}
class _splashscreenState extends State<splashscreen> {
  String? _deviceId;
  String schoolurl="";
  String schoolID="";

  bool user =false;

  late Constants constants;

  Future<void> initPlatformState() async {
    String? deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await UniqueIdentifier.serial;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _deviceId = deviceId;
      print("deviceId->$_deviceId");
    });
    var  result = await _firestore2db.collection('UserID')
        .get();

    for(int i=0;i<result.docs.length;i++){
      if (_deviceId==result.docs[i]["id"]) {
        setState(() {
          user=true;
          schoolurl=result.docs[i]["schoolurl"];
          schoolID=result.docs[i]["schoolID"];
          constants = Constants(schoolID);
        });
      }

    }
    if(user==false){
      Timer(Duration(seconds: 5),
              () {
            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child:  MyHomePage()));
          }
      );
    }
    else{
      if(constants.firebaseAuth2db?.currentUser!=null){
        var getdate=await constants.firestore2db?.collection('deviceid').where("id",isEqualTo: constants.firebaseAuth2db?.currentUser!.uid).where("type",isEqualTo:"Student" ).get();
        var getdate2=await constants.firestore2db?.collection('deviceid').where("id",isEqualTo: constants.firebaseAuth2db?.currentUser!.uid).where("type",isEqualTo:"Teacher" ).get();
        if(getdate!.docs.length>0){
          Timer(Duration(seconds: 5),(){
            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: Student_landing_Page("",false,schoolID),));

          }
          );
        }
        if(getdate2!.docs.length>0){
          Timer(Duration(seconds: 5),(){
            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: Homepage(schoolID),));

          }
          );
        }
      }
      else{
        print("Login Page");
        Timer(Duration(seconds: 5),(){
          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: Accountpage(schoolID)));


        }
        );
        // Otppage("9176463821", "Teacher", "e71KBP6ky3KnurZlHpfZ"),
        // Otppage("9941123453", "Student", "i570pkx8k9u78gea"),
      }

    }

  }
  late VideoPlayerController _controller;
  void initState() {
    _controller = VideoPlayerController.asset("assets/VidhaanLogoVideonew2.mp4",videoPlayerOptions: VideoPlayerOptions(
      allowBackgroundPlayback: true,
      mixWithOthers: true,

    ))
      ..initialize().then((value) => {setState(() {})});
    _controller.setVolume(0.0);
    _controller.play();
    initPlatformState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return   Scaffold(


        body: GestureDetector(
          onTap: (){
            print(width);
            print(height);
          },
          child: SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: width/0.98,
                height: height/0.94337,
                child: VideoPlayer(_controller,),
              ),
            ),
          ),
        )

    );

  }

}

///Page to enter School ID
class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  bool school= false;

  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/VidhaanLogoVideonew2.mp4",videoPlayerOptions: VideoPlayerOptions(
      allowBackgroundPlayback: true,
      mixWithOthers: true,

    ))
      ..initialize().then((value) => {setState(() {})});
    _controller.setVolume(0.0);
    _controller.play();
    Future.delayed(Duration(milliseconds: 2500),(){
      setState(() {
        school=true;
      });
    });
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);




  }



  TextEditingController schoolid = new TextEditingController();

  String _deviceId =" ";

  Future<void> initPlatformState(url,id) async {
    String? deviceId;

    try {
      deviceId = await UniqueIdentifier.serial;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    if (!mounted) return;

    setState(() {
      _deviceId = deviceId!;
      print("deviceId->$_deviceId");
    });
    await _firestore2db
        .collection('UserID')
        .doc(_deviceId)
        .set({
      "id":_deviceId,
      "schoolurl": url,
      "schoolID": id,
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(


      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: width/0.98,
                  height: height/0.94337,
                  child: VideoPlayer(_controller,),
                ),
              ),
            ),
/*
            Lottie.asset("assets/Vidhaan Logo Resolution Changed 3mb version.json",repeat:false,height: double.infinity),
*/
            SlideInUp(
              delay: Duration(milliseconds: 4500),
              duration: Duration(milliseconds: 500),
              from: 500,
              child: Padding(
                padding:  EdgeInsets.only(top: height/3.52),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width/1.125,
                      height: height/12.6,
                      decoration: BoxDecoration(color: Color(0xffFEFCFF),

                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Color(0xff0271C5).withOpacity(0.80),)
                      ),
                      child: Center(
                          child: TextField(
                            onTap: (){
                              setState(() {
                                school=false;
                              });
                            },
                            onEditingComplete: (){
                              setState(() {
                                school=true;
                              });
                            },
                            onSubmitted: (val){
                              setState(() {
                                school=true;
                              });
                            },
                            textCapitalization: TextCapitalization.sentences,
                            controller: schoolid,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "School ID",

                              prefixIcon: Icon(Icons.school,),
                              hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: width/26.84,

                              ),


                              border: InputBorder.none,

                            ),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: width/22.84,
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SlideInUp(
              delay: Duration(milliseconds: 4000),
              duration: Duration(milliseconds: 400),
              from: 500,
              child: Padding(
                padding:  EdgeInsets.only(top: height/1.79),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        print("Get Started");
                        var document = await _firestore2db.collection("Schools").get();
                        print(document.docs.length);
                        for(int i=0;i<document.docs.length;i++) {
                          print(document.docs[i]["schoolID"]);
                          if (schoolid.text == document.docs[i]["schoolID"]) {
                            print(document.docs[i]["schoolID"]);
                            initPlatformState(document.docs[i]["appurl"],document.docs[i]["schoolID"]);
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) =>
                                Intro_Page(document.docs[i]["schoolID"]),));
                          }
                        }
                      },
                      child: Container(
                        width: width/1.125,
                        height: height/12.6,
                        decoration: BoxDecoration(color: Color(0xff0271C5).withOpacity(0.80),

                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Color(0xff0271C5).withOpacity(0.80),)
                        ),
                        child: Center(
                            child: Text("Get Started", style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: width/20.84,
                                color: Colors.white
                            ),)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}



///After school ID Navigate to this page
class Intro_Page extends StatefulWidget {
  String schoolID;
   Intro_Page(this.schoolID);

  @override
  State<Intro_Page> createState() => _Intro_PageState();
}
class _Intro_PageState extends State<Intro_Page> {

  @override
  void initState() {
    constants = Constants(widget.schoolID);
    getdeviceid();
    // TODO: implement initState
    super.initState();
  }
  late Constants constants;

  getdeviceid()async{
    print("Welcome");
    print(constants.firebaseAuth2db?.currentUser);
    if(constants.firebaseAuth2db?.currentUser!=null){
      var getdate=await constants.firestore2db?.collection('deviceid').where("id",isEqualTo: constants.firebaseAuth2db?.currentUser!.uid).where("type",isEqualTo:"Student" ).get();
      var getdate2=await constants.firestore2db?.collection('deviceid').where("id",isEqualTo: constants.firebaseAuth2db?.currentUser!.uid).where("type",isEqualTo:"Teacher" ).get();
      if(getdate!.docs.length>0){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Student_landing_Page("",false,widget.schoolID),));
      }
      else if(getdate2!.docs.length>0){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage(widget.schoolID),));
      }
    }
    else{
      print("Login Page");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Accountpage(widget.schoolID)));
     // Otppage("9176463821", "Teacher", "e71KBP6ky3KnurZlHpfZ"),
     // Otppage("9941123453", "Student", "i570pkx8k9u78gea"),
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}





FirebaseApp _firstApp = Firebase.app('FirstApp');
final FirebaseFirestore _firestoredb = FirebaseFirestore.instance;
FirebaseFirestore _firestore2db = FirebaseFirestore.instanceFor(app: _firstApp);
FirebaseAuth _firebaseauth2db = FirebaseAuth.instanceFor(app: _firstApp);


/*class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({super.key});

  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint:  Row(
              children: [
                Icon(
                  Icons.list,
                  size: width/22.5,
                  color: Colors.black,
                ),
                SizedBox(
                  width: width/90,
                ),
                Expanded(
                  child: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: width/25.714,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style:  TextStyle(
                  fontSize: width/25.714,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ))
                .toList(),
            value: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
              });
            },
            buttonStyleData: ButtonStyleData(
              height: height/15.12,
              width: width/2.25,
              padding:  EdgeInsets.only(left: width/25.714, right: width/25.714),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),

                color: Color(0xffebf4fb),
              ),

            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffebf4fb),
              ),

              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(7),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData:  MenuItemStyleData(
              height: height/18.9,
              padding: EdgeInsets.only(left: width/25.714, right: width/25.714),
            ),
          ),
        ),
      ),
    );
  }
}*/
