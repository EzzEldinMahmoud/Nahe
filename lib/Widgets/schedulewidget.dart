import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/models/appointments/appointinvoicemodel.dart';
import 'package:project/network/remote/diohelper.dart';
import 'package:project/network/remote/end_points.dart';
import 'package:project/splash/flutter_rating_stars.dart';
import 'package:project/splash/src/internet_file.dart';
import 'package:readmore/readmore.dart';
import 'package:toast/toast.dart';

import '../models/appointments/APPOINTMENTSdetails.dart';
import '../network/remote/local/cachehelper.dart';
import '../screens/constants.dart';
import '../screens/cubit.dart';
import '../screens/states/loginstates.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../splash/src/rating_bar.dart';
import '../splash/src/storage_io.dart';

class scheduleAppointment extends StatefulWidget {
  scheduleAppointment({
    Key? key,
  }) : super(key: key);

  @override
  State<scheduleAppointment> createState() => _scheduleAppointmentState();
}

class _scheduleAppointmentState extends State<scheduleAppointment> {
  List? agentmodel;

  String? providerdetails;

  String? providerdetailsname;

  String? providerdetailsphoto;

  String? providerdetailsrating;

  String? providerdetailsaddress;

  String? providerdetailsphonenumber;
  int? providerdetailsID;

  List? values;

  List? values2;

  String Baseurl = 'http://192.168.42.209:80';

  int id = int.parse(StorageUtil.getString('id'));
  var Date = TextEditingController();
  var Time = TextEditingController();
  var Paymentmethod = TextEditingController();
  var Details = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => appcubit(appservicedetailsinitialstate())
          ..GETAGENTDATADETAILS(ID: id, Token: StorageUtil.getString('token')),
        child: BlocConsumer<appcubit, appstate>(listener: (Context, State) {
          if (State is appservicedetailsuccessstate) {
            agentmodel = State.userdata.data.reviews;
            providerdetailsname = State.userdata.data.provider.name;
            providerdetailsphoto = State.userdata.data.provider.photo;
            providerdetailsrating = State.userdata.data.provider.rating;
            providerdetailsaddress = State.userdata.data.provider.address;
            providerdetailsphonenumber =
                State.userdata.data.provider.phoneNumber;
            providerdetails = State.userdata.data.provider.occupation.title;
            providerdetailsID = State.userdata.data.provider.id;
            values = providerdetailsaddress!.split(",");
            values!.forEach(print);
            values2 = values![2]!.split(",");
            values!.forEach(print);
          }
        }, builder: (Context, State) {
          return SingleChildScrollView(
              child: ConditionalBuilder(
            fallback: (context) => Center(
              child: CircularProgressIndicator(color: Colors.green),
            ),
            builder: (Context) {
              return Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade600,
                              spreadRadius: 1,
                              blurRadius: 10,
                              blurStyle: BlurStyle.outer,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        height: MediaQuery.of(context).size.height * 1,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Scheduling",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Agent",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 0.0, 0.0),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(Baseurl +
                                                  providerdetailsphoto!),
                                              fit: BoxFit.fill)),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 0.0, 0.0),
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              providerdetails!,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              providerdetailsname!,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 20,
                                              child: ratingstars(
                                                double.parse(
                                                    providerdetailsrating!),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_sharp,
                                                  color: Colors.red,
                                                ),
                                                Text(
                                                  values![0],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                ),Text(''),
                                                Text(
                                                  values![1],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  softWrap: true,
                                                ),

                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  values2![0],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                  child: Form(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Details',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Date',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    GestureDetector(
                                      onTap: () {},
                                      child: TextFormField(
                                        controller: Date,
                                        onTap: () {
                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime(2022, 3, 5),
                                              maxTime: DateTime(2023, 12, 28),
                                              onChanged: (date) {
                                            print('change $date');
                                          }, onConfirm: (date) {
                                            var datenow =
                                                date.toString().split(" ");
                                            datenow.forEach(print);
                                            print('confirm $date');
                                            setState(() {
                                              Date.text = datenow[0].toString();
                                            });
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.en);
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          hintText: 'Enter Date.',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                              238, 248, 245, 0.5),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Time',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    GestureDetector(
                                      onTap: () {},
                                      child: TextFormField(
                                        onTap: () {
                                          DatePicker.showTimePicker(context,
                                              showTitleActions: true,
                                              onChanged: (date) {
                                            print('change $date in time zone ' +
                                                date.timeZoneOffset.inHours
                                                    .toString());
                                          }, onConfirm: (date) {
                                            var timenow =
                                                date.toString().split(" ");
                                            timenow.forEach(print);
                                            var timewithoutmini = timenow[1]
                                                .toString()
                                                .split(".");
                                            timewithoutmini.forEach(print);
                                            print('confirm $date');
                                            setState(() {
                                              Time.text =
                                                  timewithoutmini[0].toString();
                                            });
                                          }, currentTime: DateTime.now());
                                        },
                                        controller: Time,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          hintText: 'Enter Time.',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                              238, 248, 245, 0.5),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Payment Method',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    GestureDetector(
                                      onTap: () {
                                        Paymentmethod.text = 'Cash';
                                      },
                                      child: TextFormField(
                                        enabled: false,
                                        onTap: () {
                                          Paymentmethod.text = 'Cash';
                                        },
                                        controller: Paymentmethod,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.expand_more,
                                            color: Colors.black,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          hintText: 'Choose Payment.',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                              238, 248, 245, 0.5),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Details',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    TextFormField(
                                      controller: Details,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        hintText: 'Enter details.',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor:
                                            Color.fromRGBO(238, 248, 245, 0.5),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                              ConditionalBuilder(
                                condition: State is! appscheduleloadingstate,
                                fallback: (context) => Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.green),
                                ),
                                builder: (Context) {
                                  return Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: 2, bottom: 20),
                                              child: FlatButton(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                                minWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.38,
                                                onPressed: () {
                                                  appcubit
                                                      .get(context)
                                                      .scheduleappointment(
                                                          agent_id:
                                                              providerdetailsID!,
                                                          date: Date.text,
                                                          time: Time.text,
                                                          payment_method:
                                                              Paymentmethod
                                                                          .text ==
                                                                      'Cash'
                                                                  ? 1
                                                                  : 1,
                                                          details: Details.text,
                                                          Token: StorageUtil
                                                              .getString(
                                                                  'token'));
                                                  EasyLoading.showToast(
                                                      "Successfully scheduled your next appointment",
                                                      toastPosition:
                                                          EasyLoadingToastPosition
                                                              .bottom);
                                                },
                                                color: Color.fromRGBO(
                                                    0, 168, 165, 0.85),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "Schedule",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 19),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Expanded(
                                            child: Text(''),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: 2, bottom: 20),
                                              child: FlatButton(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                                minWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.38,
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                color: Color.fromARGB(
                                                    190, 170, 25, 25),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                        color: Color.fromARGB(
                                                            137, 170, 25, 25))),
                                                child: Row(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 19),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ));
                                },
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ]))
                  ],
                ),
              );
            },
            condition: State is! appservicedetailloadingstate,
          ));
        }));
  }
}

class upcomingappointments extends StatefulWidget {
  upcomingappointments({
    Key? key,
  }) : super(key: key);

  @override
  State<upcomingappointments> createState() => _upcomingappointmentsState();
}

class _upcomingappointmentsState extends State<upcomingappointments> {
  List? agentmodel;
  String? providerdetails;
  String? pdflink;
  String? providerdetailsname;

  String? providerdetailsphoto;

  String? providerdetailsrating;
  Future<Directory?>? _downloadsDirectory;

  String? providerdetailsaddress;

  String? providerdetailsphonenumber;
  int? providerdetailsID;

  List? values;
  List? values5;
  List? values2;
  APPOINTMENTSDETAILS? appointmentmodelhere;
  int? appointmentmodelhereSTATUS;
  String? appointmentmodelhereTIME;
  String? appointmentmodelhereDATE;
  String? appointmentmodelhereDETAILS;
  int? appointmentmodelherePAYMENTMETHOD;
  Appointmentinvoicemodel? invoicemodel;
  Future<String> get _localpath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  String Baseurl = 'http://192.168.42.209:80';

  int id = int.parse(StorageUtil.getString('id'));
  int appointmentid = int.parse(StorageUtil.getString('appointmentid'));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => appcubit(appservicedetailsinitialstate())
          ..GETAGENTDATADETAILS(ID: id, Token: StorageUtil.getString('token'))
          ..GETAPPOINTMENTDETAILSHERE(
              ID: appointmentid, Token: StorageUtil.getString('token'))
          ..GETappointmentINVOICE(
              ID: appointmentid, Token: StorageUtil.getString('token')),
        child: BlocConsumer<appcubit, appstate>(listener: (Context, State) {
          if (State is appappointinvoicesuccessstate) {
            pdflink = State.invoicemodel.data.invoice.pdf;
            invoicemodel = State.invoicemodel;
          }
          if (State is appappointmentDETAILSsuccessstate) {
            print('success here');
            print(appointmentid);
            appointmentmodelhereSTATUS = State.userdata.data.appointment.status;
            appointmentmodelhereTIME = State.userdata.data.appointment.time;
            appointmentmodelhereDATE = State.userdata.data.appointment.date;
            appointmentmodelhereDETAILS =
                State.userdata.data.appointment.details;
            appointmentmodelherePAYMENTMETHOD =
                State.userdata.data.appointment.paymentMethod;
            providerdetailsname = State.userdata.data.appointment.agent.name;
            providerdetailsphoto = State.userdata.data.appointment.agent.photo;
            providerdetailsrating =
                State.userdata.data.appointment.agent.rating;
            providerdetailsaddress =
                State.userdata.data.appointment.agent.address;
            providerdetailsphonenumber =
                State.userdata.data.appointment.agent.phoneNumber;
            providerdetails =
                State.userdata.data.appointment.agent.occupation.title;
            providerdetailsID = State.userdata.data.appointment.agent.id;
            values = providerdetailsaddress!.split(",");
            values!.forEach(print);
            values2 = values![1]!.split(",");
            values!.forEach(print);
            values5 = providerdetailsname!.split(
                " "); // split() will split from . and gives new List with separated elements.
            values?.forEach(print);
          }
        }, builder: (Context, State) {
          return SingleChildScrollView(
              child: ConditionalBuilder(
            fallback: (context) => Center(
              child: CircularProgressIndicator(color: Colors.green),
            ),
            builder: (Context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade600,
                              spreadRadius: 1,
                              blurRadius: 10,
                              blurStyle: BlurStyle.outer,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 0.0, 0.0),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(Baseurl +
                                                  providerdetailsphoto!),
                                              fit: BoxFit.fill)),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 0.0, 0.0),
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              providerdetails!,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              providerdetailsname!,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 20,
                                              child: ratingstars(
                                                double.parse(
                                                    providerdetailsrating!),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_sharp,
                                                  color: Colors.red,
                                                ),
                                                Text(
                                                  values![0],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  values![1],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                ),
                                                Text(','),
                                                Text(
                                                  values2![0],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ConditionalBuilder(
                                condition:
                                    State is! appappointmentDETAILSloadingstate,
                                fallback: (Context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                builder: (Context) {
                                  return Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'Date \n ${appointmentmodelhereDATE!}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                'Time\n ${appointmentmodelhereTIME!}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                'Status\n ${appointmentmodelhereSTATUS == 1 ? 'Pending' : appointmentmodelhereSTATUS == 2 ? 'Confirmed' : appointmentmodelhereSTATUS == 3 ? 'Canceled' : appointmentmodelhereSTATUS == 4 ? 'Completed' : ''}',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              appointmentmodelhereSTATUS == 4
                                                  ? Text(
                                                      'Total Price\n ${invoicemodel?.data.invoice.totalPrice}',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  : Text('')
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text('Details',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: ReadMoreText(
                                              appointmentmodelhereDETAILS!,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                              trimLines: 5,
                                            ),
                                          ),
                                        
                                          appointmentmodelhereSTATUS == 4
                                              ? ConditionalBuilder(
                                                  condition: State
                                                      is! appappointinvoiceloadingstate,
                                                  fallback: (Context) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                      color: Colors.green,
                                                    ));
                                                  },
                                                  builder: (context) =>
                                                      Container(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: FlatButton(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.07,
                                                            minWidth: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.9,
                                                            onPressed:
                                                                () async {
                                                              if (await Permission
                                                                  .contacts
                                                                  .request()
                                                                  .isGranted) {
                                                                // Either the permission was already granted before or the user just granted it.
                                                              }

                                                              String urlpath =
                                                                  Baseurl +
                                                                      invoicemodel!
                                                                          .data
                                                                          .invoice
                                                                          .pdf;
                                                              print(urlpath);
                                                              String fileName =
                                                                  urlpath.substring(
                                                                      urlpath.lastIndexOf(
                                                                              "/") +
                                                                          1);
                                                              String savePath =
                                                                  await getFilePath(
                                                                      fileName);

                                                              // final Uint8List
                                                              //     bytes =
                                                              //     await InternetFile
                                                              //         .get(
                                                              //   '$urlpath',
                                                              //   process:
                                                              //       (percentage) {
                                                              //     print(
                                                              //         'downloadPercentage: $percentage');
                                                              //   },
                                                              //   storageAdditional: {
                                                              //     'filename':
                                                              //         '$urlpath.pdf',
                                                              //     'location':
                                                              //         '$savePath',
                                                              //   },
                                                              // );
                                                              var numberrand;
                                                              diohelper.dio
                                                                  ?.download(
                                                                      urlpath,
                                                                      '$savePath/Receipt-PDF(${numberrand = Random().nextInt(100)}).pdf')
                                                                  .then(
                                                                      (value) {
                                                                print(savePath);
                                                                var file =
                                                                    value.data;
                                                                print(value.data
                                                                    .runtimeType);
                                                                FileMode.write;
                                                                var _openResult =
                                                                    'Unknown';

                                                                Future<void>
                                                                    openFile() async {
                                                                  var filePath =
                                                                      '${savePath}/Receipt-PDF(${numberrand}).pdf';
                                                                  FilePickerResult?
                                                                      result =
                                                                      await FilePicker
                                                                          .platform
                                                                          .pickFiles();

                                                                  if (result !=
                                                                      null) {
                                                                    filePath = result
                                                                        .files
                                                                        .single
                                                                        .path!;
                                                                  } else {
                                                                    // User canceled the picker
                                                                  }
                                                                  final _result =
                                                                      await OpenFile
                                                                          .open(
                                                                              filePath);
                                                                  print(_result
                                                                      .message);

                                                                  setState(() {
                                                                    _openResult =
                                                                        "type=${_result.type}  message=${_result.message}";
                                                                  });
                                                                }

                                                                openFile();
                                                              });

                                                              Map<Permission,
                                                                      PermissionStatus>
                                                                  statuses =
                                                                  await [
                                                                Permission
                                                                    .storage
                                                              ].request();
                                                            },
                                                            color: const Color
                                                                    .fromRGBO(
                                                                0, 168, 165, 1),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: const Text(
                                                              "Download PDF Receipt",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 19),
                                                            ),
                                                          )),
                                                )
                                              : Container(),
                                          SizedBox(
                                            height: 5,
                                          ),
                                         appointmentmodelhereSTATUS == 4 ?
                                          Container(
                                              alignment: Alignment.bottomCenter,
                                              child: FlatButton(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                                minWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                onPressed: () {
                                                  showBarModalBottomSheet(
                                                      expand: false,
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      builder: (context) =>
                                                          writeReview());
                                                },
                                                color: const Color.fromRGBO(
                                                    0, 168, 165, 1),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Text(
                                                  "Review",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19),
                                                ),
                                              )): Container(),
                                        ]),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ]))
                  ],
                ),
              );
            },
            condition: State is appappointmentDETAILSsuccessstate,
          ));
        }));
  }
}

class writeReview extends StatefulWidget {
  writeReview({Key? key}) : super(key: key);

  @override
  State<writeReview> createState() => _writeReviewState();
}

class _writeReviewState extends State<writeReview> {
  List? agentmodel;

  String? providerdetails;

  String? providerdetailsname;

  String? providerdetailsphoto;

  String? providerdetailsrating;

  String? providerdetailsaddress;

  String? providerdetailsphonenumber;
  int? providerdetailsID;

  List? values;
  List? values2;
  APPOINTMENTSDETAILS? appointmentmodelhere;
  int? appointmentmodelhereSTATUS;
  String? appointmentmodelhereTIME;
  String? appointmentmodelhereDATE;
  String? appointmentmodelhereDETAILS;
  int? appointmentmodelherePAYMENTMETHOD;

  double rating = 0.0;

  String Baseurl = 'http://192.168.42.209:80';

  int id = int.parse(StorageUtil.getString('id'));
  int appointmentid = int.parse(StorageUtil.getString('appointmentid'));

  TextEditingController Detailsreview = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => appcubit(appservicedetailsinitialstate())
          ..GETAGENTDATADETAILS(ID: id, Token: StorageUtil.getString('token'))
          ..GETAPPOINTMENTDETAILSHERE(
              ID: appointmentid, Token: StorageUtil.getString('token')),
        child: BlocConsumer<appcubit, appstate>(listener: (Context, State) {
          if (State is appappointmentDETAILSsuccessstate) {
            print('success here');
            appointmentmodelhereSTATUS = State.userdata.data.appointment.status;
            appointmentmodelhereTIME = State.userdata.data.appointment.time;
            appointmentmodelhereDATE = State.userdata.data.appointment.date;
            appointmentmodelhereDETAILS =
                State.userdata.data.appointment.details;
            appointmentmodelherePAYMENTMETHOD =
                State.userdata.data.appointment.paymentMethod;
            providerdetailsname = State.userdata.data.appointment.agent.name;
            providerdetailsphoto = State.userdata.data.appointment.agent.photo;
            providerdetailsrating =
                State.userdata.data.appointment.agent.rating;
            providerdetailsaddress =
                State.userdata.data.appointment.agent.address;
            providerdetailsphonenumber =
                State.userdata.data.appointment.agent.phoneNumber;
            providerdetails =
                State.userdata.data.appointment.agent.occupation.title;
            providerdetailsID = State.userdata.data.appointment.agent.id;
            values = providerdetailsaddress!.split(",");
            values!.forEach(print);
            values2 = values![2]!.split("G");
            values!.forEach(print);
          }
        }, builder: (Context, State) {
          return SingleChildScrollView(
              child: ConditionalBuilder(
            fallback: (context) => Center(
              child: CircularProgressIndicator(color: Colors.green),
            ),
            builder: (Context) {
              var value = 0.0;
              return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating1) {
                              setState(() {
                                rating = rating1;
                              });
                              print(rating1);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Review',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: Detailsreview,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          hintText: 'Enter details.',
                          hintStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Color.fromRGBO(238, 248, 245, 0.5),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(child: Text('')),
                      Container(
                          alignment: Alignment.bottomCenter,
                          child: FlatButton(
                            height: MediaQuery.of(context).size.height * 0.07,
                            minWidth: MediaQuery.of(context).size.width * 0.9,
                            onPressed: () async {
                              appcubit.get(context).writereview(
                                  appointment_id: int.parse(
                                      StorageUtil.getString('appointmentid')),
                                  comment: Detailsreview.text,
                                  rating: rating,
                                  Token: StorageUtil.getString('token'));
                              print(int.parse(
                                  StorageUtil.getString('appointmentid')));
                            },
                            color: const Color.fromRGBO(0, 168, 165, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "Review",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ));
            },
            condition: true,
          ));
        }));
  }
}
