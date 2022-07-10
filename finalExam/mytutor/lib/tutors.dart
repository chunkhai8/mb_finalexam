import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'class def/tutor.dart';
import 'constants.dart';

class Tutors extends StatefulWidget {
  const Tutors({Key? key}) : super(key: key);

  @override
  State<Tutors> createState() => _TutorsState();
}

class _TutorsState extends State<Tutors> {
  List<Tutor> tutorList = <Tutor>[];
  String titlecenter = "Loading...";
  var numofpage, curpage = 1;
  var color;
  late double screenHeight, screenWidth, resWidth;

  @override
  void initState() {
    super.initState();
      _loadtutors(1);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 400) {
      resWidth = screenWidth*0.5;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.25;
      //rowcount = 3;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text('Tutors'),
        ),
        body: tutorList.isEmpty 
        ? Center(
          child: Text(titlecenter,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))
        ): Column(
            children: [
           const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text("Tutors Available",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 1,
                  children: List.generate(tutorList.length, (index) {
                    return InkWell(
                      splashColor: Colors.green,
                      onTap: () => {_loadtutorDetails(index)},
                      child:Card(
                      child: Column(
                        children: [
                          Flexible(
                            flex:5,
                            child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/mytutorfinalmob/php/assets/tutors/" + 
                                      tutorList[index].tutorid.toString() +
                                      '.jpg',
                                  fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                            ),
                          ),
                          Flexible(
                            flex:5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment:CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Name: "+
                                    tutorList[index].tutorname.toString(),
                                    style: const TextStyle(
                                    fontSize: 16,fontWeight: FontWeight.bold),
                                  ), 
                                  
                                  
                                  Text(
                                    "Email: "+
                                    tutorList[index].tutoremail.toString(),
                                    style: const TextStyle(
                                    fontSize: 16),
                                  ),
                                  Text(
                                    "Phone number: "+
                                    tutorList[index].tutorphone.toString(),
                                    style: const TextStyle(
                                    fontSize: 16),
                                  ),
                                ]
                              ),
                            ),
                          ),
                        ]
                      )
                    )
                    );
              }
              ))),
              SizedBox(
                  height: 30,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: numofpage,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if ((curpage - 1) == index) {
                        color = Colors.lightGreen;
                      } else {
                        color = Colors.grey;
                      }
                      return SizedBox(
                        width: 40,
                        child: TextButton(
                            onPressed: () => {_loadtutors(index + 1)},
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(color: color),
                            )),
                      );
                    },
                  ),
                ),
          ],
        ),
          
    );
  }

  void _loadtutors(int pageno) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
          Uri.parse(CONSTANTS.server + "/mytutorfinalmob/php/load_tutor.php"),
          body: {
            'pageno': pageno.toString(),
            }).then((response) {
      var jsondata = jsonDecode(response.body);
      //print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);
        if (extractdata['tutors'] != null) {
           tutorList = <Tutor>[];
          extractdata['tutors'].forEach((v) {
            tutorList.add(Tutor.fromJson(v));
          });
        } else {
          titlecenter = "No Tutor Available";
          tutorList.clear();
         }
        setState(() {});
         } else {
        //do something
        titlecenter = "No Tutor Available";
        tutorList.clear();
        setState(() {});
      
        }
  });
  }

  _loadtutorDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Tutor Details",
              style: TextStyle(),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/mytutorfinalmob/php/assets/tutors/" + 
                      tutorList[index].tutorid.toString() +
                      '.jpg',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => 
                      const Icon(Icons.error),
                ),
                Column(
                  crossAxisAlignment:CrossAxisAlignment.stretch, 
                  children: [
                  Text(
                  "Name: "+
                  tutorList[index].tutorname.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text("Email: \n"+
                          tutorList[index].tutoremail.toString()),
                  const SizedBox(height: 10),
                  Text("Phone number: \n"+
                          tutorList[index].tutorphone.toString()),
                  const SizedBox(height: 10),
                  Text("Description: \n"+
                           tutorList[index].tutordescription.toString()),
                  const SizedBox(height: 10),
                  Text("Courses (teach): \n"+
                           tutorList[index].subjectname.toString()),
                  
                ]
                ),
              ],
            )
            ),
          );
        }
        );
  }
}