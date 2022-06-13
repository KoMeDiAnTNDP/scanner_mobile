// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(Map<String, dynamic> json) =>
    BaseResponse<T>(
      status: json['status'] as int?,
      data: BaseResponse._dataFromJson(json['data']),
      error: json['error'] as String?,
    );
