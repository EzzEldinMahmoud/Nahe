import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project/Widgets/schedulewidget.dart';
import 'package:project/models/appointments/Appointments.dart';
import 'package:project/screens/cubit.dart';
import 'package:project/screens/settings.dart';
import 'package:project/screens/states/loginstates.dart';

import '../network/remote/local/cachehelper.dart';

class appointmentpage extends StatefulWidget {
  appointmentpage({Key? key}) : super(key: key);

  @override
  State<appointmentpage> createState() => _appointmentpageState();
}

class _appointmentpageState extends State<appointmentpage> {
  late List appointmentmodelARC;
  late List appointmentmodelUP;
  String Baseurl = 'http://192.168.42.209:80';
  String photo = '';
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => appcubit(appinitialstate())
        ..getappointments(Token: StorageUtil.getString('token'))
        ..gethome(Token: StorageUtil.getString('token')),
      child: BlocConsumer<appcubit, appstate>(
        listener: (context, state) {
          if (state is appappointmentstatesuccess) {
            appointmentmodelARC =
                state.appointmentmodel.data.archivedAppointments;
            appointmentmodelUP =
                state.appointmentmodel.data.upcomingAppointments;
          }
          if (state is apphomestatesuccess) {
            photo = state.homemodel.data.user.photo;
          }
        },
        builder: (context, state) {
          return Material(
              child: SingleChildScrollView(
                  child: ConditionalBuilder(
            fallback: (context) {
              return Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            },
            condition: state is! appappointmentstateloading,
            builder: (context) {
              return Column(children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 40, left: 20, right: 20, bottom: 10),
                        child: Text(
                          "Appointments",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(""),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 35, left: 20, right: 20),
                        child: GestureDetector(
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
                                      backgroundImage:
                                          NetworkImage(Baseurl + photo),
                                    ),
                                  ));
                            },
                            condition: state is! apploadingstate,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                      child: Text(
                        "Upcoming",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 1,
                  child: ListView.builder(
                    itemCount: appointmentmodelUP.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          int appointmentid = appointmentmodelUP[index].id;
                          int id = appointmentmodelUP[index].agent.id;

                          StorageUtil.putString(
                              'appointmentid', appointmentid.toString());
                          StorageUtil.putString('id', id.toString());
                          // ignore: avoid_single_cascade_in_expression_statements
                          appcubit.get(context)
                            ..GETAGENTDATADETAILS(
                                ID: id, Token: StorageUtil.getString('token'))
                            ..GETAGENTDATADETAILS(
                                ID: appointmentid,
                                Token: StorageUtil.getString('token'));
                          showBarModalBottomSheet(
                              expand: false,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => upcomingappointments());
                        },
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.16,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  margin: EdgeInsets.all(5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffffEEF6F6),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.22,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: new DecorationImage(
                                                image: new NetworkImage(
                                                    Baseurl +
                                                        appointmentmodelUP[
                                                                index]
                                                            .agent
                                                            .photo),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 15,
                                          height: 10,
                                        ),
                                        Container(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              appointmentmodelUP[index]
                                                          .status ==
                                                      1
                                                  ? 'Pending'
                                                  : appointmentmodelUP[index]
                                                              .status ==
                                                          2
                                                      ? 'Confirmed'
                                                      : appointmentmodelUP[
                                                                      index]
                                                                  .status ==
                                                              3
                                                          ? 'Canceled'
                                                          : appointmentmodelUP[
                                                                          index]
                                                                      .status ==
                                                                  4
                                                              ? 'Completed'
                                                              : '',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              appointmentmodelUP[index]
                                                  .agent
                                                  .name,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              appointmentmodelUP[index]
                                                  .agent
                                                  .occupation
                                                  .title,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                            Expanded(
                                              child: Text(""),
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
                                                      0.27,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xffff00A8A3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .calendar_month_sharp,
                                                        color: Colors.white,
                                                        size: 17,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        appointmentmodelUP[
                                                                index]
                                                            .date,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.03,
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.03,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.23,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xffff00A8A3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .access_alarm_sharp,
                                                        color: Colors.white,
                                                        size: 17,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        appointmentmodelUP[
                                                                index]
                                                            .time,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
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
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                      child: Text(
                        "Archieved",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width * 1,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: appointmentmodelARC.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          int appointmentid = appointmentmodelARC[index].id;
                          int id = appointmentmodelUP[index].agent.id;
                          StorageUtil.putString(
                              'appointmentid', appointmentid.toString());
                          StorageUtil.putString('id', id.toString());
                          // ignore: avoid_single_cascade_in_expression_statements
                          appcubit.get(context)
                            ..GETAGENTDATADETAILS(
                                ID: id, Token: StorageUtil.getString('token'))
                            ..GETAGENTDATADETAILS(
                                ID: appointmentid,
                                Token: StorageUtil.getString('token'));
                          showBarModalBottomSheet(
                              expand: false,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => upcomingappointments());
                        },
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  margin: EdgeInsets.all(5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffffEEF6F6),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.22,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: new DecorationImage(
                                                image: new NetworkImage(
                                                    Baseurl +
                                                        appointmentmodelARC[
                                                                index]
                                                            .agent
                                                            .photo),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 15,
                                          height: 10,
                                        ),
                                        Container(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              appointmentmodelARC[index]
                                                          .status ==
                                                      1
                                                  ? 'Pending'
                                                  : appointmentmodelARC[index]
                                                              .status ==
                                                          2
                                                      ? 'Confirmed'
                                                      : appointmentmodelARC[
                                                                      index]
                                                                  .status ==
                                                              3
                                                          ? 'Canceled'
                                                          : appointmentmodelARC[
                                                                          index]
                                                                      .status ==
                                                                  4
                                                              ? 'Completed'
                                                              : '',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              appointmentmodelARC[index]
                                                  .agent
                                                  .name,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              appointmentmodelARC[index]
                                                  .agent
                                                  .occupation
                                                  .title,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                            Expanded(
                                              child: Text(""),
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
                                                      0.27,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xffff00A8A3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .calendar_month_sharp,
                                                        color: Colors.white,
                                                        size: 17,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        appointmentmodelARC[
                                                                index]
                                                            .date,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.03,
                                                ),
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
                                                      color:
                                                          Color(0xffff00A8A3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .access_alarm_sharp,
                                                        color: Colors.white,
                                                        size: 17,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        appointmentmodelARC[
                                                                index]
                                                            .time,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
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
                )
              ]);
            },
          )));
        },
      ),
    );
  }
}
