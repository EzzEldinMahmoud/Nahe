// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project/screens/cubit.dart';
// import 'package:project/screens/settings.dart';
// import 'package:project/screens/states/loginstates.dart';

// import '../models/serviceModel.dart';

// class NearbyServicePage extends StatefulWidget {
//   NearbyServicePage({Key? key}) : super(key: key);

//   @override
//   State<NearbyServicePage> createState() => _NearbyServicePageState();
// }

// class _NearbyServicePageState extends State<NearbyServicePage> {
//   late List here;
//   String Baseurl = 'http://nahe.dhulfiqar.com';

//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: BlocProvider(
//       create: (BuildContext context) =>
//           appcubit(APPSERVICENEARBYPROVIDERSINITIALSTATE())
//             ..getservice()
//             ..getuserdata()
//             ..GETNEARBYSERVICEPROVIDER(),
//       child: BlocConsumer<appcubit, appstate>(
//         listener: (context, state) {
//           if (state is APPSERVICENEARBYPROVIDERSSUCCESSSTATE) {
//             here = state.userdata.data.nearbyProviders;
//             print(state.userdata.data.nearbyProviders.length.toInt());
//             print(here);
//           }
//         },
//         builder: (BuildContext context, state) {
//           return Material(
//               child: ConditionalBuilder(
//             fallback: (context) => Center(
//               child: CircularProgressIndicator(color: Colors.green),
//             ),
//             condition: state is! appserviceloadingstate,
//             builder: (context) {
//               return SafeArea(
//                   child: Column(children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 40, left: 20, right: 20, bottom: 10),
//                         child: Text(
//                           " Nearby Services",
//                           style: TextStyle(
//                               fontSize: 30, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Expanded(
//                         child: Text(""),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (_) => settingsScreen()));
//                         },
//                         child: Padding(
//                             padding:
//                                 EdgeInsets.only(top: 35, left: 20, right: 20),
//                             child: CircleAvatar(
//                               backgroundColor: Color.fromRGBO(187, 250, 231, 1),
//                               backgroundImage: NetworkImage(Baseurl),
//                             )),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 25),
//                   decoration: new BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                           color: Color.fromARGB(197, 255, 255, 255),
//                           blurRadius: 15.0,
//                           offset: Offset(0.0, 0.75))
//                     ],
//                   ),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       filled: true,
//                       isDense: true, // Added this
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 22, horizontal: 20),
//                       fillColor: Color.fromRGBO(238, 247, 246, 0.5),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                         borderSide: BorderSide(color: Colors.white, width: 2),
//                       ),
//                       hintText: 'Search for electricians,plumbers,etc...',
//                       suffixIcon: Icon(Icons.search),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 ConditionalBuilder(
//                   fallback: (context) => Center(
//                     child: CircularProgressIndicator(color: Colors.green),
//                   ),
//                   condition: state is! appserviceloadingstate,
//                   builder: (context) {
//                     return Container(
//                       child: Column(children: [
//                         // Display the data loaded from sample.json

//                         Container(
//                           height: MediaQuery.of(context).size.height * 1,
//                           width: MediaQuery.of(context).size.width * 1,
//                           child: ListView.builder(
//                             itemCount: here.length,
//                             itemBuilder: (context, index) {
//                               return SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.15,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.8,
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 20, vertical: 0),
//                                     child: Card(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10.0),
//                                         ),
//                                         margin: EdgeInsets.all(4),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               color: Color(0xffffEEF6F6),
//                                               borderRadius:
//                                                   BorderRadius.circular(15)),
//                                           padding: EdgeInsets.all(15),
//                                           child: Row(
//                                             children: [
//                                               Container(
//                                                 height: 100,
//                                                 width: 100,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8),
//                                                     image: new DecorationImage(
//                                                       image: new NetworkImage(
//                                                           Baseurl +
//                                                               here[index]
//                                                                   .photo),
//                                                       fit: BoxFit.cover,
//                                                     )),
//                                               ),
//                                               SizedBox(
//                                                 width: 15,
//                                                 height: 10,
//                                               ),
//                                               Container(
//                                                   child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     here[index].name,
//                                                     style: TextStyle(
//                                                         fontSize: 20,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                   Text(
//                                                     here[index]
//                                                         .occupation
//                                                         .title,
//                                                     style: TextStyle(
//                                                         fontSize: 15,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                     textAlign: TextAlign.left,
//                                                   ),
//                                                   Expanded(
//                                                     child: Text(""),
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Container(
//                                                         height: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .height *
//                                                             0.03,
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             0.25,
//                                                         decoration: BoxDecoration(
//                                                             color: Colors
//                                                                 .transparent,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         15)),
//                                                         child: Row(
//                                                           children: [
//                                                             SizedBox(
//                                                               width: 10,
//                                                             ),
//                                                             Text(
//                                                               here[index]
//                                                                   .rating,
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .black),
//                                                             ),
//                                                             Icon(
//                                                               Icons.star,
//                                                               color:
//                                                                   Colors.yellow,
//                                                               size: 17,
//                                                             ),
//                                                             SizedBox(
//                                                               width: 5,
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             0.03,
//                                                       ),
//                                                       GestureDetector(
//                                                         onTap: () {
//                                                           Navigator.push(
//                                                               context,
//                                                               MaterialPageRoute(
//                                                                   builder: (_) =>
//                                                                       NearbyServicePage()));
//                                                         },
//                                                         child: Container(
//                                                           height: MediaQuery.of(
//                                                                       context)
//                                                                   .size
//                                                                   .height *
//                                                               0.03,
//                                                           width: MediaQuery.of(
//                                                                       context)
//                                                                   .size
//                                                                   .width *
//                                                               0.2,
//                                                           decoration: BoxDecoration(
//                                                               color: Colors
//                                                                   .transparent,
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           15)),
//                                                           child: Row(
//                                                             children: [
//                                                               Expanded(
//                                                                 child: Text(''),
//                                                               ),
//                                                               Text(
//                                                                 " Details",
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .black),
//                                                               ),
//                                                               Icon(
//                                                                 Icons
//                                                                     .arrow_forward_sharp,
//                                                                 color: Colors
//                                                                     .black,
//                                                                 size: 17,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       )
//                                                     ],
//                                                   )
//                                                 ],
//                                               ))
//                                             ],
//                                           ),
//                                         )),
//                                   ));
//                             },
//                           ),
//                         )
//                       ]),
//                     );
//                   },
//                 ),
//               ]));
//             },
//           ));
//         },
//       ),
//     ));
//   }
// }
