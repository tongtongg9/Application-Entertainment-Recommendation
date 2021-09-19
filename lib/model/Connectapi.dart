class MyipAddress {
  String ipaddress = 'http://192.168.7.107';
  MyipAddress();
}

class Connectapi {
  String domain = '${MyipAddress().ipaddress}:8888';
  String domainimgnpforuser =
      '${MyipAddress().ipaddress}:8888/uploads/images_np/';
  String domainimguser = '${MyipAddress().ipaddress}:8888/uploads/images/';
  String domainimgnp = '${MyipAddress().ipaddress}:8888/uploads/img_np/';
  String domainimgpro = '${MyipAddress().ipaddress}:8888/uploads/img_pro/';
  Connectapi();
}
