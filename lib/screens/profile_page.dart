import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'package:dio/dio.dart';
import 'package:readmore/readmore.dart';

/* 
bool _show = false;
final _gKey = new GlobalKey<ScaffoldState>();

void displayBottomSheet() {
  _gKey.currentState?.showBottomSheet((context) {
    return Container(
        padding: const EdgeInsets.all(20),
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
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 1,
        child: Column(children: [
          Row(
            children: [
              Container(
                transform: Matrix4.translationValues(10.0, -85.0, 0.0),
                height: 150,
                width: 125,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https:th.bing.com/th/id/R.38e8743d6263a1a6fe0b4977590b38ba?rik=S9pn9q0csEwkgA&pid=ImgRaw&r=0"),
                        fit: BoxFit.fill)),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                transform: Matrix4.translationValues(15.0, -40.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "",
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    const Text(
                      "Electrician",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const Text(
                      "Michael isaac",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                        ),
                        const Text(
                          "Address here",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -50.0, 0.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Reviews",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Display the data loaded from sample.json

                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 1,
                        child: ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 140,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  margin: const EdgeInsets.all(8),
                                  child: ListTile(
                                      tileColor: const Color.fromARGB(
                                          20, 173, 173, 173),
                                      title: Container(
                                          width: 100,
                                          child: Text(
                                            _items[index]["name"],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      subtitle: Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: SingleChildScrollView(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: ReadMoreText(
                                                  _items[index]["comment"],
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  trimLines: 3,
                                                  colorClickableText:
                                                      Colors.black,
                                                  trimMode: TrimMode.Line,
                                                  trimCollapsedText:
                                                      'Show more',
                                                  trimExpandedText: 'Show less',
                                                  moreStyle: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ]),
                                      ))),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                      padding: const EdgeInsets.only(top: 2, bottom: 20),
                      child: FlatButton(
                        height: 60,
                        minWidth: 135,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: const Color.fromRGBO(0, 168, 165, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          "Call",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 2, bottom: 20),
                      child: FlatButton(
                        height: 60,
                        minWidth: 135,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                color: Color.fromRGBO(0, 168, 165, 1))),
                        child: const Text(
                          "Schedule",
                          style: TextStyle(
                              color: Color.fromRGBO(0, 168, 165, 1),
                              fontSize: 19),
                        ),
                      )),
                ],
              ))
        ]));
  });
}
*/