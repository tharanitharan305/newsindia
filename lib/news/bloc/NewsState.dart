part of 'NewsBloc.dart';
sealed class NewsState extends Equatable{
 List<Object?> get props => [];
}
class NewsLoading extends NewsState{
  @override
  // TODO: implement props
  List<Object?> get props => ['In NewsLoading State'];
}
class NewsLoadingError extends NewsState{
  String errorMessage;
  @override
  // TODO: implement props
  List<Object?> get props => ['In NewsLoadingError State with error:$errorMessage'];
  NewsLoadingError({required this.errorMessage});
}
class NewsLoaded extends NewsState{
  List<NewsSource> list_of_news;
  NewsLoaded({required this.list_of_news});
}