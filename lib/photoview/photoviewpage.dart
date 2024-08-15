import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class PhotoViewPage extends StatefulWidget {
  String img1;
  String img2;
  String img3;
  String img4;
  String img5;
  PhotoViewPage(this.img1,this.img2,this.img3,this.img4,this.img5);


  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  PageController dd= new PageController();
  saveImage(String url) async {

    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100, name: "Untitled");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("File Downloaded")));
  }
  // downloadFile(String url) async {
  //   Dio dio = Dio();
  //   try {
  //     var dir = await getApplicationDocumentsDirectory();
  //     await dio.download(url, "${dir.path}/video.mp4", onReceiveProgress: (rec, total) async {
  //       print("Rec: $rec , Total: $total");
  //
  //       String filePath = '${dir.path}/video.mp4';
  //       File videoFile = File(filePath);
  //     });
  //
  //     String? taskId = await FlutterDownloader.enqueue(
  //         url: url,
  //         savedDir: '/storage/emulated/0/Download',
  //         fileName: 'video.mp4',
  //         showNotification: true,
  //         allowCellular: true,
  //         openFileFromNotification: true,
  //         saveInPublicStorage: true,
  //         requiresStorageNotLow: true
  //     );
  //     //await Share.shareFiles([(dir.path)]);
  //
  //     return taskId; // Return the task ID
  //
  //   } catch (e) {
  //   }
  // }
  String imageData="";
  bool dataLoaded = false;
  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Documents"),
            GestureDetector(
                onTap: (){
                  print(dd.page);
                  if(dd.page==0.0){
                    saveImage(widget.img1);
                  }
                 else if(dd.page==1.0){
                    saveImage(widget.img2);
                  }
                else  if(dd.page==2.0){
                    saveImage(widget.img3);
                  }
                else  if(dd.page==3.0){
                    saveImage(widget.img4);
                  }
                else  if(dd.page==4.0){
                    saveImage(widget.img5);
                  }
                },
                child: Icon(Icons.download,color: Colors.white,))
          ],
        ),
      ),
      body:  InteractiveViewer(
        maxScale: 5.0,
        child: PageView(
          controller: dd,
          children: [
            widget.img1!=""?CachedNetworkImage(imageUrl:widget.img1.toString(),placeholder: (context, url) => Container(
                width:width/3.60,height:height/7.56,child: Lottie.asset("assets/Loadingvi.json")),): Center(child: Text("No Data")),
            widget.img2!=""? CachedNetworkImage(imageUrl:widget.img2.toString(),placeholder: (context, url) => Container(
                width:width/3.60,height:height/7.56,child: Lottie.asset("assets/Loadingvi.json")),): Center(child: Text("No Data")),
            widget.img3!=""? CachedNetworkImage(imageUrl:widget.img3.toString(),placeholder: (context, url) => Container(
                width:width/3.60,height:height/7.56,child: Lottie.asset("assets/Loadingvi.json")),): Center(child: Text("No Data")),
            widget.img4!=""? CachedNetworkImage(imageUrl:widget.img4.toString(),placeholder: (context, url) => Container(
                width:width/3.60,height:height/7.56,child: Lottie.asset("assets/Loadingvi.json")),): Center(child: Text("No Data")),
            widget.img5!=""?CachedNetworkImage(imageUrl:widget.img5.toString(),placeholder: (context, url) => Container(
                width:width/3.60,height:height/7.56,child: Lottie.asset("assets/Loadingvi.json")),): Center(child: Text("No Data")),
          ],
        ),
      ),
    );
  }
}
