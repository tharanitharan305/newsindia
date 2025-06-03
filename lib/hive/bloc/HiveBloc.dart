import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newsindia/Auth/bloc/AuthBloc.dart';
import 'package:newsindia/news/Tools/model.dart';

import '../../Auth/models/USer.dart';

part 'HiveState.dart';
part 'HiveEvent.dart';
class HiveBloc extends Bloc<HiveEvent,HiveState>{
  AuthBloc authBloc;
  HiveBloc({required this.authBloc}):super(HiveLoading()){
    on<AddBookMark>(_onAddBookMarkEvent);
    on<FetchBookMarksEvent>(_onFetchBookMarkEvent);
    on<RemoveBookMark>(_onRemoveBookMarkEvent);
  }
_onAddBookMarkEvent(AddBookMark event,Emitter<HiveState> emit) async {
    try{
      final bookMarkBox=await Hive.openBox("BookMarks");
     bookMarkBox.add(event.newsSource);
      event.showSnackbar();
    }catch(e){
      emit(FetchError(message: e.toString()));
    }
}
_onFetchBookMarkEvent(FetchBookMarksEvent event,Emitter<HiveState> emit) async {
  emit(HiveLoading());
  try {
    final box = await Hive.openBox("BookMarks");
    List<NewsSource> list = box.values.cast<NewsSource>().toList();

    log("Fetched ${list.length} bookmarks of type ${list.runtimeType}");
    if (list.isNotEmpty) {
      log("First item: ${list[0]}");
    }

    emit(FetchBookMarkSucess(listOfBookMarks: list));
  } catch (e) {
    log(e.toString() + " In FetchBookMarkEvent");
    emit(FetchError(message: e.toString()));
  }


}
_onRemoveBookMarkEvent(RemoveBookMark event,Emitter<HiveState> emit) async {
    emit(HiveLoading());
    try{
      final box = await Hive.openBox("BookMarks");
      final keyToRemove = box.keys.firstWhere(
            (key) => box.get(key) == event.newsSource,
        orElse: () => null,
      );
      if (keyToRemove != null) {
        await box.delete(keyToRemove);
      }
      List<NewsSource> list = box.values.cast<NewsSource>().toList();
      emit(FetchBookMarkSucess(listOfBookMarks: list));
    }catch(e){
      emit(FetchError(message: e.toString()));
    }
}
}