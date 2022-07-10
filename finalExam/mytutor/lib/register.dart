
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'constants.dart';
import 'login.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double screenHeight,screenWidth;
  bool remember = false;
  final _formKey = GlobalKey<FormState>();
  String pathAsset = 'assets/images/camera.png';
  var _image;
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  final TextEditingController _phonenoEditingController = TextEditingController();
  final TextEditingController _addressEditingController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(
          children: [
            upperHalf(context),lowerHalf(context)
          ],
        ),
      );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight/2,
      width: screenWidth,
      child: Image.asset('assets/images/register.png',
      fit:BoxFit.cover,), 
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
      height:400,
      margin: EdgeInsets.only(top: screenHeight/7),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
         child: Column(
          children: [
            Card(            
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 10, 20, 25),
                child: Column(
                  children: <Widget>[
                    const Text(
                      "Register New Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),GestureDetector(
                            onTap: () => {_takePictureDialog()},
                  child: SizedBox(
                      height: screenHeight / 2.5,
                      width: screenWidth,
                      child: _image == null
                          ? Image.asset(pathAsset)
                          : Image.file(
                              _image,
                              fit: BoxFit.cover,
                  ))),
                    
                    const SizedBox(height:10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focus);
                      },
                      controller: _nameEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        icon: Icon(Icons.person),
                        ),
                      ),
                    const SizedBox(height:10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focus1);
                      },
                      controller: _emailEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.mail),
                        ),
                      ),
                    const SizedBox(height:10),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      focusNode: focus1,
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focus2);
                      },
                      controller: _passEditingController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                    const SizedBox(height:10),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      focusNode: focus2,
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focus3);
                      },
                      controller: _pass2EditingController,
                      decoration: const InputDecoration(
                        labelText: 'Re-enter Password',
                        icon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                    const SizedBox(height:10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      focusNode: focus3,
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focus4);
                      },
                      controller: _addressEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Home Address',
                        icon: Icon(Icons.house),
                        ),
                      ),
                    const SizedBox(height:10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      focusNode: focus4,
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focus5);
                      },
                      controller: _phonenoEditingController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        icon: Icon(Icons.phone),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(),
                      ),
                      const SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                          value: remember,
                          onChanged:(bool? value) {
                            setState(() {
                              _isChecked(value!);});
                          } ),
                          Flexible(child: GestureDetector(
                            onTap: null,
                            child: const Text('Agree with terms',
                            style: TextStyle(
                              fontSize:12,
                              fontWeight: FontWeight.bold,
                            )),
                          )
                          ),
                          MaterialButton(
                            color: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            minWidth: 115,
                            height: 50,
                            child: const Text('Register'),
                            elevation: 10,
                            onPressed: _registerAccount,
                          )
                        ],
                      )  
                  ],

                ),
              ),
            ),
            const SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Alredy Register?', style: TextStyle(fontSize: 12)),
                GestureDetector(
                  onTap: _back,
                  child: const Text('Login here', style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                )
              ],
            ),
            const SizedBox(height:5),
            MaterialButton(
                            color: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            minWidth: 115,
                            height: 50,
                            child: const Text('Back'),
                            elevation: 10,
                            onPressed: _back,
            ),
          ],
        ), 
        )
        
      ),
    );

  }

  void _isChecked(bool value) {
    remember = value;
  }

  void _registerAccount(){
    if (_formKey.currentState!.validate() && _image != null) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Register new account",
              style: TextStyle(),
            ),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _adduser();
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
  }

  void _adduser(){
    String _username = _nameEditingController.text;
    String _useremail = _emailEditingController.text;
    String _userpass = _passEditingController.text;
    String _userphoneno = _phonenoEditingController.text;
    String _useraddress = _addressEditingController.text;
    String base64Image = base64Encode(_image!.readAsBytesSync());
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutorfinalmob/php/user_register.php"),
        body: {
          "name": _username,
          "email": _useremail,
          "password": _userpass,
          "phoneno": _userphoneno,
          "address": _useraddress,
          "image": base64Image,
        }).then((response) {
      print(response.body);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const LoginScreen()));
      } else {
        Fluttertoast.showToast(
            msg: data['status'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }

  void _back(){
    Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => const LoginScreen()));
  }

   _takePictureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                    onPressed: () => {
                          Navigator.of(context).pop(),
                          _photosPicker(),
                        },
                    icon: const Icon(Icons.browse_gallery),
                    label: const Text("Gallery")),
                TextButton.icon(
                    onPressed: () =>
                        {Navigator.of(context).pop(), _cameraPicker()},
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera")),
              ],
            ));
      },
    );
  }

  void _photosPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 900,
      maxWidth: 900,
    );
    setState(() {
      if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();

    }
    });
  }
  
  void _cameraPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 900,
      maxWidth: 900,
    );
     setState(() {
      if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
    });
  }

  Future<void> _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }
}

