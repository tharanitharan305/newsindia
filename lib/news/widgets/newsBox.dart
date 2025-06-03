import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newsindia/hive/bloc/HiveBloc.dart';
import 'package:newsindia/news/Tools/model.dart';

import '../../Widgets/webview.dart';

class Newsbox extends StatefulWidget {
  final NewsSource newsSource;
  bool isBookMarked;
  Newsbox({required this.newsSource,required this.isBookMarked});

  @override
  State<Newsbox> createState() => _NewsboxState();
}

class _NewsboxState extends State<Newsbox> {
  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    String formatted = DateFormat("d MMMM, y").format(dateTime);
    return formatted;
  }
showSnackBAr(){
  final snackBar=SnackBar(content: Text("article added to your Bookmark sucessfully"));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
bool isShowText=false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log(widget.newsSource.imageUrl);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsWebView(url: widget.newsSource.url),));
        },
        child: Container(
          height: size.height * 0.20,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:  widget.newsSource.imageUrl != null &&
                    widget.newsSource.imageUrl.isNotEmpty &&
                    widget.newsSource.imageUrl != "No Image"
                    ? NetworkImage(widget.newsSource.imageUrl)
                    : AssetImage("asset/img.png") as ImageProvider,
                fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.black54,
                  child: Text(
                    formatDate(widget.newsSource.time),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                  right: 8,
                  child: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black54,),child: IconButton(onPressed:widget.isBookMarked?(){
                    context.read<HiveBloc>().add(RemoveBookMark(newsSource: widget.newsSource));
                  }: (){
                    context.read<HiveBloc>().add(AddBookMark(newsSource: widget.newsSource,showSnackbar: showSnackBAr));
                  }, icon: Icon(widget.isBookMarked?Icons.bookmark_added:Icons.bookmark_border_rounded,color: Colors.white,)),
              )),
              if(isShowText)
              Container(color: Colors.black54, child: Text(widget.newsSource.description.length==0?"Click the banner for more information":widget.newsSource.description,style: TextStyle(fontSize: 20,color: Colors.white),)),

                Positioned(
                  bottom: isShowText?8:null,
                    top: isShowText?null:8,
                    left: 8,
                    child: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black54,),child: IconButton(onPressed: (){
                      setState(() {
                        isShowText=!isShowText;
                      });
                    }, icon: Icon(isShowText?Icons.arrow_upward_outlined:Icons.arrow_downward_rounded,color: Colors.white,)),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
