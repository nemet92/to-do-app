import 'package:dio/dio.dart';
import 'package:to_do/const/toDoModel.dart';

abstract class ProjectService {
  Future<List<TodoModel>?> sendItemApi();
}

class GeneralService implements ProjectService {
  Dio dio = Dio(BaseOptions(baseUrl: "http://localhost:3000/"));
  @override
  Future<List<TodoModel>?> sendItemApi() async {
    final response = await dio.get('users');
    if (response.statusCode == 200) {
      print(response.statusCode);
      final value = response.data;
      if (value is List) {
        return value.map((key) => TodoModel.fromJson(key)).toList();
      }
    }
    return null;
  }
}
