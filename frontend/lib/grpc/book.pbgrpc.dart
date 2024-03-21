//
//  Generated code. Do not modify.
//  source: book.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'book.pb.dart' as $0;

export 'book.pb.dart';

@$pb.GrpcServiceName('book.Library')
class LibraryClient extends $grpc.Client {
  static final _$pingPong = $grpc.ClientMethod<$0.BookRequest, $0.BookResponse>(
      '/book.Library/PingPong',
      ($0.BookRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.BookResponse.fromBuffer(value));

  LibraryClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.BookResponse> pingPong($0.BookRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pingPong, request, options: options);
  }
}

@$pb.GrpcServiceName('book.Library')
abstract class LibraryServiceBase extends $grpc.Service {
  $core.String get $name => 'book.Library';

  LibraryServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BookRequest, $0.BookResponse>(
        'PingPong',
        pingPong_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BookRequest.fromBuffer(value),
        ($0.BookResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.BookResponse> pingPong_Pre(
      $grpc.ServiceCall call, $async.Future<$0.BookRequest> request) async {
    return pingPong(call, await request);
  }

  $async.Future<$0.BookResponse> pingPong(
      $grpc.ServiceCall call, $0.BookRequest request);
}
