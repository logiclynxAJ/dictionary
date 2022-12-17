import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'license.g.dart';

@JsonSerializable()
class License extends Equatable {
  final String? name;
  final String? url;

  const License({this.name, this.url});

  factory License.fromJson(Map<String, dynamic> json) {
    return _$LicenseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LicenseToJson(this);

  License copyWith({
    String? name,
    String? url,
  }) {
    return License(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, url];
}
