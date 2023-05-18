import 'package:dentisttry/Model/model.dart';

class ServiceModel extends Model {
  static String table = 'dental_info'; //connect screeen with database

  int id;
  String name; //name
  int categoryId;
  String email; //email
  double phone; //phone
  String date; //date

  ServiceModel({
    this.id,
    this.name, //uname
    this.categoryId,
    this.email, //email
    this.phone, //phonenum
    this.date, //date
  });

  static ServiceModel fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map["id"],
      name: map['name'].toString(), //uname
      categoryId: map['categoryId'],
      email: map['email'], //email
      phone: map['phone'], //pnonenum
      date: map['date'].toString(), //date
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name, //uname
      'categoryId': categoryId,
      'email': email, //email
      'phone': phone, //phonenum
      'date': date //date
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}

class CategoryModel extends Model {
  static String table = 'dental_type';

  String categoryName;
  int categoryId;

  CategoryModel({
    this.categoryId,
    this.categoryName,
  });

  static CategoryModel fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map["id"],
      categoryName: map['categoryName'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'categoryName': categoryName,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
