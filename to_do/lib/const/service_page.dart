import 'package:dio/dio.dart';
import 'package:to_do/const/toDoModel.dart';

abstract class ProjectService {
  Future<List<Data>?> sendItemApi();
  bool? removeItem(int id);
}

class GeneralService implements ProjectService {
  Dio dio = Dio();
  @override
  Future<List<Data>?> sendItemApi() async {
    final response = await dio.get("http://localhost:3000/users");
    if (response.statusCode == 200) {
      final value = ToDoModel.fromJson(response.data);
      return value.data;
    }
    return null;
  }

  @override
  bool? removeItem(int id) {
    final response = dio.delete("users/$id");
    print(response);
    return null;
  }
}
