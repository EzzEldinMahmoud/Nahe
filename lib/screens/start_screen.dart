import 'package:flutter/material.dart';
import 'package:project/network/remote/local/cachehelper.dart';
import 'package:project/screens/sign_page.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/signuppage.dart';

class first_form extends StatefulWidget {
  first_form({Key? key}) : super(key: key);

  @override
  _first_formState createState() => _first_formState();
}

class _first_formState extends State<first_form> {
  @override
  void initState() {
    super.initState();
  }

  var _formKey = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          child: SingleChildScrollView(
            child: Stack(children: [
              Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 37, 43, 1)
                                  .withOpacity(1), //color of shadow
                              spreadRadius: 10, //spread radius
                              blurRadius: 10, // blur radius
                              offset:
                                  Offset(0, 2), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            )
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [1, 0],
                            colors: <Color>[
                              Color.fromRGBO(0, 37, 43, 1),
                              Colors.white
                            ],
                            tileMode: TileMode
                                .clamp, // clamp the gradient over the canvas
                          ),
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25))),
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: Text(
                                  "Nähe",
                                  style: TextStyle(
                                      fontSize: 80,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              FlatButton(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.8,
                                onPressed: () {
                                  if (StorageUtil.getString('token').isEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => signin_form()));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => homeScreen()));
                                  }
                                },
                                color: const Color.fromRGBO(0, 168, 165, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FlatButton(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: const Color.fromRGBO(
                                            0, 168, 165, 1),
                                        width: 1,
                                        style: BorderStyle.solid)),
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.8,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => signup_form()));
                                },
                                color: Colors.white,
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 168, 165, 1),
                                      fontSize: 19),
                                ),
                              ),
                            ],
                          ))
                    ],
                  )),
              Center(
                child: Container(
                  transform: Matrix4.translationValues(
                      MediaQuery.of(context).size.width * 0.01,
                      MediaQuery.of(context).size.height * 0.16,
                      0),
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/1.png')),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
