import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project/models/AUTH MODELS/LOGIN_model.dart';
import 'package:project/models/errorsmodel/LoginERRORmodel.dart';
import 'package:project/network/remote/diohelper.dart';
import 'package:project/network/remote/local/cachehelper.dart';
import 'package:project/screens/cubit.dart';
import 'package:project/screens/location_map.dart';
import 'package:project/screens/sign_page.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/signuppage.dart';
import 'package:project/screens/states/loginstates.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:toast/toast.dart';

class signin_form extends StatefulWidget {
  signin_form({Key? key}) : super(key: key);

  @override
  State<signin_form> createState() => _signin_formState();
}

class _signin_formState extends State<signin_form> {
  var PhoneNumber = "";
  void _onCountryChange(CountryCode countryCode) {
    this.PhoneNumber = countryCode.toString();

    print("new country selected: " + countryCode.toString());
  }

  var password = TextEditingController();

  var phonenumberhere = TextEditingController();
  var statuscodehere;
  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _onCountryChange(CountryCode());

    this.PhoneNumber = "+20";
  }

  var _formKey = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => appcubit(AppLoginInitialState()),
      child: BlocConsumer<appcubit, appstate>(
        listener: (context, state) {
          if (state is AppLoginSuccessState) {
            statuscodehere = state.statuscode;
            if (state.userdata.data.token.authToken != null) {
              print(state.userdata.data.token.authToken);
              StorageUtil.putString(
                      'token', state.userdata.data.token.authToken)
                  .then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => homeScreen()));
              });
            } else {
              print("failed to login");
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                child: SingleChildScrollView(
                  child: Stack(children: [
                    Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
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
                              height: MediaQuery.of(context).size.height * 0.6,
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
                                        height: 40,
                                      ),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            " Mobile Number",
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
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
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
                                            " Password",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: password,
                                        keyboardType: TextInputType.text,
                                        obscureText: !_passwordVisible,
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
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                            icon: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                          ),
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
                                                color: Colors.white, width: 2),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
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
                                            state is! AppLoginLoadingState,
                                        builder: (Context) => FlatButton(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              appcubit.get(Context).userlogin(
                                                  phone_number:
                                                      " ${PhoneNumber + phonenumberhere.text}",
                                                  password: password.text,
                                                  context: context);
                                              appcubit.get(context)
                                                ..gethome(
                                                    Token:
                                                        StorageUtil.getString(
                                                            'token'))
                                                ..getservice(
                                                    Token:
                                                        StorageUtil.getString(
                                                            'token'));
                                              EasyLoading.showToast(
                                                  StorageUtil.getString(
                                                      'errordetail'),
                                                  toastPosition:
                                                      EasyLoadingToastPosition
                                                          .bottom);
                                              // If the form is valid, display a snackbar. In the real world,
                                              // you'd often call a server or save the information in a database.
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "${StorageUtil.getString('error')}"),
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
                                            "Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19),
                                          ),
                                        ),
                                        fallback: (BuildContext context) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (Context) =>
                                                        signup_form()));
                                          },
                                          child: Text("Create Account",
                                              style: TextStyle(
                                                  color: Colors.black)))
                                    ],
                                  )),
                            )
                          ],
                        )),
                    Center(
                      child: Container(
                        transform: Matrix4.translationValues(
                            MediaQuery.of(context).size.width * 0.00001,
                            MediaQuery.of(context).size.height * 0.16,
                            0),
                        alignment: Alignment.bottomCenter,
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/2.png')),
                        ),
                      ),
                    )
                  ]),
                ),
              ));
        },
      ),
    );
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
