import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project/screens/location_map.dart';
import 'package:project/screens/sign_page.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/states/loginstates.dart';

import '../network/remote/local/cachehelper.dart';
import 'cubit.dart';

class signup_form extends StatefulWidget {
  signup_form({Key? key}) : super(key: key);

  @override
  State<signup_form> createState() => _signup_formState();
}

class _signup_formState extends State<signup_form> {
  /* // // var latitude = null;

  // // var longitude = null;

  // // Future getloc() async {
  // //   Position position = await Geolocator.getCurrentPosition(
  // //       desiredAccuracy: LocationAccuracy.medium);
  // //   latitude = position.latitude.toDouble();
  // //   longitude = position.longitude.toDouble();
  // // }*/
  var PhoneNumber = "";
  void _onCountryChange(CountryCode countryCode) {
    this.PhoneNumber = countryCode.toString();

    print("new country selected: " + countryCode.toString());
  }

  TextEditingController username = TextEditingController();
  late final result;
  TextEditingController location = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phonenumberhere = TextEditingController();

  @override
  void initState() {
    super.initState();
    _onCountryChange(CountryCode());

    this.PhoneNumber = "+20";
  }

  var _formKey = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => appcubit(appregisterstate()),
        child: BlocConsumer<appcubit, appstate>(listener: (context, state) {
          if (state is appsuccessstateregister) {
            if (state.userdata.data.token.authToken != null) {
              print(state.userdata.data.token.authToken);
              StorageUtil.putString(
                      'token', state.userdata.data.token.authToken)
                  .then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => homeScreen()));
              });
            } else {
              print("failed to register");
            }
          }
        }, builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                child: SingleChildScrollView(
                  child: Container(
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Column(
                              children: [
                                Expanded(child: Text('')),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 55,
                                            color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 37, 43, 1)
                                      .withOpacity(1), //color of shadow
                                  spreadRadius: 10, //spread radius
                                  blurRadius: 10, // blur radius
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                )
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [1, 0],
                                colors: <Color>[
                                  Color.fromRGBO(0, 37, 43, 1),
                                  Colors.white
                                ],
                                tileMode: TileMode
                                    .clamp, // clamp the gradient over the canvas
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25))),
                            padding: EdgeInsets.all(30),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          " Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: username,
                                      keyboardType: TextInputType.text,
                                      onFieldSubmitted: (value) {},
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter a valid Name!';
                                        }
                                        return null;
                                      },
                                      // ignore: prefer_const_constructors
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 10),
                                        hintText: 'Enter Name.',
                                        hintStyle: const TextStyle(
                                            color: Colors.black),
                                        filled: true,
                                        fillColor: const Color.fromRGBO(
                                            227, 227, 226, 0.2),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          " Phone Number",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: phonenumberhere,
                                      keyboardType: TextInputType.number,
                                      onFieldSubmitted: (value) {},
                                      validator: validateMobile,
                                      // ignore: prefer_const_constructors
                                      decoration: InputDecoration(
                                        prefixIcon: CountryCodePicker(
                                          onChanged: _onCountryChange,
                                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                          initialSelection: '+20',
                                          favorite: ['+20', 'EG'],
                                          textStyle: const TextStyle(
                                              color: Colors.black),
                                          showFlag: true,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 10),
                                        hintText: 'Enter Phone Number.',
                                        hintStyle: const TextStyle(
                                            color: Colors.black),
                                        filled: true,
                                        fillColor: const Color.fromRGBO(
                                            227, 227, 226, 0.2),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          " Location",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => localmap()));
                                      },
                                      child: Container(
                                        child: TextFormField(
                                          onTap: () async {
                                            result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        localmap()));
                                            location.text =
                                                '${result.street}${result.district}${result.city}';
                                          },
                                          controller: location,
                                          keyboardType: TextInputType.text,
                                          onFieldSubmitted: (value) {},
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter a valid location!';
                                            }
                                            return null;
                                          },
                                          // ignore: prefer_const_constructors
                                          decoration: InputDecoration(
                                            prefixIcon: IconButton(
                                              onPressed: () async {
                                                result = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            localmap()));
                                                location.text =
                                                    '${result.street}${result.district}${result.city}';
                                              },
                                              icon: Icon(
                                                Icons.location_on_sharp,
                                                color: Colors.red,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 10),
                                            hintText: 'Enter location.',
                                            hintStyle: const TextStyle(
                                                color: Colors.black),
                                            filled: true,
                                            fillColor: const Color.fromRGBO(
                                                227, 227, 226, 0.2),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          " Password",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      controller: password,
                                      keyboardType: TextInputType.text,
                                      onFieldSubmitted: (value) {},
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter a valid password!';
                                        }
                                        return null;
                                      },
                                      // ignore: prefer_const_constructors
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 10),
                                        hintText: 'Enter Password.',
                                        hintStyle: const TextStyle(
                                            color: Colors.black),
                                        filled: true,
                                        fillColor: const Color.fromRGBO(
                                            227, 227, 226, 0.2),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Text("")),
                                    ConditionalBuilder(
                                      condition:
                                          state is! appregisterloadingstate,
                                      builder: (Context) => FlatButton(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        minWidth:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            appcubit.get(Context).userregister(
                                                phone_number:
                                                    " ${PhoneNumber + phonenumberhere.text}",
                                                password: password.text,
                                                name: username.text,
                                                city: result.city,
                                                district: result.district,
                                                street: result.street,
                                                context: context);

                                            // If the form is valid, display a snackbar. In the real world,
                                            // you'd often call a server or save the information in a database.
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(""),
                                              ),
                                            );
                                          }
                                        },
                                        color: const Color.fromRGBO(
                                            0, 168, 165, 1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Text(
                                          "Register",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19),
                                        ),
                                      ),
                                      fallback: (BuildContext context) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      signin_form()));
                                        },
                                        child: Text("Login",
                                            style:
                                                TextStyle(color: Colors.black)))
                                  ],
                                )),
                          )
                        ],
                      )),
                ),
              ));
        }));
  }
}

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
