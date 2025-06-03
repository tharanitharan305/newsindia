import 'package:hive/hive.dart';
import 'package:newsindia/news/Tools/model.dart';

part 'USer.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String email;

  @HiveField(1)
  String password;

  @HiveField(2)
  List<NewsSource>? bookMarked;

  User({
    required this.email,
    required this.password,
    this.bookMarked,
  });
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.email == email &&
        other.password == password;
  }
}
