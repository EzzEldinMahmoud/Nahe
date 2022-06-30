import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/models/AUTH MODELS/user_info.dart';
import 'package:project/network/remote/local/cachehelper.dart';
import 'package:project/screens/constants.dart';
import 'package:project/screens/cubit.dart';
import 'package:project/screens/sign_page.dart';
import 'package:project/screens/states/loginstates.dart';
import 'package:project/screens/states/settingsstates.dart';

class settingsScreen extends StatefulWidget {
  settingsScreen({Key? key}) : super(key: key);

  @override
  State<settingsScreen> createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController password = TextEditingController();
  String photohere = '';
  String Baseurl = 'http://192.168.42.209:80';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => appcubit(appinitialstate())
        ..getuserdata(Token: StorageUtil.getString('token'))
        ..gethome(Token: StorageUtil.getString('token')),
      child: BlocConsumer<appcubit, appstate>(
        listener: (context, state) {
          if (state is appsuccessstate) {
            name.text = state.userdata.data.user.name;
            address.text = state.userdata.data.user.address;
            phonenumber.text = state.userdata.data.user.phoneNumber;

            print(state.userdata.data.user.photo);
          }
          if (state is apphomestatesuccess) {
            photohere = state.homemodel.data.user.photo;
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            builder: ((context) => Material(child: SafeArea(
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height * 0.98,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Column(children: [
                          Container(
                              padding: EdgeInsets.all(8),
                              child: Row(children: [
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(""),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: ConditionalBuilder(
                                    fallback: (context) => Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.transparent),
                                    ),
                                    builder: (context) {
                                      return Padding(
                                          padding: EdgeInsets.only(
                                              top: 0, left: 0, right: 0),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  Baseurl + photohere),
                                            ),
                                          ));
                                    },
                                    condition: state is! apploadingstate,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ])),
                          Form(
                              key: _formKey,
                              child: ConditionalBuilder(
                                condition: state is! AppsettingLoadingState,
                                fallback: (BuildContext context) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.green),
                                  );
                                },
                                builder: (BuildContext context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 30, right: 30),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                " Name ",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(height: 13),
                                              TextFormField(
                                                controller: name,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  isDense: true, // Added this
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 25,
                                                          horizontal: 10),
                                                  fillColor: Color.fromRGBO(
                                                      238, 247, 246, 1),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2),
                                                  ),

                                                  hintText: '',
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              const Text(
                                                " Address ",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(height: 13),
                                              TextFormField(
                                                controller: address,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  isDense: true, // Added this
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 25,
                                                          horizontal: 10),
                                                  fillColor: Color.fromRGBO(
                                                      238, 247, 246, 1),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2),
                                                  ),

                                                  hintText: '',
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              const Text(
                                                " Phone Number ",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(height: 13),
                                              TextFormField(
                                                controller: phonenumber,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  isDense: true, // Added this
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 25,
                                                          horizontal: 10),
                                                  fillColor: Color.fromRGBO(
                                                      238, 247, 246, 1),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2),
                                                  ),

                                                  hintText: '',
                                                ),
                                              ),
                                            ],
                                          ))
                                    ],
                                  );
                                },
                              )),
                          Expanded(child: Text("")),
                          Container(
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.only(bottom: 25),
                              child: FlatButton(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.9,
                                onPressed: () {
                                  List values = address.text.split(
                                      ","); // split() will split from . and gives new List with separated elements.
                                  values.forEach(print);
                                  appcubit.get(context).userinfoupdate(
                                      phone_number: phonenumber.text,
                                      name: name.text,
                                      street: values[0],
                                      district: values[1],
                                      city: values[2],
                                      Token: StorageUtil.getString('token'));
                                  print(appcubit
                                      .get(context)
                                      .userget!
                                      .data
                                      .user
                                      .name);
                                  setState(() {
                                    var userinfohere = appcubit
                                        .get(context)
                                        .usermodel!
                                        .data
                                        .user;
                                    name.text = userinfohere.name;
                                    address.text = userinfohere.address;
                                    phonenumber.text = userinfohere.phoneNumber;
                                  });
                                },
                                color: const Color.fromRGBO(0, 168, 165, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  "Update",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19),
                                ),
                              )),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: FlatButton(
                              height: MediaQuery.of(context).size.height * 0.06,
                              minWidth: MediaQuery.of(context).size.width * 0.9,
                              onPressed: () {
                                signout(context);
                              },
                              color: const Color.fromARGB(190, 168, 7, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                "Logout",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ]),
                      ),
                    );
                  }),
                ))),
            condition: state is! apploadingstate,
            fallback: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(
                    color: const Color.fromRGBO(0, 168, 165, 1)),
              );
            },
          );
        },
      ),
    );
  }
}

// // scaffold(
// //             body: Column(children: [
// //       Container(
// //         padding: EdgeInsets.all(20),
// //         height: 125,
// //         width: MediaQuery.of(context).size.height * 0.5,
// //         child: Row(
// //           children: [
// //             Padding(
// //               padding:
// //                   EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
// //               child: Text(
// //                 "Hey, Sarah",
// //                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
// //               ),
// //             ),
// //             Expanded(
// //               child: Text(""),
// //             ),
// //             Padding(
// //                 padding: EdgeInsets.only(top: 35, left: 20, right: 20),
// //                 child: CircleAvatar(
// //                   backgroundColor: Color.fromRGBO(187, 250, 231, 1),
// //                   backgroundImage: AssetImage(''),
// //                 ))
// //           ],
// //         ),
// //       ),
String? validateMobile(String? value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(patttern);
  if (value?.length == 0) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value!)) {
    return 'Please enter valid mobile number';
  }
  return null;
}
