

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

int selectedIndexvalue=0;


bool navigation=false;

String demotext="""A computer is a machine that can be programmed to carry out sequences of arithmetic or logical operations (computation) automatically. Modern digital electronic computers can perform generic sets of operations known as programs. These programs enable computers to perform a wide range of tasks. A computer system is a nominally complete computer that includes the hardware, operating system (main software), and peripheral equipment needed and used for full operation. This term may also refer to a group of computers that are linked and function together, such as a computer network or computer cluster.

A broad range of industrial and consumer products use computers as control systems. Simple special-purpose devices like microwave ovens and remote controls are included, as are factory devices like industrial robots and computer-aided design, as well as general-purpose devices like personal computers and mobile devices like smartphones. Computers power the Internet, which links billions of other computers and users.""";

class Constants {
  FirebaseAuth? _firebaseauth2db;
  FirebaseFirestore? _firestore2db;
  FirebaseStorage? _firestorage2db;

  Constants(String schoolID) {
    FirebaseApp _firstApp = Firebase.app('FirstApp');
    if (schoolID == "VDRAVEN") {
      FirebaseApp _secondaryApp = Firebase.app('SecondaryApp');
      _firestore2db = FirebaseFirestore.instanceFor(app: _secondaryApp);
      _firestorage2db = FirebaseStorage.instanceFor(app: _secondaryApp);
      _firebaseauth2db = FirebaseAuth.instanceFor(app: _firstApp);
    }
    else if (schoolID == "VDSS") {
      FirebaseApp _thirdApp = Firebase.app('ThirdApp');
      _firestore2db = FirebaseFirestore.instanceFor(app: _thirdApp);
      _firestorage2db = FirebaseStorage.instanceFor(app: _thirdApp);
      _firebaseauth2db = FirebaseAuth.instanceFor(app: _firstApp);
    }
    else if (schoolID == "VDSKV") {
      FirebaseApp _forthApp = Firebase.app('ForthApp');
      _firestore2db = FirebaseFirestore.instanceFor(app: _forthApp);
      _firestorage2db = FirebaseStorage.instanceFor(app: _forthApp);
      _firebaseauth2db = FirebaseAuth.instanceFor(app: _firstApp);
    }

    else {
      // Handle default or error case
    }
  }

  FirebaseAuth? get firebaseAuth2db => _firebaseauth2db;
  FirebaseFirestore? get firestore2db => _firestore2db;
  FirebaseStorage? get firestorage2db => _firestorage2db;
}








