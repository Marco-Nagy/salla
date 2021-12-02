/// status : true
/// message : "تم تسجيل الدخول بنجاح"
/// data : {"id":6442,"name":"marco","email":"marcon@gmail.com","phone":"01220407000","image":"https://student.valuxapps.com/storage/assets/defaults/user.jpg","points":0,"credit":0,"token":"RXbhJP00dbJOXgS6zgvAcyugBikWng0Zb4esRvBiOoof3qhWvDymB8tHBPXsmEgBTmkUAW"}

class LoginResponse {
  LoginResponse({
      bool? status, 
      String? message, 
      UserData? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  LoginResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  UserData? _data;

  bool? get status => _status;
  String? get message => _message;
  UserData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 6442
/// name : "marco"
/// email : "marcon@gmail.com"
/// phone : "01220407000"
/// image : "https://student.valuxapps.com/storage/assets/defaults/user.jpg"
/// points : 0
/// credit : 0
/// token : "RXbhJP00dbJOXgS6zgvAcyugBikWng0Zb4esRvBiOoof3qhWvDymB8tHBPXsmEgBTmkUAW"

class UserData {
  UserData({
      int? id, 
      String? name, 
      String? email, 
      String? phone, 
      String? image, 
      int? points, 
      int? credit, 
      String? token,}){
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _image = image;
    _points = points;
    _credit = credit;
    _token = token;
}

  UserData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
    _points = json['points'];
    _credit = json['credit'];
    _token = json['token'];
  }
  int? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _image;
  int? _points;
  int? _credit;
  String? _token;

  int? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get image => _image;
  int? get points => _points;
  int? get credit => _credit;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image'] = _image;
    map['points'] = _points;
    map['credit'] = _credit;
    map['token'] = _token;
    return map;
  }

}