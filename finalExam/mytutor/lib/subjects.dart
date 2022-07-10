import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'cartscreen.dart';
import 'class def/subject.dart';
import 'class def/user.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Subjects extends StatefulWidget {
  final User user;
  const Subjects({Key? key, required this.user}) : super(key: key);

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  List<Subject> subjectList = <Subject>[];
  String titlecenter = "Loading...";
  var numofpage, curpage = 1;
  var color;
  late double screenHeight, screenWidth, resWidth;
  TextEditingController searchcontroller = TextEditingController();
  String search = "";
  int cart =0;

  @override
  void initState() {
    super.initState();
      _loadSubjects(1,search);
      _loadMyCart();  
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth*0.60;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text('Subjects'),
          actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          ),
          TextButton.icon(
            onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => Cartscreen(
                          user: widget.user,
                        )));
            _loadSubjects(1,search);
            _loadMyCart();  
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ), 
            label:  Text(widget.user.cart.toString(),
                style: const TextStyle(color: Colors.white)),
            
    
          ),
        ],
        ),
        body: subjectList.isEmpty 
        ? Center(
          child: Text(titlecenter,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))
        ): Column(
            children: [
           const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text("Subjects Available",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 1,
                  children: List.generate(subjectList.length, (index) {
                    return InkWell(
                      splashColor: Colors.green,
                      onTap: () => {_loadsubjectDetails(index)},
                      child:Card(
                      child: Column(
                            children: [
                              Flexible(
                                flex: 5,
                                child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/mytutorfinalmob/php/assets/courses/" +
                                      subjectList[index].subjectid.toString() +
                                      '.png',
                                  fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Course name: \n" + subjectList[index].subjectname.toString(),
                                      style: const TextStyle(
                                          fontSize: 15,fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Price: RM" + subjectList[index].subjectprice.toString(),
                                      style: const TextStyle(
                                        fontSize: 13),
                                    ),
                                    Text(
                                      "Learning hours: " + subjectList[index].subjectsessions.toString() + " hours",
                                      style: const TextStyle(
                                        fontSize: 13),
                                    ),
                                    Text(
                                      "Rating: " + subjectList[index].subjectrating.toString(),
                                      style: const TextStyle(
                                        fontSize: 13),
                                    ),
                                    Text(
                                      "Teach by: " + subjectList[index].tutorname.toString(),
                                      style: const TextStyle(
                                        fontSize: 13),
                                    ),
                                    Expanded(
                                            flex: 3,
                                            child: IconButton(
                                              alignment: Alignment.centerRight,
                                                onPressed: () {
                                                  _addtoCartlist(index);
                                                },
                                                icon: const Icon(Icons.shopping_cart))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                        );
                      },
                    ),
                  ),
                ),
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
                            onPressed: () => {_loadSubjects(index + 1,"")},
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

  void _loadSubjects(int pageno,String _search) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
          Uri.parse(CONSTANTS.server + "/mytutorfinalmob/php/load_subject.php"),
          body: {
            'pageno': pageno.toString(),
            'search': _search,
            }).then((response) {
      var jsondata = jsonDecode(response.body);
      //print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);
        if (extractdata['subjects'] != null) {
           subjectList = <Subject>[];
          extractdata['subjects'].forEach((v) {
            subjectList.add(Subject.fromJson(v));
          });
        } else {
          titlecenter = "No Subject Available";
          subjectList.clear();
         }
        setState(() {});
         } else {
        //do something
        titlecenter = "No Subject Available";
        subjectList.clear();
        setState(() {});
      
        }
  });
  }

  void _loadSearchDialog() {
    searchcontroller.text = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Search subject ",
                ),
                content: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: searchcontroller,
                        decoration: InputDecoration(
                            labelText: 'Enter subject name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen),
                    onPressed: () {
                      search = searchcontroller.text;
                      Navigator.of(context).pop();
                      _loadSubjects(1, search);
                    },
                    child: const Text("Search"),
                  )
                ],
              );
            },
          );
        });
  }

  _loadsubjectDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Subject Detail",
              style: TextStyle(),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/mytutorfinalmob/php/assets/courses/" +
                       subjectList[index].subjectid.toString() +
                       '.png',
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
                    "Course name: " + subjectList[index].subjectname.toString(),
                    style: const TextStyle(
                        fontSize: 14,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Price: RM" + subjectList[index].subjectprice.toString() +
                    " / " + subjectList[index].subjectsessions.toString() + " hours",
                    style: const TextStyle(
                        fontSize: 12),
                   ),
                  Text(
                    "Rating: " + subjectList[index].subjectrating.toString(),
                    style: const TextStyle(
                        fontSize: 12),
                  ),
                  Text(
                    "Teach by: " + subjectList[index].tutorname.toString(),
                    style: const TextStyle(
                        fontSize: 12),
                  ),
                  Text(
                    "Description: "+ subjectList[index].subjectdescription.toString(),
                    style: const TextStyle(
                        fontSize: 12),
                  ),
                ]
                ),
              ],
            )
            ),
            actions: [
              SizedBox(
                  width: screenWidth / 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen),
                      onPressed: () {
                        _addtoCartlist(index);
                      },
                      child: const Text("Add to cart"))),
            ], 
          );
        }
        );
  }

  void _addtoCart(int index) {
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutorfinalmob/php/insert_cart.php"),
        body: {
          "email": widget.user.email.toString(),
          "subjid": subjectList[index].subjectid.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        print(jsondata['data']['carttotal'].toString());
        setState(() {
          widget.user.cart = jsondata['data']['carttotal'].toString();
        });
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }

  void _addtoCartlist(int index) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Register new subject",
              style: TextStyle(),
            ),
            content: const Text("Are you sure want to add this subject?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _addtoCart(index);
                },
              ),
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
  }

  void _loadMyCart() {
      http.post(
          Uri.parse(
              CONSTANTS.server + "/mytutorfinalmob/php/load_mycartqty.php"),
          body: {
            "email": widget.user.email.toString(),
          }).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response(
              'Error', 408); // Request Timeout response status code
        },
      ).then((response) {
        print(response.body);
        var jsondata = jsonDecode(response.body);
        if (response.statusCode == 200 && jsondata['status'] == 'success') {
          print(jsondata['data']['carttotal'].toString());
          setState(() {
            widget.user.cart = jsondata['data']['carttotal'].toString();
          });
        }
      });
    
  }
}