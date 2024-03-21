//
//  Generated code. Do not modify.
//  source: book.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use bookRequestDescriptor instead')
const BookRequest$json = {
  '1': 'BookRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'published_at', '3': 5, '4': 1, '5': 5, '10': 'publishedAt'},
  ],
};

/// Descriptor for `BookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bookRequestDescriptor = $convert.base64Decode(
    'CgtCb29rUmVxdWVzdBIOCgJpZBgBIAEoA1ICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEhYKBm'
    'F1dGhvchgDIAEoCVIGYXV0aG9yEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIh'
    'CgxwdWJsaXNoZWRfYXQYBSABKAVSC3B1Ymxpc2hlZEF0');

@$core.Deprecated('Use bookResponseDescriptor instead')
const BookResponse$json = {
  '1': 'BookResponse',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'published_at', '3': 5, '4': 1, '5': 5, '10': 'publishedAt'},
  ],
};

/// Descriptor for `BookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bookResponseDescriptor = $convert.base64Decode(
    'CgxCb29rUmVzcG9uc2USDgoCaWQYASABKANSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIWCg'
    'ZhdXRob3IYAyABKAlSBmF1dGhvchIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24S'
    'IQoMcHVibGlzaGVkX2F0GAUgASgFUgtwdWJsaXNoZWRBdA==');
