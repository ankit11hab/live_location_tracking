import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _password;
  Future<void> _createUser() async{
    try{
      UserCredential userCredential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch(e) {
      print("Error: ${e}");
    } catch (e) {
      print("Error: ${e}");
    }
  }

  Future<void> _login() async{
    try{
      UserCredential userCredential = await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch(e) {
      print("Error: ${e}");
    } catch (e) {
      print("Error: ${e}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,32,0,0),
              child: TextField(
                  onChanged: (value) {
                    _email = value;
                  },
                decoration: InputDecoration(
                  hintText: "Enter Email"
                )
              ),
            ),
            TextField(
              onChanged: (value) {
                _password = value;
              },
                decoration: InputDecoration(
                    hintText: "Enter Password"
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16,32,16,0),
              child: ElevatedButton(
                  onPressed: _login,
                  child: Text("Login")
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: MaterialButton(
                  onPressed: _createUser,
                  child: Text("Create a new user")
              ),
            ),
              //child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                //children: [
                  //ElevatedButton(
                      //onPressed: _login,
                      //child: Text("Login")
                  //),
                  //MaterialButton(
                    //onPressed: _createUser,
                    //child: Text("Create new account")
                  //)
                //]
              //),
            //)
          ],
        ),
      )
    );
  }
}
