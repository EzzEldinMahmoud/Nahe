import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project/Widgets/schedulewidget.dart';
import 'package:project/screens/cubit.dart';
import 'package:project/screens/start_screen.dart';
import 'package:project/screens/states/loginstates.dart';
import 'package:project/splash/flutter_rating_stars.dart';
import '../network/remote/local/cachehelper.dart';
import 'package:auto_size_text/auto_size_text.dart';

void signout(context) {
  StorageUtil.clrString('token').then((value) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => first_form()));
  });
}

class addressspiltreturns {
  final String city;
  final String district;
  final String street;

  addressspiltreturns(this.street, this.city, this.district);
}

class bottomsheet extends StatefulWidget {
  bottomsheet({
    Key? key,
  }) : super(key: key);

  @override
  State<bottomsheet> createState() => _bottomsheetState();
}

class _bottomsheetState extends State<bottomsheet> {
  List? agentmodel;

  String? providerdetails;

  String? providerdetailsname;

  String? providerdetailsphoto;

  String? providerdetailsrating;

  String? providerdetailsaddress;

  String? providerdetailsphonenumber;

  List? values;

  List? values2;

  String Baseurl = 'http://nahe.dhulfiqar.com';

  int id = int.parse(StorageUtil.getString('id'));

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
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Column(
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
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Column(children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, 0.0, 0.0),
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
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
                                                overflow: TextOverflow.ellipsis,
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
                                                overflow: TextOverflow.ellipsis,
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
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, 0.0, 0.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Reviews",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          child: ListView.builder(
                                            itemCount: agentmodel?.length,
                                            itemBuilder: (context, index) {
                                              return SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.19,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      margin: EdgeInsets.all(8),
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
                                                            SizedBox(
                                                              width: 15,
                                                              height: 10,
                                                            ),
                                                            Expanded(
                                                                child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      agentmodel![
                                                                              index]
                                                                          .clientName,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    ratingstars(
                                                                      double.parse(
                                                                          providerdetailsrating!),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    '${agentmodel![index].comment}',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 4,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ],
                                                            ))
                                                          ],
                                                        ),
                                                      )));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(child: Text("")),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                        child: FlatButton(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      minWidth:
                                          MediaQuery.of(context).size.width *
                                              0.38,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      color: Color.fromRGBO(0, 168, 165, 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.call,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Call",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19),
                                          ),
                                        ],
                                      ),
                                    )),
                                    Expanded(
                                      child: Text(''),
                                    ),
                                    Container(
                                        child: FlatButton(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      minWidth:
                                          MediaQuery.of(context).size.width *
                                              0.38,
                                      onPressed: () {
                                        showBarModalBottomSheet(
                                            expand: true,
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) =>
                                                scheduleAppointment());
                                      },
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              color: Color.fromRGBO(
                                                  0, 168, 165, 1))),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month_sharp,
                                            color:
                                                Color.fromRGBO(0, 168, 165, 1),
                                          ),
                                          Text(
                                            "Schedule",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 168, 165, 1),
                                                fontSize: 19),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ],
                                ))
                          ]))
                    ],
                  ),
                ),
              );
            },
            condition: State is! appservicedetailloadingstate,
          ));
        }));
  }
}

class ratingstars extends StatelessWidget {
  var d;

  ratingstars(this.d, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingStars(
      value: d,
      starBuilder: (index, color) => Icon(
        Icons.star,
        color: color,
      ),
      starCount: 5,
      starSize: 15,
      maxValue: 5,
      starSpacing: 1,
      maxValueVisibility: false,
      valueLabelVisibility: false,
      animationDuration: Duration(milliseconds: 1000),
      starColor: Colors.yellow,
    );
  }
}
