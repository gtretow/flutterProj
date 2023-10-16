import 'package:trilhaapp/model/comment_model.dart';
import 'package:trilhaapp/repositories/comments/comments_repo.dart';
import 'package:trilhaapp/repositories/custom_dio_jsonplaceholder.dart';

class CommentsDioRepository implements CommentsRepository {
  @override
  Future<List<CommentModel>> returnComments(int postId) async {
    var jsonPlaceHolderDio = JsonPlaceHolderCustomDio();
    var response = await jsonPlaceHolderDio.dio.get('/posts/$postId/comments');

    return (response.data as List)
        .map((e) => CommentModel.fromJson(e))
        .toList();
  }
}
