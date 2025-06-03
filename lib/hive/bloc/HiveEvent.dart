part of 'HiveBloc.dart';
sealed class HiveEvent extends Equatable{
 @override
  get props =>[];
}
class FetchBookMarksEvent extends HiveEvent{
User? user;
  @override
  // TODO: implement props
  List<Object?> get props => ["In FetchBookMarks Event with user ${user?.email??""}"];
  FetchBookMarksEvent({required this.user});
}
class AddBookMark extends HiveEvent{
  NewsSource newsSource;
  Function showSnackbar;
  AddBookMark({required this.newsSource,required this.showSnackbar});
}
class RemoveBookMark extends HiveEvent{
  NewsSource newsSource;
  RemoveBookMark({required this.newsSource});
}
