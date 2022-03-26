import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_fun/classes/voice_records.dart';
import 'package:image_picker/image_picker.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  bool isFruit = true;
  // التحضير لاحضار الصورة
  final ImagePicker _picker = ImagePicker();
  // اسم الكلاس الذي سوف يحوي الصورة
  XFile? image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.5,
                    child: SvgPicture.asset(
                      "assets/sign up top.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.3,
                    child: SvgPicture.asset(
                      "assets/sign up bottom.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: size.height * 0.1,
                left: size.width * 0.05,
                child: const Text("Add new food!",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24))),
            Positioned(
                top: size.height * 0.2,
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.8,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const TextField(
                        decoration: InputDecoration(label: Text("Food Name")),
                      ),
                      CheckboxListTile(
                          title: const Text("is Fruit : "),
                          value: isFruit,
                          onChanged: (newVal) {
                            isFruit = newVal as bool;
                            setState(() {});
                          }),
                      CheckboxListTile(
                          title: const Text("is Vegetable : "),
                          value: !isFruit,
                          onChanged: (newVal) {
                            isFruit = !(newVal as bool);
                            setState(() {});
                          }),
                      Column(
                        children: [
                          const Text("Add photo or picture of the food : "),
                          TextButton(
                              onPressed: () async {
                                image = await _picker.pickImage(
                                    source: ImageSource.gallery);

                                setState(() {});
                              },
                              child: Container(
                                width: size.width * 0.25,
                                height: size.height * 0.05,
                                alignment: Alignment.center,
                                child: const Text("Choose Image"),
                              )),
                          Text(
                            image == null
                                ? "No photo chosen yet!"
                                : image!.path,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () async {
                            Sounds sounds = Sounds();
                            await sounds.record();
                            await sounds.convert();
                          },
                          child: Row(
                            children: [
                              Icon(Icons.record_voice_over),
                              Text("Recored an audio message about the food")
                            ],
                          )),
                      TextField(
                        maxLines: 3,
                        maxLength: 300,
                        decoration: InputDecoration(
                            label: const Text("Info about the food"),
                            border: OutlineInputBorder(
                                gapPadding: 8,
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      TextButton(
                          onPressed: () async {
                            setState(() {});
                          },
                          child: Container(
                            width: size.width,
                            height: size.height * 0.05,
                            alignment: Alignment.center,
                            child: const Text("SUBMIT"),
                          )),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
