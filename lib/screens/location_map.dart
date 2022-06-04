import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as LatLng;
import 'package:location/location.dart' as loc;
import 'package:project/location_picker.dart/locationbutton.dart';
import 'package:project/location_picker.dart/widget/search_widget.dart';
import 'package:project/screens/constants.dart';

import '../location_picker.dart/utils/google_search/place.dart';

loc.Location location = loc.Location();

getloc2() async {
  bool _serviceEnabled;
  loc.PermissionStatus _permissionGranted;
  loc.LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == loc.PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != loc.PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();
}

class localmap extends StatefulWidget {
  localmap({Key? key}) : super(key: key);

  @override
  State<localmap> createState() => _localmapState();
}

class _localmapState extends State<localmap> {
  TextEditingController search = TextEditingController();
  var radius = 10;
  var latitude = 26.820553;
  var longitude = 30.802498;
  var area = '';
  var zoom = 13.0;
  var herelocal;
  late List<Location> locations;
  List<Placemark> placemarks = [];
  var latlng1 = LatLng.LatLng(26.820553, 30.802498);

  Future searchaddress() async {
    locations = await locationFromAddress("${search}");
    var address = locations.first;
    latitude = address.latitude.toDouble();
    longitude = address.longitude.toDouble();
    setState(() {
      latlng1 = LatLng.LatLng(address.latitude, address.longitude);
      area = '${search.text}';
    });
    return [_mapctl.move(latlng1, zoom), LatLng.LatLng(latitude, longitude)];
  }

  Future getloc() async {
    //the zoom you want
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    latitude = position.latitude.toDouble();
    longitude = position.longitude.toDouble();
    latlng1 = LatLng.LatLng(latitude, longitude);
    _mapctl.move(latlng1, zoom);

    placemarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark placeMark = placemarks[2];
    String? street = placeMark.street;
    String? subAdministrativeArea = placeMark.subAdministrativeArea;
    String? country = placeMark.country;
    String? administrativeArea = placeMark.administrativeArea;

    String address =
        " ${street} Street, ${subAdministrativeArea},\n ${administrativeArea} ";

    setState(() {
      area = address;
      _mapctl.move(latlng1, zoom); // update _address
    });
  }

  MapController _mapctl = MapController();
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: [
        FlutterMap(
            mapController: _mapctl,
            options: MapOptions(
              plugins: [DragMarkerPlugin()],
              center: LatLng.LatLng(latitude, longitude),
              zoom: 5.0,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/ezzeldin/ckzu5y17700tt14p83inr0ppj/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZXp6ZWxkaW4iLCJhIjoiY2wydGN2MTlwMDM1ZzNpbXc3N2gzYTVibSJ9.CeiaVjO-85hs6qzcU4dGhA",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1IjoiZXp6ZWxkaW4iLCJhIjoiY2wydGN2MTlwMDM1ZzNpbXc3N2gzYTVibSJ9.CeiaVjO-85hs6qzcU4dGhA',
                    'id': 'mapbox.mapbox-streets-v8'
                  }),
              DragMarkerPluginOptions(
                markers: [
                  DragMarker(
                    point: LatLng.LatLng(latitude, longitude),
                    width: 80.0,
                    height: 80.0,
                    builder: (ctx) =>
                        Container(child: Icon(Icons.location_on, size: 50)),
                    onDragEnd: (details, point) {
                      print('Finished Drag $details $point');
                    },
                    updateMapNearEdge: true,
                  )
                ],
              )
            ]),
        Positioned(
            top: 35.0,
            left: 0.0,
            right: 0.0,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Material(
                    color: Colors.transparent,
                    elevation: 15,
                    shadowColor: Colors.black,
                    child: SearchLocation(
                      apiKey: 'AIzaSyDPvs6-uVebgmDLLI6rFHiUBpCPBmGo6JI',
                      // The language of the autocompletion
                      language: 'en',
                      //Search only work for this specific country
                      country: 'EG', iconColor: Colors.black,
                      onSelected: (Place place) async {
                        final geolocation = await place.geolocation;
                        latitude = geolocation?.coordinates.latitude;
                        longitude = geolocation?.coordinates.longitude;
                        latlng1 = LatLng.LatLng(
                            geolocation?.coordinates.latitude,
                            geolocation?.coordinates.longitude);
                        final here = _mapctl.move(latlng1, zoom);
                        setState(() {
                          area = place.description;
                          _mapctl.move(latlng1, zoom);
                        });
                      },
                    )),
              ),
            ])),
        Positioned(
            bottom: 225.0,
            left: 300.0,
            right: 0.0,
            child: SizedBox(
              height: 50,
              width: 50,
              child: FloatingActionButton(
                /////// HERE

                backgroundColor: const Color.fromRGBO(0, 168, 165, 1),
                onPressed: () async {
                  getloc();
                  getloc2();
                },
                child: Container(
                    child: Icon(Icons.gps_fixed_sharp),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 168, 165, 1),
                    )),
              ),
            )),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(40)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), //color of shadow
                      spreadRadius: 7, //spread radius
                      blurRadius: 7, // blur radius
                      offset: Offset(0, 2), // changes position of shadow
                      //first paramerter of offset is left-right
                      //second parameter is top to down
                    )
                  ]),
              padding: EdgeInsets.all(10),
              height: 200.0,
              width: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(children: [
                      SizedBox(
                        width: 50,
                        height: 120,
                      ),
                      Icon(
                        Icons.location_on_sharp,
                        color: Colors.red,
                        size: 35,
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Address",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            area,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            maxLines: 4,
                          )
                        ],
                      )
                    ]),
                    FlatButton(
                      height: 50,
                      minWidth: 300,
                      onPressed: () {
                        List values = area.split(
                            ","); // split() will split from . and gives new List with separated elements.
                        values.forEach(print);
                        print(values[0]);
                        Navigator.pop(
                            context,
                            addressspiltreturns(
                                values[0], values[1], values[2]));
                      },
                      color: const Color.fromRGBO(0, 168, 165, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ]),
    );
  }
}
