part of 'HiveBloc.dart';
sealed class HiveState extends Equatable{
  get props =>[];
}
class HiveLoading extends HiveState{}
class AuthSucess extends HiveState{

}
class FetchError extends HiveState{
  String message;
  FetchError({required this.message});
}
class FetchBookMarkSucess extends HiveState{
  List<NewsSource> listOfBookMarks;
  FetchBookMarkSucess({required this.listOfBookMarks});
}