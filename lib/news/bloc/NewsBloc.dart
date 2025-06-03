import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsindia/news/Tools/Keys.dart';
import 'package:newsindia/news/Tools/catogory.dart';
import 'package:newsindia/news/Tools/model.dart';
import 'package:dio/dio.dart';
part 'NewsEvent.dart';
part 'NewsState.dart';
class NewsBloc extends Bloc<NewsEvent,NewsState>{

  NewsBloc():super(NewsLoading()){
on<FetchNewsEvent>(_onNewsFetchEvent);
  }
  _onNewsFetchEvent(FetchNewsEvent event,Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      String _url="";
      switch(event.catagory){

        case NewsCatagory.Tech:
         _url=techLink;
         break;
        case NewsCatagory.Headlines:
          _url=link;
          break;
        case NewsCatagory.Country:
          _url=" https://newsapi.org/v2/top-headlines?country=in&apiKey=fb3a40bbc9c740cd970ed29475618e15";
          break;
        case NewsCatagory.Business:
          _url=businessLink;
          break;
      }
      final dio = Dio();
      log("In NewsBloc currently started fetch for link $_url");

      final response = await dio.get(_url);

      if (response.statusCode == 200) {
        List<NewsSource> list = [];
        log("In NewsBloc got response. Starting formatting...");

        final articles = response.data["articles"];
        log("Articles is a ${articles.runtimeType} with length ${articles.length}");

        for (var article in articles) {
          final newsItem = NewsSource.fromJson(article);
          list.add(newsItem);
        }

        log("Formatted ${list.length} articles.");
        emit(NewsLoaded(list_of_news: list));
      }
      else {
        emit(NewsLoadingError(errorMessage: 'Failed to load news. Code: ${response.statusCode}'));
      }
    } catch (e) {
      log(e.toString());
      emit(NewsLoadingError(errorMessage: 'Error: $e'));

    }
  }
  }
