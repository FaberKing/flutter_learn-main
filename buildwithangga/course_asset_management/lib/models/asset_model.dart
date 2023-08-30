import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'asset_model.freezed.dart';
part 'asset_model.g.dart';

@freezed
class Asset with _$Asset {
  const factory Asset({
    required String id,
    required String name,
    required String type,
    required String image,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Asset;

  factory Asset.fromJson(Map<String, Object?> json) => _$AssetFromJson(json);
}
