import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'dart:convert' as convert;
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:my_finalapp1/np/Keys.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNP extends StatefulWidget {
  // AddNP({Key? key}) : super(key: key);

  @override
  _AddNPState createState() => _AddNPState();
}

class _AddNPState extends State<AddNP> {
  final _owid = GlobalKey<FormState>();
  final _npname = TextEditingController();
  final _npabout = TextEditingController();
  final _nppho = TextEditingController();
  final _npemail = TextEditingController();
  final _npadress = TextEditingController();
  final _npdist = TextEditingController();
  final _npprov = TextEditingController();
  final _nplat = TextEditingController();
  final _nplong = TextEditingController();
  // final _uimg = TextEditingController();

  var uId;
  var token;
  // var myFormat = DateFormat('d-MM-yyyy');

  Future getNP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    uId = prefs.getInt('id');
    print('uId = $uId');
    print('token = $token');
  }

  void registernip(Map<String, dynamic> values) async {
    // var url = 'http://192.168.0.8:8888/register';
    String url = '${Connectapi().domain}/registernip/$uId';
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: convert.jsonEncode(values));

    if (response.statusCode == 200) {
      print('Register Success');
      // Navigator.pop(context, true);
    } else {
      print('Register not Success!!');
      print(response.body);
    }
  }

  //Upload Images อัพโหลดรูปภาพ =====================
  //ตัวแปรเกี่ยวกับ อัพโหลดรูปภาพ
  // File _image;
  // File _camera;
  // String imgstatus = '';
  // String error = 'Error';
  //! aad profile <<<<<
  var _filename;

  // ตัวแปรเกี่ยวกับ อัพโหลดรูปภาพ

  //multi_image_picker
  List<Asset> _images = <Asset>[];
  Asset _asset;
  String error = 'No Error Dectected';

  //LoadAssets
  Future<void> _loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: _images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _images = resultList;
      print('path : ${_images.length}');
      _error = error;
    });
  }

//multi_image_picker
  Future<String> multiUploadimage(ast) async {
    var urlUpload = '${Connectapi().domain}/uploadsprofilenp';
// create multipart request
    MultipartRequest request =
        http.MultipartRequest("POST", Uri.parse(urlUpload));
    ByteData byteData = await ast.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();

    http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
      'picture', //key of the api
      imageData,
      filename: 'some-file-name.jpg',
      contentType: MediaType("image",
          "jpg"), //this is not nessessory variable. if this getting error, erase the line.
    );
// add file to multipart
    request.files.add(multipartFile);
// send
    var response = await request.send();
    return response.reasonPhrase;
  }

  //Loop รูปภาพ
  Future<void> sendPathImageProfile() async {
    print('path : ${_images.length}');
    for (int i = 0; i < _images.length; i++) {
      _asset = _images[i];
      print('image : $i');
      var res = multiUploadimage(_asset);
    }
  }

  //! add images 10+ <<<<<
  var filename;

  // ตัวแปรเกี่ยวกับ อัพโหลดรูปภาพ

  //multi_image_picker
  List<Asset> images = <Asset>[];
  Asset asset;
  String _error = 'No Error Dectected';

  //LoadAssets
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      images = resultList;
      print('path : ${images.length}');
      _error = error;
    });
  }

//multi_image_picker
  Future<String> _multiUploadimage(ast) async {
    var _urlUpload = '${Connectapi().domain}/uploadsimgnp';
// create multipart request
    MultipartRequest request =
        http.MultipartRequest("POST", Uri.parse(_urlUpload));
    ByteData byteData = await ast.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();

    http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
      'picture', //key of the api
      imageData,
      filename: 'some-file-name.jpg',
      contentType: MediaType("image",
          "jpg"), //this is not nessessory variable. if this getting error, erase the line.
    );
// add file to multipart
    request.files.add(multipartFile);
// send
    var response = await request.send();
    return response.reasonPhrase;
  }

  //Loop รูปภาพ
  Future<void> sendPathImage() async {
    print('path : ${images.length}');
    for (int i = 0; i < images.length; i++) {
      asset = images[i];
      print('image : $i');
      var res = _multiUploadimage(asset);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //call _getAPI
    getNP();
  }

  PickResult selectedPlace;
  var APIkeys = new Keys();
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มร้านของคุณ'),
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
      ),
      // backgroundColor: tBGDeepColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _owid,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // hText('ชื่อร้าน'),
                      // SizedBox(height: 5),
                      npForm(_npname, 'ชื่อร้าน', 'ชื่อร้าน', 1),
                      SizedBox(height: 10),
                      npForm(_npabout, 'เกี่ยวกับร้าน', 'เกี่ยวกับร้าน', 4),
                      SizedBox(height: 10),
                      npForm(_nppho, 'เบอร์โทรร้าน', 'เบอร์โทรร้าน', 1),
                      SizedBox(height: 10),
                      npForm(_npemail, 'E-mail', 'E-mail', 1),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    thickness: 2,
                    color: Colors.white10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      npForm(_npadress, 'ที่อยู่', 'รายละเอียดที่อยู่', 2),
                      SizedBox(height: 10),
                      npForm(_npdist, 'อำเภอ', 'อำเภอ', 1),
                      SizedBox(height: 10),
                      npForm(_npprov, 'จังหวัด', 'จังหวัด', 1),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    thickness: 2,
                    color: Colors.white10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'เพิ่มรูปภาพหน้าร้านของคุณ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '*',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: tErrorColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'เลือกรูปภาพที่ดีที่สุดของร้านคุณ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: tGreyColor,
                                ),
                              ),
                              Text(
                                'เพิ่มรูปภาพร้านของคุณไม่เกิน 1 ภาพ ขนาดไม่เกิน 5 MB',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: tGreyColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          addImgs(_loadAssets),
                        ],
                      ),
                      SizedBox(height: 10),
                      buildImagesProfile(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    thickness: 2,
                    color: Colors.white10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'เพิ่มรูปภาพร้านของคุณ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '*',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: tErrorColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'เพิ่มรูปภาพร้านของคุณไม่เกิน 10 ภาพ ขนาดไม่เกิน 5 MB',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: tGreyColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          addImgs(loadAssets),
                        ],
                      ),
                      SizedBox(height: 10),
                      buildImagesList(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      btnSubmit(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget npForm(
    TextEditingController _controller,
    String hText,
    String _hintText,
    int _maxLine,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              hText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '*',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: tErrorColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: _controller,
          validator: (values) {
            if (values.isEmpty) {
              return 'กรุณากรอกชื่อร้าน';
            }
          },
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          maxLines: _maxLine,
          cursorColor: tPimaryColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: tBGDeepColor,
            hintText: _hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              color: tGreyColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget addImgs(VoidCallback onload) {
    return SizedBox(
      width: 100,
      height: 50,
      child: RaisedButton(
        elevation: 0,
        color: tBGDeepColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            'เพิ่มรูปภาพ',
            style: TextStyle(
              fontSize: 14,
              color: tTextColor,
            ),
          ),
        ),
        onPressed: onload,
      ),
    );
  }

  Widget buildImagesProfile() {
    return SizedBox(
      height: 150,
      child: _images.length <= 0
          ? Card(
              elevation: 0,
              color: tBGDeepColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                height: 150,
                child: Center(
                  child: Text(
                    'เพิ่มรูปภาพของคุณ',
                    style: TextStyle(
                      color: tTextColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            )
          : Card(
              elevation: 0,
              color: tBGDeepColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ListView.builder(
                  itemCount: _images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Card(
                      child: AssetThumb(
                    asset: _images[index],
                    width: 150,
                    height: 150,
                  )),
                ),
              ),
            ),
    );
  }

  Widget buildImagesList() {
    return SizedBox(
      height: 150,
      child: images.length <= 0
          ? Card(
              elevation: 0,
              color: tBGDeepColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                height: 150,
                child: Center(
                  child: Text(
                    'เพิ่มรูปภาพของคุณ',
                    style: TextStyle(
                      color: tTextColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            )
          : Card(
              elevation: 0,
              color: tBGDeepColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ListView.builder(
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Card(
                      child: AssetThumb(
                    asset: images[index],
                    width: 150,
                    height: 150,
                  )),
                ),
              ),
            ),
    );
  }

  Widget namenpForm() {
    return TextFormField(
      controller: _npname,
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกชื่อร้าน';
        }
      },
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: 'ชื่อร้าน',
        focusColor: Theme.of(context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
        // icon: ImageIcon(
        //   new AssetImage('assets/icons/user.png'),
        //   color: Theme.of(context).primaryColor,
        //   // size: 16,
        // ),
      ),
    );
  }

  Widget aboutnpForm() {
    return TextFormField(
      controller: _npabout,
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกเกี่ยวกับร้าน';
        }
      },
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
      ),
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: 'เกี่ยวกับร้าน',
        focusColor: Theme.of(context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
        icon: ImageIcon(
          new AssetImage('assets/icons/user.png'),
          color: Theme.of(context).primaryColor,
          // size: 16,
        ),
      ),
    );
  }

  Widget phonenpForm() {
    return TextFormField(
      controller: _nppho,
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกเบอร์โทรร้าน';
        }
      },
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: 'เบอร์โทรร้าน',
        focusColor: Theme.of(context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
        icon: ImageIcon(
          new AssetImage('assets/icons/user.png'),
          color: Theme.of(context).primaryColor,
          // size: 30,
        ),
      ),
    );
  }

  Widget emailnpForm() {
    return TextFormField(
      controller: _npemail,
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอก E-mail';
        }
      },
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: 'E-mail',
        focusColor: Theme.of(context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
        icon: ImageIcon(
          new AssetImage('assets/icons/user.png'),
          color: Theme.of(context).primaryColor,
          // size: 30,
        ),
      ),
    );
  }

  Widget adressnpForm() {
    return TextFormField(
      controller: _npadress,
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกที่อยู่';
        }
      },
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: 'ที่อยู่',
        focusColor: Theme.of(context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
        icon: ImageIcon(
          new AssetImage('assets/icons/user.png'),
          color: Theme.of(context).primaryColor,
          // size: 30,
        ),
      ),
    );
  }

  Widget distnpForm() {
    return TextFormField(
      controller: _npdist,
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกอำเภอ';
        }
      },
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: 'อำเภอ',
        focusColor: Theme.of(context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 15,
          color: Theme.of(context).primaryColor,
        ),
        icon: ImageIcon(
          new AssetImage('assets/icons/user.png'),
          color: Theme.of(context).primaryColor,
          // size: 30,
        ),
      ),
    );
  }

  Widget provnpForm() {
    return TextFormField(
      controller: _npprov,
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกจังหวัด';
        }
      },
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: 'จังหวัด',
        focusColor: Theme.of(context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
        icon: ImageIcon(
          new AssetImage('assets/icons/user.png'),
          color: Theme.of(context).primaryColor,
          // size: 30,
        ),
      ),
    );
  }

  Widget latnpForm() {
    return TextFormField(
      controller: _nplat,
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกละติจูด';
        }
      },
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: 'ละติจูด',
        focusColor: Theme.of(context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
        icon: ImageIcon(
          new AssetImage('assets/icons/user.png'),
          color: Theme.of(context).primaryColor,
          // size: 30,
        ),
      ),
    );
  }

  Widget longnpForm() {
    return TextFormField(
      controller: _nplong,
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกลองติจูด';
        }
      },
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: 'ลองติจูด',
        focusColor: Theme.of(context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
        icon: ImageIcon(
          new AssetImage('assets/icons/user.png'),
          color: Theme.of(context).primaryColor,
          // size: 30,
        ),
      ),
    );
  }

  Widget btnMap() {
    return SizedBox(
      // width: double.infinity,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Map',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PlacePicker(
                    apiKey: APIkeys.apikey,
                    initialPosition: kInitialPosition,
                    useCurrentLocation: true,
                    selectInitialPosition: true,

                    usePlaceDetailSearch: true,
                    onPlacePicked: (result) {
                      selectedPlace = result;
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                    forceSearchOnZoomChanged: true,
                    automaticallyImplyAppBarLeading: true,
                    autocompleteLanguage: "th",
                    region: 'au',
                    // selectInitialPosition: true,
                    // selectedPlaceWidgetBuilder:
                    //     (_, selectedPlace, state, isSearchBarFocused) {
                    //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                    //   return isSearchBarFocused
                    //       ? Container()
                    //       : FloatingCard(
                    //           bottomPosition:
                    //               0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                    //           leftPosition: 0.0,
                    //           rightPosition: 0.0,
                    //           width: 500,
                    //           borderRadius: BorderRadius.circular(12.0),
                    //           child: state == SearchingState.Searching
                    //               ? Center(child: CircularProgressIndicator())
                    //               : RaisedButton(
                    //                   child: Text("Pick Here"),
                    //                   onPressed: () {
                    //                     var lat = selectedPlace.geometry.location.lat;
                    //                     var lng = selectedPlace.geometry.location.lng;
                    //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                    //                     //            this will override default 'Select here' Button.
                    //                     print("$lat,$lng");
                    //                     Navigator.of(context).pop();
                    //                   },
                    //                 ),
                    //         );
                    // },
                    // pinBuilder: (context, state) {
                    //   if (state == PinState.Idle) {
                    //     return Icon(Icons.favorite_border);
                    //   } else {
                    //     return Icon(Icons.favorite);
                    //   }
                    // },
                  );
                },
              ),
            );
          }),
    );
  }

  Widget btnSubmit() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: tPimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'บันทึก',
            style: TextStyle(
              fontSize: 16,
              color: tTextColor,
            ),
          ),
        ),
        onPressed: () {
          if (_owid.currentState.validate()) {
            Map<String, dynamic> valuse = Map();
            valuse['np_name'] = _npname.text;
            valuse['np_about'] = _npabout.text;
            valuse['np_phone'] = _nppho.text;
            valuse['np_email'] = _npemail.text;
            valuse['np_adress'] = _npadress.text;
            valuse['np_district'] = _npdist.text;
            valuse['np_province'] = _npprov.text;
            // valuse['np_lat'] = _nplat.text;
            // valuse['np_long'] = _nplong.text;

            print(_npname.text);
            print(_npabout);
            print(_nppho.text);
            print(_npemail.text);
            print(_npadress.text);
            print(_npdist.text);
            print(_npprov.text);
            // print(_nplat.text);
            // print(_nplong.text);

            registernip(valuse);
            sendPathImage();
            sendPathImageProfile();
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/addimgsnp');
          }
        },
      ),
    );
  }
}
