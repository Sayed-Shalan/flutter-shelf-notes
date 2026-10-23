import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelf_notes/features/shelf/data/dio_shelf_repository.dart';

void main() {
  test('decodes a book list from Dio', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://shelf.test'));
    dio.httpClientAdapter = _JsonAdapter(
      body: jsonEncode([
        {
          'id': 'paper-cities',
          'title': 'Paper Cities',
          'author': 'Hana Mostafa',
          'status': 'reading',
        },
      ]),
    );
    final repository = DioShelfRepository(dio);

    final result = await repository.load();

    expect(
      result.fold((_) => null, (books) => books.single.author),
      'Hana Mostafa',
    );
  });
}

class _JsonAdapter implements HttpClientAdapter {
  _JsonAdapter({required this.body});

  final String body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      body,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
