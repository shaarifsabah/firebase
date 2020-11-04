import 'dart:io';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

class ProfileImageView extends StatefulWidget {
  @override
  _ProfileImageViewState createState() => _ProfileImageViewState();
}

class _ProfileImageViewState extends State<ProfileImageView> {
  File images;
  final ImagePicker _picker = ImagePicker();
  String studentName, studentID, check, studyProgramID, imageUrl;
  double studentGPA;
  var uuid = Uuid();

  createData() {
    if (studentName != null) {
      //   profileImageView.images;
      check = uuid.v1();
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("MyStudents").doc(check);

      Map<String, dynamic> students = {
        "studentName": studentName,
        "studentID": studentID,
        "studenProgramID": studyProgramID,
        "studentGPA": studentGPA,
        "uID": check,
        "image": imageUrl,
      };
      documentReference
          .set(students)
          .whenComplete(() => {print("$images Document Created")});
      //  print("The image is $images");
    }
  }

  Future getImage() async {
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      images = File(image.path);
      print('Image Path $images');
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(images.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(images);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    imageUrl = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      print("Profile Picture uploaded $images");
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Profile Picture Uploaded $images')));
    });
  }

  // readData() {
  //   DocumentReference documentReference =
  //       FirebaseFirestore.instance.collection("MyCollege").doc(studentName);
  //   documentReference.get().then((datasnapshot) {
  //     print(datasnapshot.get("studentName"));
  //     print(datasnapshot.get("studentID"));
  //     print(datasnapshot.get("studenProgramID"));
  //     print(datasnapshot.get("studentGPA"));
  //   });
  // }

  updateData() {
    if (studentName != null) {
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("MyStudents").doc(check);
      Map<String, dynamic> students = {
        "studentName": studentName,
        "studentID": studentID,
        "studenProgramID": studyProgramID,
        "studentGPA": studentGPA,
      };
      documentReference
          .set(students)
          .whenComplete(() => {print("$studentName document Updated")});
    }
  }

  deleteData(String data) {
    if (studentName != null) {
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("MyStudents").doc(data);
      documentReference
          .delete()
          .whenComplete(() => {print("$studentName document Deleted")});
    }
  }

  getStudentName(name) {
    this.studentName = name;
  }

  getStudentID(id) {
    this.studentID = id;
  }

  getStudyProgramID(programID) {
    this.studyProgramID = programID;
  }

  getStudentGPA(gpa) {
    this.studentGPA = double.parse(gpa);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Builder(
            builder: (context) => Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Column(children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 95,
                              backgroundColor: Colors.pinkAccent,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 180.0,
                                  height: 180.0,
                                  child: (images != null)
                                      ? Image.file(
                                    images,
                                    fit: BoxFit.fill,
                                  )
                                      : Image.network(
                                    "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 100.0,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 30.0,
                                ),
                                onPressed: () async {
                                  await getImage();
                                  uploadPic(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Name",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        onChanged: (String name) {
                          getStudentName(name);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Student ID",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        onChanged: (String id) {
                          getStudentID(id);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Study Program ID",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        onChanged: (String programID) {
                          getStudyProgramID(programID);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "GPA",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        onChanged: (String gpa) {
                          getStudentGPA(gpa);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: RaisedButton(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Text("Create"),
                                textColor: Colors.white,
                                onPressed: () {
                                  createData();
                                },
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 4,
                        //   child: Container(
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(2),
                        //       child: RaisedButton(
                        //         color: Colors.blue,
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(16.0),
                        //         ),
                        //         child: Text("Read"),
                        //         textColor: Colors.white,
                        //         onPressed: () {
                        //           readData();
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Expanded(
                        //   flex: 4,
                        //   child: Container(
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(2),
                        //       child: RaisedButton(
                        //         color: Colors.orange,
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(16.0),
                        //         ),
                        //         child: Text("update"),
                        //         textColor: Colors.white,
                        //         onPressed: () {
                        //           updateData();
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Name',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'S_ID',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'P_ID',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'GPA',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'update',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'delete',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("MyStudents")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot documentSnapshot =
                              snapshot.data.documents[index];
                              return Row(
                                children: [
                                  Expanded(
                                    child:
                                    Text(documentSnapshot["studentName"]),
                                  ),
                                  Expanded(
                                    child: Center(
                                        child: Text(
                                            documentSnapshot["studentID"])),
                                  ),
                                  Expanded(
                                    child: Text(
                                        documentSnapshot["studenProgramID"]),
                                  ),
                                  Expanded(
                                    child: Text(documentSnapshot["studentGPA"]
                                        .toString()),
                                  ),
                                  Expanded(
                                    child: Image.network(
                                        documentSnapshot["image"],
                                        fit: BoxFit.fill),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: IconButton(
                                          color: Colors.orange,
                                          icon: Icon(
                                            Icons.edit,
                                            size: 30.0,
                                          ),
                                          onPressed: () {
                                            updateData();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: IconButton(
                                          color: Colors.red,
                                          icon: Icon(
                                            Icons.delete,
                                            size: 30.0,
                                          ),
                                          onPressed: () {
                                            deleteData(documentSnapshot['uID']);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          return Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}