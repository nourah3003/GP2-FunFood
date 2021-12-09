import 'package:flutter/material.dart';
import 'package:gp3funfood/page/select_grid_page.dart';


class ImagesPage extends StatelessWidget {
  final List<String> urlImages;

  const ImagesPage({
    Key? key,
    required this.urlImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Track serving'),
          centerTitle: true,
          actions: [
            BottomAppBar(
        child: Container(

              color: Colors.red,
              child: Text('Add  house' ,style: TextStyle(fontWeight: FontWeight.normal , fontSize: 20 ,color: Colors.white,fontStyle:FontStyle.italic),

            ),
        ),
            ),

          ],

        ),
        body: ListView(
          children: urlImages
              .map((urlImage) => Image.network(
                    urlImage,
                    fit: BoxFit.scaleDown,
                    height: 200,
                  ))
              .toList(),


        ),

      );
}
