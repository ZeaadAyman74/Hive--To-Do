import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)   // Type Adapter for this model
class NoteModel extends HiveObject implements Equatable {
  @HiveField(0)
  String title;
  @HiveField(1)
  String? subTitle;
  @HiveField(2)
  String date;
  @HiveField(3)
  int color;

  NoteModel({
    required this.title,
    this.subTitle,
    required this.color,
    required this.date,
  });

  @override
  List<Object?> get props => [title, subTitle, date, color];

  @override
  bool? get stringify => throw UnimplementedError();
}
