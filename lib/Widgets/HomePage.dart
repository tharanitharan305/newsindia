import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:newsindia/Widgets/UserPage.dart';
import 'package:newsindia/Widgets/webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../news/Tools/catogory.dart';
import '../news/bloc/NewsBloc.dart';
import '../news/widgets/newsBox.dart';
import '../theme/bloc/themeBloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
context.read<NewsBloc>().add(FetchNewsEvent(catagory: NewsCatagory.Business));
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            icon: Icon(
              themeCubit.state.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              themeCubit.toggleTheme();
            },
          ),
        ],
      ),
      body: BlocBuilder(builder: (context, state) {
        if(state is NewsLoading){
          return SpinKitThreeBounce(color: Colors.blue,);
        }
        else if(state is NewsLoadingError)
        {
          return Center(child: Text(state.errorMessage),);
        }
        else if(state is NewsLoaded){
          return LiquidPullToRefresh(
            showChildOpacityTransition: true,
            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 500));
              context.read<NewsBloc>().add(FetchNewsEvent(catagory: NewsCatagory.Business));
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(children: [...state.list_of_news.map((e) => Newsbox(newsSource: e,isBookMarked: false,),).toList()],),
            ),
          );
        }
        return Center(child: Text("News India $state"),);
      },bloc: context.read<NewsBloc>(),),
    );
  }
}
