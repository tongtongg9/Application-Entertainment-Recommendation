// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:my_finalapp1/model/Connectapi.dart';
// import 'package:my_finalapp1/widget/colors.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';

// class AddPromotionsImg extends StatefulWidget {
//   // AddPromotionsImg({Key? key}) : super(key: key);

//   @override
//   _AddPromotionsImgState createState() => _AddPromotionsImgState();
// }

// class _AddPromotionsImgState extends State<AddPromotionsImg> {
//   //Upload Images อัพโหลดรูปภาพ =====================
//   //ตัวแปรเกี่ยวกับ อัพโหลดรูปภาพ
//   // File _image;
//   // File _camera;
//   // String imgstatus = '';
//   // String error = 'Error';
//   //! aad profile <<<<<
//   var _filename;

//   // ตัวแปรเกี่ยวกับ อัพโหลดรูปภาพ

//   //multi_image_picker
//   List<Asset> _images = <Asset>[];
//   Asset _asset;
//   String error = 'No Error Dectected';

//   //LoadAssets
//   Future<void> _loadAssets() async {
//     List<Asset> resultList = <Asset>[];
//     String error = 'No Error Detected';
//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 1,
//         enableCamera: true,
//         selectedAssets: _images,
//         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "Example App",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//     } on Exception catch (e) {
//       error = e.toString();
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//     setState(() {
//       _images = resultList;
//       print('path : ${_images.length}');
//       error = error;
//     });
//   }
// //multi_image_picker
//   Future<String> multiUploadimage(ast) async {
//     var urlUpload = '${Connectapi().domain}/uploadsprofilenp';
// // create multipart request
//     MultipartRequest request =
//         http.MultipartRequest("POST", Uri.parse(urlUpload));
//     ByteData byteData = await ast.getByteData();
//     List<int> imageData = byteData.buffer.asUint8List();

//     http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
//       'picture', //key of the api
//       imageData,
//       filename: 'some-file-name.jpg',
//       contentType: MediaType("image",
//           "jpg"), //this is not nessessory variable. if this getting error, erase the line.
//     );
// // add file to multipart
//     request.files.add(multipartFile);
// // send
//     var response = await request.send();
//     return response.reasonPhrase;
//   }

//   //Loop รูปภาพ
//   Future<void> sendPathImageProfile() async {
//     print('path : ${_images.length}');
//     for (int i = 0; i < _images.length; i++) {
//       _asset = _images[i];
//       print('image : $i');
//       var res = multiUploadimage(_asset);
//     }
//   }


//   @override
//   Widget build(BuildContext context) => 
// }
