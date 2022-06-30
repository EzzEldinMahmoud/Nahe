import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Widgets/schedulewidget.dart';
import 'package:project/models/AGENTDETAILS.dart';
import 'package:project/models/appointments/APPOINTMENTSdetails.dart';
import 'package:project/models/AUTH MODELS/LOGIN_model.dart';
import 'package:project/models/appointments/Appointments.dart';
import 'package:project/models/appointments/appointinvoicemodel.dart';
import 'package:project/models/appointments/appointmentcommentmodel.dart';
import 'package:project/models/errorsmodel/LoginERRORmodel.dart';
import 'package:project/models/general models/homeModel.dart';
import 'package:project/models/nearbyserviceprovider/nearbyservicesp.dart';
import 'package:project/models/AUTH MODELS/registermodel.dart';
import 'package:project/models/nearbyserviceprovider/serviceModel.dart';
import 'package:project/models/AUTH MODELS/user_info.dart';
import 'package:project/network/remote/diohelper.dart';
import 'package:project/network/remote/end_points.dart';
import 'package:project/network/remote/local/cachehelper.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/settings.dart';
import 'package:project/screens/sign_page.dart';
import 'package:project/screens/states/loginstates.dart';
import 'package:project/screens/states/settingsstates.dart';

import '../models/general models/SEARCHAGENTMODEL.dart';
import '../models/appointments/appointschedule.dart';
import '../models/nearbyserviceprovider/nearbysingleserviceproviderdetailsmodel.dart';

class appcubit extends Cubit<appstate> {
  appcubit(appstate initialState) : super(initialState);
  static appcubit get(context) => BlocProvider.of(context);
  String token = StorageUtil.getString('token');
  userinfo? usermodel;
  Appointmentinvoicemodel? invoicemodel;
  Loginmodel? userget;
  HOMEMODEL? homemodel;
  NEARBYSERVICEPROVIDERS? NEARBYSERVICEPROVIDERMODEL;
  AgentdetailModel? AGENTDETAILSMODEL;
  APPOINTMENTSDETAILS? appointmentDETAILSmodel;
  Servicemodel? servicemodel;
  APPOINTMENTMODEL? appointmentmodel;
  Future getuserdata({required String Token}) async {
    emit(apploadingstate());
    diohelper
        .getData(Url: get_user_info, query: {}, Token: Token)
        .then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";

      usermodel = userinfo.fromJson(jsonDecode(value?.data));
      if (usermodel != null) {
        print(usermodel!.data.user.phoneNumber.toString());
        emit(appsuccessstate(usermodel!));
      }
    }).catchError((error) {
      print(error.toString());
      emit(appERRORstate(error));
    });
    return usermodel;
  }

  Future gethome({required String Token}) async {
    emit(apphomestateloading());
    diohelper.getData(Url: GETHOME, query: {}, Token: Token).then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      homemodel = HOMEMODEL.fromJson(jsonDecode(value?.data));

      if (homemodel != null) {
        print(homemodel!.data.user.name);
        emit(apphomestatesuccess(homemodel!));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(apphomestateERROR(jsonDecode(error.toString())));
    });
    return homemodel;
  }

  Future getappointments({required String Token}) async {
    emit(appappointmentstateloading());
    diohelper
        .getData(Url: GETAPPOINTMENTS, query: {}, Token: Token)
        .then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      appointmentmodel = APPOINTMENTMODEL.fromJson(jsonDecode(value?.data));
      var appointmentmodel1 = appointmentmodel?.data;
      if (appointmentmodel1 != null) {
        print(appointmentmodel!.data.archivedAppointments.length);
        emit(appappointmentstatesuccess(appointmentmodel!));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(appappointmentstateError(jsonDecode(error.toString())));
    });
    return appointmentmodel;
  }

  Future GETNEARBYSERVICEPROVIDER({required String Token}) async {
    emit(APPSERVICENEARBYPROVIDERSLOADINGSTATE());
    diohelper
        .getData(Url: GETNEARBYSERVICEPROVIDERS, query: {}, Token: Token)
        .then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      NEARBYSERVICEPROVIDERMODEL =
          NEARBYSERVICEPROVIDERS.fromJson(jsonDecode(value?.data));

      if (NEARBYSERVICEPROVIDERMODEL != null) {
        print(NEARBYSERVICEPROVIDERMODEL!.data.nearbyProviders.length);
        emit(
            APPSERVICENEARBYPROVIDERSSUCCESSSTATE(NEARBYSERVICEPROVIDERMODEL!));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(APPSERVICENEARBYPROVIDERSerrorSTATE(jsonDecode(error.toString())));
    });
    return NEARBYSERVICEPROVIDERMODEL;
  }

  Future GETAGENTDATADETAILS({required int ID, required String Token}) async {
    emit(appservicedetailloadingstate());
    diohelper
        .postData(
            Url: getservicedetails,
            query: {},
            Token: Token,
            data: {'agent_id': ID})
        .then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      AGENTDETAILSMODEL = AgentdetailModel.fromJson(jsonDecode(value?.data));

      if (AGENTDETAILSMODEL != null) {
        print(AGENTDETAILSMODEL!.data.reviews.length);
        emit(appservicedetailsuccessstate(AGENTDETAILSMODEL!));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(appservicedetailERRORstate(jsonDecode(error.toString())));
    });
    return AGENTDETAILSMODEL;
  }

  Future GETAPPOINTMENTDETAILSHERE(
      {required int ID, required String Token}) async {
    emit(appappointmentDETAILSloadingstate());
    diohelper
        .postData(
            Url: GETAPPOINTMENTDETAILS,
            query: {},
            Token: Token,
            data: {'appointment_id': ID})
        .then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      appointmentDETAILSmodel =
          APPOINTMENTSDETAILS.fromJson(jsonDecode(value?.data));
      final appointmentmodel1 = appointmentDETAILSmodel;
      if (appointmentDETAILSmodel != null) {
        print('successssss');
        print(appointmentDETAILSmodel!.data.appointment.date);
        emit(appappointmentDETAILSsuccessstate(appointmentDETAILSmodel!));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(appappointmentDETAILSERRORstate(jsonDecode(error.toString())));
    });
    return appointmentDETAILSmodel;
  }

  Future GETappointmentINVOICE({required int ID, required String Token}) async {
    emit(appappointinvoiceloadingstate());
    diohelper
        .postData(
            Url: GETAPPOINTINVOICE,
            query: {},
            Token: Token,
            data: {'appointment_id': ID})
        .then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      final appointmentinvoicemodel =
          Appointmentinvoicemodel.fromJson(jsonDecode(value?.data));
      if (appointmentinvoicemodel != null) {
        print('successsssssssssssssssssssssssss');
        invoicemodel = appointmentinvoicemodel;
        print(appointmentinvoicemodel.data.invoice.pdf);
        emit(appappointinvoicesuccessstate(appointmentinvoicemodel));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(appappointinvoiceERRORstate(jsonDecode(error.toString())));
    });
    return invoicemodel;
  }

  Future getsearchresult(
      {required String jobtitle, required String Token}) async {
    emit(appsearchloadingstate());
    diohelper
        .postData(
            Url: SEARCHPAGERESULT,
            query: {},
            Token: Token,
            data: {'query': jobtitle})
        .then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      final SEARCHAGENTDETAILSMODEL =
          SEARCHAGENTSNEARBY.fromJson(jsonDecode(value?.data));

      if (SEARCHAGENTDETAILSMODEL != null) {
        print(SEARCHAGENTDETAILSMODEL.data);
        emit(appsearchsuccessstate(SEARCHAGENTDETAILSMODEL));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(appsearchERRORstate(jsonDecode(error.toString())));
    });
  }

  Future getservice({required String Token}) async {
    emit(appserviceloadingstate());
    diohelper.getData(Url: GETSERVICE, query: {}, Token: Token).then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
      servicemodel = Servicemodel.fromJson(jsonDecode(value?.data));

      if (servicemodel != null) {
        print(servicemodel!.data.nearbyAgents.length);
        emit(appservicestatesuccess(servicemodel!));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(appservicestateERROR(jsonDecode(error.toString())));
    });
    return servicemodel;
  }

//here ends get req
  Future<void> userinfoupdate(
      {required String phone_number,
      required String name,
      required String city,
      required String district,
      required String street,
      required Token}) async {
    emit(apploadingstate());
    diohelper.postData(Url: post_user_info, data: {
      'phone_number': phone_number,
      'name': name,
      'city': city,
      'district': district,
      'street': street,
    }).then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";
      final userdata = userinfo.fromJson(jsonDecode(value?.data));

      final apimodeluse1 = userdata.data.user.name;

      if (apimodeluse1 != null) {
        print(apimodeluse1);
      } else {
        print("failed to update");
      }
      emit(appsuccessstate(userdata));
    }).catchError((error) {
      print(error.toString());
      emit(appERRORstate(error.toString()));
    });
  }
  
    Future getcommentreview({required int ID, required String Token}) async {
    emit(apploadingcommentagentstate());
    diohelper
        .postData(
            Url: GETSERVICEPROVIDERDETAILSHERE,
            query: {},
            Token: Token,
            data: {'appointment_id': ID})
        .then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
    final   serviceproviderdetailshere = APPOINTMENTCOMMENTMODEL.fromJson(jsonDecode(value?.data));

      if (serviceproviderdetailshere != null) {
        print(serviceproviderdetailshere.data);
        emit(appsuccesscommentagentstate(serviceproviderdetailshere));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(appERRORcommentagentstate(jsonDecode(error.toString())));
    });

  }
  Future GETserviceproviderDETAILS({required int ID, required String Token}) async {
    emit(appserviceprovidersingledetailsloadingstate());
    diohelper
        .postData(
            Url: GETSERVICEPROVIDERDETAILSHERE,
            query: {},
            Token: Token,
            data: {'service_id': ID})
        .then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";

      print(value?.statusCode.toString());
      print(value?.data);
      print(value?.statusCode);
      print(value?.statusCode);
    final   serviceproviderdetailshere = Nearbyserviceprovidermodel.fromJson(jsonDecode(value?.data));

      if (serviceproviderdetailshere != null) {
        print(serviceproviderdetailshere.data);
        emit(appserviceprovidersingledetailssuccessstate(serviceproviderdetailshere));
      }
    }).catchError((error) {
      print(jsonDecode(error.toString()));
      emit(appserviceprovidersingledetailsERRORstate(jsonDecode(error.toString())));
    });

  }

  Future<void> scheduleappointment(
      {required int agent_id,
      required String date,
      required String time,
      required int payment_method,
      required String details,
      required Token}) async {
    emit(appscheduleloadingstate());
    diohelper.postData(Url: SCHEDULEAPPOINTMENT, data: {
      'agent_id': agent_id,
      'date': date,
      'time': time,
      'payment_method': payment_method,
      'details': details,
    }).then((value) {
      diohelper.dio?.options.headers["Authorization"] = "token ${token}";
      final scheduleAppointmentmodel =
          ScheduleAPPOINTMENTMODEL.fromJson(jsonDecode(value?.data));

      final apimodeluse1 = scheduleAppointmentmodel.data.appointment;

      if (apimodeluse1 != null) {
        print(apimodeluse1.date);
      } else {
        print("failed to update");
      }
      emit(appschedulesuccessstate(scheduleAppointmentmodel));
    }).catchError((error) {
      print(error.toString());
      emit(appscheduleERRORstate(error.toString()));
    });
  }

  Future<void> writereview(
      {required int appointment_id,
      required String comment,
      required double rating,
      required Token}) async {
    emit(appwritereviewloadingstate());
    diohelper.postData(Url: WRITEREVIEW, data: {
      'appointment_id': appointment_id,
      'comment': comment,
      'rating': rating,
    }).then((value) {
      emit(appwritereviewsuccessstate());
      diohelper.dio?.options.headers[{
        'Authorization': 'Bearer ${Token}',
      }];
    }).catchError((error) {
      print(error.toString());
      emit(appwritereviewERRORstate(error.toString()));
    });
  }

  Future<void> userregister(
      {required String phone_number,
      required String password,
      required String name,
      required String city,
      required String district,
      required String street,
      context}) async {
    emit(appregisterloadingstate());
    diohelper.postData(Url: REGISTER, data: {
      'phone_number': phone_number,
      'password': password,
      'name': name,
      'city': city,
      'district': district,
      'street': street,
    }).then((value) {
      final userdata = Registermodel.fromJson(jsonDecode(value?.data));

      final apimodeluse = userdata.data.token.authToken;

      if (apimodeluse != null) {
        StorageUtil.putString('token', apimodeluse);
        token = StorageUtil.getString('token');

        appcubit.get(context)
          ..getuserdata(Token: token)
          ..getappointments(Token: token)
          ..gethome(Token: token)
          ..getservice(Token: token)
          ..GETNEARBYSERVICEPROVIDER(Token: token);
        if (token.isNotEmpty) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return homeScreen();
          }));
        }
      } else {
        print("failed to register");
      }
      emit(appsuccessstateregister(userdata));
    }).catchError((error) {
      print(error.toString());
      emit(appERRORstate(error.toString()));
    });
  }

  Future<void> userlogin(
      {required String phone_number, required String password, context}) async {
    emit(AppLoginLoadingState());
    diohelper.postData(Url: LOGIN, data: {
      'phone_number': phone_number,
      'password': password,
    }).then((value) {
      print(jsonDecode(value?.data));
      print(jsonDecode(value?.data));
      final userdata = Loginmodel.fromJson(jsonDecode(value?.data));

      final apimodeluse = userdata.data.token.authToken;
      final statuscode = value?.statusCode;

      print(statuscode);
      if (apimodeluse != null) {
        StorageUtil.putString('token', apimodeluse);

        token = StorageUtil.getString('token');
        emit(AppLoginSuccessState(userdata, statuscode!));
        appcubit.get(context)
          ..getuserdata(Token: token)
          ..getappointments(Token: token)
          ..gethome(Token: token)
          ..getservice(Token: token)
          ..GETNEARBYSERVICEPROVIDER(Token: token);
        if (token.isNotEmpty) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return homeScreen();
          }));
          emit(AppLoginSuccessState(userdata, statuscode));
        }

        print(apimodeluse.toString());
      }
    }).catchError((error) {});
  }
}
