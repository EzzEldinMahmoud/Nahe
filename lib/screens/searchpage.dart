import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project/models/general models/homeModel.dart';
import 'package:project/screens/constants.dart';
import 'package:project/screens/settings.dart';
import 'package:project/screens/states/loginstates.dart';

import '../models/AUTH MODELS/user_info.dart';
import '../network/remote/local/cachehelper.dart';
import 'cubit.dart';

class searchpage extends StatefulWidget {
  searchpage({Key? key}) : super(key: key);

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  TextEditingController jobtitle = TextEditingController();
  String Baseurl = 'http://nahe.dhulfiqar.com';
  HOMEMODEL? hererimage;
  var lengthdate;
  bool showWidget = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appcubit(appsearchinitialstate())
        ..getuserdata(Token: StorageUtil.getString('token'))
        ..gethome(Token: StorageUtil.getString('token'))
        ..getsearchresult(
            jobtitle: jobtitle.text, Token: StorageUtil.getString('token')),
      child: BlocConsumer<appcubit, appstate>(
        listener: (context, state) {
          if (state is apphomestatesuccess) {
            hererimage = state.homemodel;
          }
          if (state is appsearchsuccessstate) {
            lengthdate = state.userdata.data.providers;
          }
        },
        builder: (context, state) {
          return Material(
            child: ConditionalBuilder(
              condition: state is! appsuccessstate,
              builder: (context) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 1,
                      width: MediaQuery.of(context).size.width * 1,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Search',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(child: Text('')),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return settingsScreen();
                                    }));
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(Baseurl +
                                        '/m/' +
                                        hererimage!.data.user.photo),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            onSubmitted: (value) {
                              appcubit.get(context).getsearchresult(
                                  jobtitle: jobtitle.text,
                                  Token: StorageUtil.getString('token'));
                              setState(() {
                                showWidget = !showWidget;
                              });
                            },
                            controller: jobtitle,
                            decoration: InputDecoration(
                              filled: true,
                              isDense: true,
                              focusColor: Colors.transparent, // Added this
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 22, horizontal: 10),
                              fillColor: Color.fromRGBO(238, 247, 246, 0.5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 2),
                              ),
                              hintText:
                                  'Search for electricians,plumbers,etc...',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showWidget = !showWidget;
                                  });
                                  appcubit.get(context).getsearchresult(
                                      jobtitle: jobtitle.text,
                                      Token: StorageUtil.getString('token'));
                                },
                                icon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          showWidget
                              ? ConditionalBuilder(
                                  condition: state is! appsearchloadingstate,
                                  builder: (context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.78,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: ListView.builder(
                                        itemCount: lengthdate!.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              int id = lengthdate![index].id;
                                              StorageUtil.putString(
                                                  'id',
                                                  lengthdate![index]
                                                      .id
                                                      .toString());

                                              appcubit
                                                  .get(context)
                                                  .GETAGENTDATADETAILS(
                                                      ID: id,
                                                      Token:
                                                          StorageUtil.getString(
                                                              'token'));
                                              showBarModalBottomSheet(
                                                  expand: false,
                                                  context: context,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  builder: (context) =>
                                                      bottomsheet());
                                            },
                                            child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.16,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 0),
                                                  child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      margin: EdgeInsets.all(4),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffffEEF6F6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.22,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage(Baseurl +
                                                                            lengthdate![index].photo),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      )),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                              height: 10,
                                                            ),
                                                            Container(
                                                                child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  lengthdate![
                                                                          index]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  lengthdate![
                                                                          index]
                                                                      .occupation
                                                                      .title,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Text(""),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.03,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.25,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .transparent,
                                                                          borderRadius:
                                                                              BorderRadius.circular(15)),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            lengthdate![index].rating,
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.yellow,
                                                                            size:
                                                                                17,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.03,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Container(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.03,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.2,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.transparent,
                                                                            borderRadius: BorderRadius.circular(15)),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Text(''),
                                                                              ),
                                                                              Text(
                                                                                " Details",
                                                                                style: TextStyle(color: Colors.black),
                                                                              ),
                                                                              Icon(
                                                                                Icons.arrow_forward_sharp,
                                                                                color: Colors.black,
                                                                                size: 17,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ))
                                                          ],
                                                        ),
                                                      )),
                                                )),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  fallback: (context) => Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.green),
                                      ))
                              : Container(
                                  child: Center(
                                      child: Text(
                                          "there aren't any agents near you ")),
                                ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              fallback: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.green),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
