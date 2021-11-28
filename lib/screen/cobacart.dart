import 'package:cubaapi/screen/regist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPaage extends StatefulWidget {
  const LoginPaage({Key? key}) : super(key: key);

  @override
  _LoginPaageState createState() => _LoginPaageState();
}

class _LoginPaageState extends State<LoginPaage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(
      child: Center(
        child: Stack(
        children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Form(child: formLogin()),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegistPage()),
                        );
                      },
                      child: Text(
                        "Don't have an account? Register",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
            // SizedBox(height: 20,),
            // // Stack(
            // //   children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50,10,10,10),
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(100))),
              ),
            ),
          ],
        ),
      ]),
      //formLogin(),
    )));
  }
}

Widget formLogin() {
  return Column(
    children: [
      TextFormField(
        keyboardType: TextInputType.text,
        //controller: emailControl,
        decoration: InputDecoration(
          labelText: 'Name',
          icon: Icon(Icons.person),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.lightGreen, width: 2)),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      TextFormField(
          keyboardType: TextInputType.text,
          // obscureText: _passHide,
          // controller: passControl2,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Password',
            icon: Icon(Icons.lock),
            suffixIcon: GestureDetector(child: Icon(Icons.verified)
                // _passHide ? Icons.visibility_off : Icons.visibility,
                // color: _passHide ? Colors.grey : Colors.blueAccent,
                ),
            // onTap: () {
            //   _password();
            // },
          )),
      SizedBox(
        height: 10,
      ),
      RaisedButton(
        onPressed: () {
          //_regist();
        },
        child: Text("Register"),
      ),

    ],
  );
}
