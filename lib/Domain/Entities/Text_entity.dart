import 'package:hive/hive.dart';

part 'Text_entity.g.dart';

@HiveType(typeId: 0)
class TextEntity extends HiveObject {
  @HiveField(0)
  final String content;

  @HiveField(1)
  final bool isUnderlined;

  @HiveField(2)
  final bool isItalique;

  @HiveField(3)
  final bool isBold;

  @HiveField(4)
  final int fontSize;

  TextEntity({
    required this.content,
    required this.isUnderlined,
    required this.isItalique,
    required this.isBold,
    required this.fontSize,
  });
}