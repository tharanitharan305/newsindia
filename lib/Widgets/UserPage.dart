import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsindia/Auth/bloc/AuthBloc.dart';
import 'package:newsindia/hive/bloc/HiveBloc.dart';
import 'package:newsindia/news/widgets/newsBox.dart';
class Userpage extends StatefulWidget {
  const Userpage({super.key});

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HiveBloc>().add(FetchBookMarksEvent(user: null));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bookmarks"),),
      body: BlocBuilder<HiveBloc,HiveState>(builder: (context, state) {
        if(state is FetchError){
          return Center(child: Text(state.message),);
        }
        else if(state is FetchBookMarkSucess){
          if(state.listOfBookMarks.isEmpty){
            return Center(child: Text("Add some artcles to bookmark.."),);
          }
          return SingleChildScrollView(child: Column(children: [...state.listOfBookMarks.reversed.map((e) => Newsbox(newsSource: e,isBookMarked: true),).toList()],),);
        }
        return Center(child: Text(state.toString()),);
      },),
    );
  }
}
