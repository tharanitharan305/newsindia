part of 'NewsBloc.dart';
sealed class NewsEvent extends Equatable{
  get props=>[];
}
class FetchNewsEvent extends NewsEvent{
NewsCatagory catagory;
  @override
  // TODO: implement props
  List<Object?> get props => ["In fetchNewsEvent with $catagory "];
  FetchNewsEvent({required this.catagory});
}