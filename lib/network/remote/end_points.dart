import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/Widgets/schedulewidget.dart';
import 'package:http/http.dart' as http;

const LOGIN = 'api/a/login';
const REGISTER = 'api/a/register';
const post_user_info = 'api/a/user';
const logout = 'api/a/logout';
const get_user_info = 'api/a/user';
const GETHOME = 'api/f/home';
const getservicedetails = 'api/f/service_details';
const GETSERVICE = 'api/f/services';
const SCHEDULEAPPOINTMENT = 'api/f/schedule_appointment';
const GETAPPOINTMENTS = 'api/f/appointments';
const GETNEARBYSERVICEPROVIDERS = 'api/f/nearby_services_providers';
const SEARCHPAGERESULT = 'api/f/search';
const GETAPPOINTMENTDETAILS = 'api/f/appointment_details';
const WRITEREVIEW = 'api/f/write_review';
const GETAPPOINTINVOICE = 'api/f/get_app_invoice';
const GETSERVICEPROVIDERDETAILSHERE = 'api/f/nearby_service_providers';
const getcommentserviceagent='api/f/get_app_review';
const baseurl = ' http://0.0.0.0:8000';
Future<String> getFilePath(uniqueFileName) async {
  String path = '';

  Directory? dir = await getExternalStorageDirectory();

  path = '${dir!.path}/$uniqueFileName';

  return path;
}
