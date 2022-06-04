import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project/models/AUTH MODELS/LOGIN_model.dart';
import 'package:project/models/AUTH MODELS/user_info.dart';
import 'package:project/network/remote/end_points.dart';
import 'package:project/network/remote/local/cachehelper.dart';
import 'package:project/screens/cubit.dart';
import 'package:project/screens/location_map.dart';
import 'package:project/screens/servicepage.dart';
import 'package:project/screens/states/loginstates.dart';
import 'package:project/screens/states/settingsstates.dart';
import 'package:project/screens/upcoming_appointments.dart';
import 'location_picker.dart/locationbutton.dart';
import 'screens/sign_page.dart';
import 'screens/signuppage.dart';
import 'screens/home_screen.dart';
import 'screens/settings.dart';
import 'screens/nearby_service.dart';
import 'splash/splash_screen.dart';
import 'network/remote/diohelper.dart';
import 'API/Api.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugShowCheckedModeBanner:
  false;
  await StorageUtil.getInstance();
  await EasyLoading.init();
  await diohelper.init();

  runApp(myapp());
}

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (BuildContext context) => SplashPage(),
  '/signin': (BuildContext context) => signin_form(),
  '/signup': (BuildContext context) => signup_form(),
  '/locationmap': (BuildContext context) => localmap(),
  '/homescreen': (BuildContext context) => homeScreen(),
  '/nearbyservice': (BuildContext context) => NearbyServicePage(),
  '/settings': (BuildContext context) => settingsScreen(),
  '/upcomingapp': (BuildContext context) => appointmentpage(),
  '/servicepage': (BuildContext context) => serviceScreen(),
};

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => appcubit(appinitialstate())),
        ],
        child: BlocConsumer<appcubit, appstate>(
            listener: (context, state) {},
            builder: (Context, State) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                routes: routes,
              );
            }));
  }
}
