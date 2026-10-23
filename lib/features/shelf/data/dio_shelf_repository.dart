import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/base/base_repository.dart';
import '../../../core/domain/failure.dart';
import '../../../core/network/app_exception.dart';
import '../domain/book.dart';
import '../domain/shelf_repository.dart';
import 'book_json.dart';

class DioShelfRepository extends BaseRepository implements ShelfRepository {
  DioShelfRepository(this._dio);

  final Dio _dio;

  @override
  Future<Either<Failure, List<Book>>> load() {
    return execute(() async {
      final response = await _guard(() => _dio.get<List<dynamic>>('/books'));
      final data = response.data;
      if (data == null) {
        throw const NetworkException();
      }
      return [
        for (final item in data) bookFromJson(item as Map<String, dynamic>),
      ];
    });
  }

  @override
  Future<Either<Failure, Book>> add(BookDraft draft) {
    return execute(() async {
      final response = await _guard(
        () =>
            _dio.post<Map<String, dynamic>>('/books', data: draftToJson(draft)),
      );
      final data = response.data;
      if (data == null) {
        throw const NetworkException();
      }
      return bookFromJson(data);
    });
  }

  Future<Response<T>> _guard<T>(Future<Response<T>> Function() send) async {
    try {
      final response = await send();
      final code = response.statusCode ?? 0;
      if (code == 404) {
        throw const NotFoundException();
      }
      if (code < 200 || code >= 300) {
        throw const NetworkException();
      }
      return response;
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        throw const NotFoundException();
      }
      throw const NetworkException();
    }
  }
}
