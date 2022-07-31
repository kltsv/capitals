// ignore_for_file: invalid_annotation_target

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';
part 'country.g.dart';

@freezed
class Country with _$Country {
  const factory Country(
    /// Название страны
    @JsonKey(name: 'name') final String name,

    /// Название столицы
    @JsonKey(name: 'capital') final String capital, {

    /// Список ссылок на картинки со страной
    @JsonKey(name: 'imageUrls')
    @Default(<String>[])
        final List<String> imageUrls,

    /// Индекс картинки, которую нужно показать
    @JsonKey(name: 'index') @Default(0) final int index,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

extension CountryExt on Country {
  ImageProvider get image => NetworkImage('${imageUrls[index]}?w=600');
}
