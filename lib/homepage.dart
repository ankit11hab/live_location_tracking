import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  String? _name, _uniqueid;
  Map? data;
  User? loggedInUser;
  final _auth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("data");
  //String? name, email, uid;




  void getCurrentUser() async{
    try {
      final user = _auth.currentUser;
      if(user!=null) {
        loggedInUser = user;
        print(loggedInUser);
      }
    }catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    getCurrentUser();
  }

  //Future<void> userdata() async {
    //final uid = loggedInUser!.uid;
    //DocumentSnapshot ds = await userCollection.doc(uid).get();
    //name = ds.get('name');
    //email = ds.get('email');
    //print(name);
    //print(email);
    //print(uid);
  //}
  CollectionReference users = FirebaseFirestore.instance.collection('data');
  Future<void> addUser() {
    return users
        .doc(loggedInUser!.uid)
        .set({"name": _name, "uniqueid": _uniqueid}).then((value)=>print("User Added"))
        .catchError((error)=>print("Failed to add user: $error"));
  }

  /*addData(){
    Map<String,dynamic> demoData = {"name":"Ankit Guha",
    "motto": "Hi there"};
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('data');
    collectionReference.add(demoData);
  }*/

  fetchData() {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('data');
    Stream documentStream= FirebaseFirestore.instance.collection('data').doc(loggedInUser!.uid).snapshots();
    print(FirebaseFirestore.instance.collection('data').doc(loggedInUser!.uid).get());
    documentStream.listen((snapshot){
      setState(() {
        data = snapshot.data() as Map?;
        print(data.toString());
      });
    });
    //collectionReference.snapshots().listen((snapshot) {
      //late List doc;
      //setState(() {
        //data = snapshot.docs[0].data() as Map?;
      //});
    //});
  }

  deleteData() async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('data');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.delete();
  }

  updateData() async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('data');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"name":"Sahil","motto":"Motu"});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                  data.toString()
              ),
              ElevatedButton (
                onPressed: fetchData,
                child: Text("View Details"),
              ),

              /*ElevatedButton (
                onPressed: addData,
                child: Text("Add Data"),
              ),

              ElevatedButton (
                onPressed: deleteData,
                child: Text("Delete Data"),
              ),
              ElevatedButton (
                onPressed: updateData,
                child: Text("Update Data"),
              ),*/
              //ElevatedButton (
                //onPressed: userdata,
                //child: Text("Show Data"),
              //),

              TextField(
                  onChanged: (value) {
                    _name = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Enter Name"
                  )
              ),
              TextField(
                  onChanged: (value) {
                    _uniqueid = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Enter Unique ID"
                  )
              ),
              ElevatedButton (
                onPressed: addUser,
                child: Text("Submit"),
              ),

              ElevatedButton (
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Text("Sign Out"),
              ),




            ]
          )
        ),
    );
  }
}
