import 'package:firebase_setup/Controllers/authController.dart';
import 'package:firebase_setup/Screens/ProfileImageView.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_image/firebase_image.dart';
import 'ProfileImageView.dart';

class Home extends GetWidget<AuthController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("FireBase Setup"),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              controller.signOut();
            },
          ),
        ],
      ),
      body: ProfileImageView(),
      // body: Builder(
      //   builder: (context) => Container(
      //     child: SingleChildScrollView(
      //       child: Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: Column(
      //           children: [
      //             SizedBox(
      //               height: 20.0,
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 ProfileImageView(),
      //               ],
      //             ),
      //             SizedBox(height: 30.0),
      //             Padding(
      //               padding: const EdgeInsets.only(bottom: 8.0),
      //               child: TextFormField(
      //                 decoration: InputDecoration(
      //                   labelText: "Name",
      //                   fillColor: Colors.white,
      //                   focusedBorder: OutlineInputBorder(
      //                     borderSide: BorderSide(
      //                       color: Colors.blue,
      //                       width: 2.0,
      //                     ),
      //                   ),
      //                 ),
      //                 onChanged: (String name) {
      //                   getStudentName(name);
      //                 },
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(bottom: 8.0),
      //               child: TextFormField(
      //                 decoration: InputDecoration(
      //                   labelText: "Student ID",
      //                   fillColor: Colors.white,
      //                   focusedBorder: OutlineInputBorder(
      //                     borderSide: BorderSide(
      //                       color: Colors.blue,
      //                       width: 2.0,
      //                     ),
      //                   ),
      //                 ),
      //                 onChanged: (String id) {
      //                   getStudentID(id);
      //                 },
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(bottom: 8.0),
      //               child: TextFormField(
      //                 decoration: InputDecoration(
      //                   labelText: "Study Program ID",
      //                   fillColor: Colors.white,
      //                   focusedBorder: OutlineInputBorder(
      //                     borderSide: BorderSide(
      //                       color: Colors.blue,
      //                       width: 2.0,
      //                     ),
      //                   ),
      //                 ),
      //                 onChanged: (String programID) {
      //                   getStudyProgramID(programID);
      //                 },
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(bottom: 8.0),
      //               child: TextFormField(
      //                 decoration: InputDecoration(
      //                   labelText: "GPA",
      //                   fillColor: Colors.white,
      //                   focusedBorder: OutlineInputBorder(
      //                     borderSide: BorderSide(
      //                       color: Colors.blue,
      //                       width: 2.0,
      //                     ),
      //                   ),
      //                 ),
      //                 onChanged: (String gpa) {
      //                   getStudentGPA(gpa);
      //                 },
      //               ),
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Expanded(
      //                   flex: 4,
      //                   child: Container(
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(2),
      //                       child: RaisedButton(
      //                         color: Colors.green,
      //                         shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(16.0),
      //                         ),
      //                         child: Text("Create"),
      //                         textColor: Colors.white,
      //                         onPressed: () {
      //                           createData();
      //                         },
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.symmetric(vertical: 2),
      //               child: Row(
      //                 children: [
      //                   Expanded(
      //                     child: Text(
      //                       'Name',
      //                       style: TextStyle(
      //                         color: Colors.orange,
      //                       ),
      //                     ),
      //                   ),
      //                   Expanded(
      //                     child: Text(
      //                       'Student ID',
      //                       style: TextStyle(
      //                         color: Colors.orange,
      //                       ),
      //                     ),
      //                   ),
      //                   Expanded(
      //                     child: Text(
      //                       'Program ID',
      //                       style: TextStyle(
      //                         color: Colors.orange,
      //                       ),
      //                     ),
      //                   ),
      //                   Expanded(
      //                     child: Text(
      //                       'GPA',
      //                       style: TextStyle(
      //                         color: Colors.orange,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             StreamBuilder(
      //               stream: FirebaseFirestore.instance
      //                   .collection("MyCollege")
      //                   .snapshots(),
      //               builder: (context, snapshot) {
      //                 if (snapshot.hasData) {
      //                   return ListView.builder(
      //                     shrinkWrap: true,
      //                     itemCount: snapshot.data.documents.length,
      //                     itemBuilder: (context, index) {
      //                       DocumentSnapshot documentSnapshot =
      //                           snapshot.data.documents[index];
      //                       return Row(
      //                         children: [
      //                           Expanded(
      //                             child: Text(documentSnapshot["studentName"]),
      //                           ),
      //                           Expanded(
      //                             child: Text(documentSnapshot["studentID"]),
      //                           ),
      //                           Expanded(
      //                             child:
      //                                 Text(documentSnapshot["studenProgramID"]),
      //                           ),
      //                           Expanded(
      //                             child: Text(documentSnapshot["studentGPA"]
      //                                 .toString()),
      //                           ),
      //                           Expanded(
      //                             child: Image(
      //                               image: FirebaseImage(
      //                                   'gs://fir-c997d.appspot.com/image_picker5370766075587000895.jpg',
      //                                   shouldCache:
      //                                       true, // The image should be cached (default: True)
      //                                   maxSizeBytes: 3000 *
      //                                       1000, // 3MB max file size (default: 2.5MB)
      //                                   cacheRefreshStrategy: CacheRefreshStrategy
      //                                       .NEVER // Switch off update checking
      //                                   ),
      //                               width: 100,
      //                             ),
      //                           ),
      //                           Expanded(
      //                             flex: 1,
      //                             child: Container(
      //                               child: Padding(
      //                                 padding: const EdgeInsets.all(1),
      //                                 child: IconButton(
      //                                   icon: Icon(Icons.delete),
      //                                   color: Colors.red,
      //                                   onPressed: () {
      //                                     deleteData(documentSnapshot['uID']);
      //                                   },
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       );
      //                     },
      //                   );
      //                 } else {
      //                   return Align(
      //                     alignment: FractionalOffset.bottomCenter,
      //                     child: CircularProgressIndicator(),
      //                   );
      //                 }
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
