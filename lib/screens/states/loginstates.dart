import 'package:project/models/AGENTDETAILS.dart';
import 'package:project/models/appointments/APPOINTMENTSdetails.dart';
import 'package:project/models/appointments/appointinvoicemodel.dart';
import 'package:project/models/errorsmodel/LoginERRORmodel.dart';

import '../../models/AUTH MODELS/LOGIN_model.dart';
import '../../models/AUTH MODELS/registermodel.dart';
import '../../models/AUTH MODELS/user_info.dart';
import '../../models/appointments/Appointments.dart';
import '../../models/appointments/appointmentcommentmodel.dart';
import '../../models/appointments/appointschedule.dart';
import '../../models/general models/SEARCHAGENTMODEL.dart';
import '../../models/general models/homeModel.dart';
import '../../models/nearbyserviceprovider/nearbyservicesp.dart';
import '../../models/nearbyserviceprovider/nearbysingleserviceproviderdetailsmodel.dart';
import '../../models/nearbyserviceprovider/serviceModel.dart';

abstract class appstate {}

class appinitialstate extends appstate {}

class apploadingstate extends appstate {}

class appsuccessstate extends appstate {
  final userinfo userdata;

  appsuccessstate(
    this.userdata,
  );
}

class appERRORstate extends appstate {
  final String error;
  appERRORstate(this.error);
}
class appinitialcommentagentstate extends appstate {}

class apploadingcommentagentstate extends appstate {}

class appsuccesscommentagentstate extends appstate {
  final APPOINTMENTCOMMENTMODEL? userdata;

  appsuccesscommentagentstate(
    this.userdata,
  );
}

class appERRORcommentagentstate extends appstate {
  final String error;
  appERRORcommentagentstate(this.error);
}
class appserviceprovidersingledetailsinitialstate extends appstate {}

class appserviceprovidersingledetailsloadingstate extends appstate {}

class appserviceprovidersingledetailssuccessstate extends appstate {
  final Nearbyserviceprovidermodel userdata;

  appserviceprovidersingledetailssuccessstate(
    this.userdata,
  );
}

class appserviceprovidersingledetailsERRORstate extends appstate {
  final String error;
  appserviceprovidersingledetailsERRORstate(this.error);
}

class appappointinvoiceinitialstate extends appstate {}

class appappointinvoiceloadingstate extends appstate {}

class appappointinvoicesuccessstate extends appstate {
  final Appointmentinvoicemodel invoicemodel;

  appappointinvoicesuccessstate(
    this.invoicemodel,
  );
}

class appappointinvoiceERRORstate extends appstate {
  final String error;
  appappointinvoiceERRORstate(this.error);
}

class appappointmentDETAILSinitialstate extends appstate {}

class appappointmentDETAILSloadingstate extends appstate {}

class appappointmentDETAILSsuccessstate extends appstate {
  final APPOINTMENTSDETAILS userdata;

  appappointmentDETAILSsuccessstate(
    this.userdata,
  );
}

class appappointmentDETAILSERRORstate extends appstate {
  final String error;
  appappointmentDETAILSERRORstate(this.error);
}

class appsearchinitialstate extends appstate {}

class appsearchloadingstate extends appstate {}

class appsearchsuccessstate extends appstate {
  final SEARCHAGENTSNEARBY userdata;

  appsearchsuccessstate(
    this.userdata,
  );
}

class appsearchERRORstate extends appstate {
  final String error;
  appsearchERRORstate(this.error);
}

class appscheduleinitialstate extends appstate {}

class appscheduleloadingstate extends appstate {}

class appschedulesuccessstate extends appstate {
  final ScheduleAPPOINTMENTMODEL userdata;

  appschedulesuccessstate(
    this.userdata,
  );
}

class appscheduleERRORstate extends appstate {
  final String error;
  appscheduleERRORstate(this.error);
}

class appwritereviewinitialstate extends appstate {}

class appwritereviewloadingstate extends appstate {}

class appwritereviewsuccessstate extends appstate {

  appwritereviewsuccessstate(
  );
}

class appwritereviewERRORstate extends appstate {
  final String error;
  appwritereviewERRORstate(this.error);
}
class appservicedetailsinitialstate extends appstate {}

class appservicedetailloadingstate extends appstate {}

class appservicedetailsuccessstate extends appstate {
  final AgentdetailModel userdata;

  appservicedetailsuccessstate(
    this.userdata,
  );
}

class appservicedetailERRORstate extends appstate {
  final String error;
  appservicedetailERRORstate(this.error);
}

class APPSERVICENEARBYPROVIDERSINITIALSTATE extends appstate {}

class APPSERVICENEARBYPROVIDERSLOADINGSTATE extends appstate {}

class APPSERVICENEARBYPROVIDERSSUCCESSSTATE extends appstate {
  final NEARBYSERVICEPROVIDERS userdata;

  APPSERVICENEARBYPROVIDERSSUCCESSSTATE(
    this.userdata,
  );
}

class APPSERVICENEARBYPROVIDERSerrorSTATE extends appstate {
  final String error;
  APPSERVICENEARBYPROVIDERSerrorSTATE(this.error);
}

class appregisterstate extends appstate {}

class appregisterloadingstate extends appstate {}

class appsuccessstateregister extends appstate {
  final Registermodel userdata;

  appsuccessstateregister(
    this.userdata,
  );
}

class appERRORstateregister extends appstate {
  final String error;
  appERRORstateregister(this.error);
}

class appappointmentstateinitial extends appstate {}

class appappointmentstateloading extends appstate {}

class appappointmentstatesuccess extends appstate {
  final APPOINTMENTMODEL appointmentmodel;

  appappointmentstatesuccess(
    this.appointmentmodel,
  );
}

class appappointmentstateError extends appstate {
  final String error;
  appappointmentstateError(this.error);
}

class appserviceinitialstate extends appstate {}

class appserviceloadingstate extends appstate {}

class appservicestatesuccess extends appstate {
  final Servicemodel servicemodel;

  appservicestatesuccess(
    this.servicemodel,
  );
}

class appservicestateERROR extends appstate {
  final String error;
  appservicestateERROR(this.error);
}

class apphomestateinitial extends appstate {}

class apphomestateloading extends appstate {}

class apphomestatesuccess extends appstate {
  final HOMEMODEL homemodel;

  apphomestatesuccess(
    this.homemodel,
  );
}

class apphomestateERROR extends appstate {
  final error;
  apphomestateERROR(this.error);
}

class appuserintialstate extends appstate {}

class appuserloadingstate extends appstate {}

class appusersuccessstate extends appstate {
  final Loginmodel? userdata;
  final Loginmodel? token;
  appusersuccessstate(this.userdata, this.token);
}

class appuserERRORstate extends appstate {}

class AppsettingInitialState extends appstate {}

class AppsettingSuccessState extends appstate {
  final userinfo? loginmodel;
  AppsettingSuccessState(this.loginmodel);
}

class AppsettingFailedState extends appstate {
  final error;
  AppsettingFailedState(this.error);
}

class AppsettingLoadingState extends appstate {}

abstract class apploginstate {}

class AppLoginInitialState extends appstate {}

class AppLoginSuccessState extends appstate {
  final Loginmodel userdata;
  final int statuscode;
  AppLoginSuccessState(this.userdata, this.statuscode);
}

class AppLoginFailedState extends appstate {
  final String error;
  AppLoginFailedState(this.error);
}

class AppLoginLoadingState extends appstate {}
