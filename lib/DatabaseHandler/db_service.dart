import 'package:dentisttry/Model/data_model.dart';
import 'package:dentisttry/DatabaseHandler/db_appointment.dart';

//functional db for CRUD.. Create, read, update, delete
class DBService {
  Future<bool> addProduct(ServiceModel model) async {
    await DB.init();
    bool isSaved = false;
    if (model != null) {
      int inserted = await DB.insert(ServiceModel.table, model);

      isSaved = inserted == 1 ? true : false;
    }

    return isSaved;
  }

  Future<bool> updateProduct(ServiceModel model) async {
    await DB.init();
    bool isSaved = false;
    if (model != null) {
      int inserted = await DB.update(ServiceModel.table, model);

      isSaved = inserted == 1 ? true : false;
    }

    return isSaved;
  }

  Future<List<ServiceModel>> getProducts() async {
    await DB.init();
    List<Map<String, dynamic>> dental_info = await DB.query(ServiceModel.table);

    return dental_info.map((item) => ServiceModel.fromMap(item)).toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    await DB.init();
    List<Map<String, dynamic>> categories = await DB.query(CategoryModel.table);

    return categories.map((item) => CategoryModel.fromMap(item)).toList();
  }

  Future<bool> deleteProduct(ServiceModel model) async {
    await DB.init();
    bool isSaved = false;
    if (model != null) {
      int inserted = await DB.delete(ServiceModel.table, model);

      isSaved = inserted == 1 ? true : false;
    }

    return isSaved;
  }
}
