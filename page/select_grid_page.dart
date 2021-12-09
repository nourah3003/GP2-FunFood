import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:gp3funfood/page/Childpage.dart';
import 'package:gp3funfood/page/images_page.dart';
import 'package:gp3funfood/page/track.dart';
import 'package:gp3funfood/page/selectable_item_widget.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';

class SelectGridPage extends StatefulWidget {


  @override

  _SelectGridPageState createState() => _SelectGridPageState();
}

class _SelectGridPageState extends State<SelectGridPage> {
  final controller = DragSelectGridViewController();


  final urlImages = [
    'https://t4.ftcdn.net/jpg/01/32/21/97/240_F_132219717_g9tF8RYnS01PKRaLdPvHKN2KEaPcyDrV.jpg',

    'https://t4.ftcdn.net/jpg/02/01/11/61/240_F_201116191_0bgpSn70IjkbTBeRctQOlBn0v5VwnfNd.jpg',
  ];

  static final String title = 'Add serving   ';

  @override
  void initState() {
    super.initState();
    controller.addListener(rebuild);
  }

  @override
  void dispose() {
    controller.removeListener(rebuild);
    super.dispose();
  }

  void rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final isSelected = controller.value.isSelecting;
    final text =
    isSelected ? '${controller.value.amount} Images Selected' : title;

    return Scaffold(

      appBar: AppBar(
        title: Text(text),
        leading: isSelected ? CloseButton() : Container(),
        actions: [




          if (isSelected)
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                final urlSelectedImages = controller.value.selectedIndexes
                    .map<String>((index) => urlImages[index])
                    .toList();


                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ImagesPage(
                        urlImages: urlSelectedImages,

                      ),


                ));

              },
            ),
          BottomAppBar(
            child: Container(

              color: Colors.lightGreen,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),

                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => track()));
                },
                child: Text(" Track serving  " ,
                  style: TextStyle(color: Colors.black ,fontSize: 12,fontStyle:FontStyle.italic),),
              ),
            ),
          ),

        ],
      ),



      body: DragSelectGridView(
        gridController: controller,
        padding: EdgeInsets.all(8),
        itemCount: urlImages.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),

        itemBuilder: (context, index, isSelected) =>
            SelectableItemWidget(
              url: urlImages[index],
              isSelected: isSelected,
            ),

      ),



    );
  }}


