import 'package:dio/dio.dart';
import 'package:to_do/const/toDoModel.dart';

abstract class ProjectService {
  Future<List<Data>?> sendItemApi();
  bool? removeItem(int id);
}

class GeneralService implements ProjectService {
  // Dio dio = Dio();
  Dio dio = Dio(BaseOptions(baseUrl: "http://localhost:3000/"));

  @override
  Future<List<Data>?> sendItemApi() async {
    final response = await dio.get("users");
    if (response.statusCode == 200) {
      final value = ToDoModel.fromJson(response.data);
      return value.data;
    }
    return null;
  }

  @override
  bool? removeItem(int id) {
    final response = dio.delete('users/$id');
    return null;
  }
}
