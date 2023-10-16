import 'package:trilhaapp/model/post_model.dart';
import 'package:trilhaapp/repositories/custom_dio_jsonplaceholder.dart';
import 'package:trilhaapp/repositories/posts/posts_repository.dart';

class DioPostRepository implements PostsRepository {
  @override
  getPosts() async {
    var jsonPlaceholder = JsonPlaceHolderCustomDio();
    var response = await jsonPlaceholder.dio.get("/posts/");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
