import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fun_food/classes/storage.dart';
import 'package:http/http.dart';
import 'user.dart';

const error = "an error occured";
const url = "http://10.0.2.2/food";

class API {
  static Future<dynamic> signIn(String email, String password) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/sign_in.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        if (jsonMap["code"].toString() == "1") {
          await Storage.setInfo(email, password, "1");
          await Storage.setPIN(jsonMap["pin"]);
          return User.fromJson(jsonMap);
        } else {
          return jsonMap["message"];
        }
      } else {
        return error;
      }
    } on SocketException catch (e) {
      print("e");
      return error;
    } catch (e) {
      return error;
    }
  }

  static Future<dynamic> signUp(
      String email, String password, String name, String pin) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/sign_up.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          "name": name,
          "pin": pin
        }),
      ).timeout(Duration(seconds: 30));
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        if (jsonMap["code"].toString() == "1") {
          await Storage.setInfo(email, password, "1");
          await Storage.setPIN(pin);
          return User.fromJson(jsonMap);
        } else {
          return jsonMap["message"];
        }
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }
// method of add item ( fruit or vegetable ) to data
  static Future<dynamic> addItem(String userId, String name, String imageBase,
      String? audioBase, String benefits, int type) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/add_item.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'user_id': userId,
          'name': name, //name of fruit or vegetable
          "image_base": imageBase, //image of fruit or vegetable
          "audio_base": audioBase, //audio of fruit or vegetable
          "benefits": benefits, //benefits of fruit or vegetable
          "type": type //type of fruit or vegetable
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap["message"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<List<dynamic>?> getAll(String userId) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/get_all.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"user_id": userId}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        if (list.first["code"] == "-1") {
          return null;
        } else {
          return list;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<dynamic>?> getAllMeals(String userId) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/getAllMeals.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"user_id": userId}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        if (list.first["code"] == "-1") {
          return null;
        } else {
          return list;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<dynamic>?> getUnaprovedMeals(String userId) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/getUnapprovedMeal.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"user_id": userId}),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        if (list.first["code"] == "-1") {
          return null;
        } else {
          return list;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<String> getNumOfUnaprovedMeals(String userId) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/getNumofUnapprovedMeals.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"user_id": userId}),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return jsonDecode(response.body)["num"].toString();
      } else {
        return "0";
      }
    } catch (e) {
      print(e);
      return "0";
    }
  }

  static Future<int> getNumOfMeals(String userId) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/getNumOfMeals.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "user_id": userId,
          'year': DateTime.now().year.toString(),
          'mounth': DateTime.now().month.toString(),
          'day': DateTime.now().day.toString()
        }),
      );
      print(response.statusCode.toString() + "Dfdfdf");
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)["num"]);
        return jsonDecode(response.body)["num"];
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<List<dynamic>?> getFruits(String userId) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/get_fruits.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"user_id": userId}),
      );
      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        if (list.first["code"] == "-1") {
          return null;
        } else {
          return list;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<String> approveMeal(String userId, String mealID) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/approve_meal.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{"user_id": userId, "serving_id": mealID}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return "Done";
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<String> UnapproveMeal(String userId, String mealID) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/unapproveMeal.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{"user_id": userId, "serving_id": mealID}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return "Done";
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<String> forgotPaassword(String email) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/reset_password.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"email": email}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["message"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<String> deleteFruit(String userId, String fruitID) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/delete_fruit.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{"user_id": userId, "fruit_id": fruitID}),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        return map["message"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<String> deleteVegetable(
      String userId, String vegetableID) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/delete_vegetable.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{"user_id": userId, "vegetable_id": vegetableID}),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        return map["message"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<List<dynamic>?> getVegetables(String userId) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/get_vegetables.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"user_id": userId}),
      );
      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        if (list.first["code"] == "-1") {
          return null;
        } else {
          return list;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<dynamic>?> getMealsByDay(
      String userId, String month, String day, String year) async {
    try {
      print(month);
      print(year);
      print(day);
      Response response = await post(
        Uri.parse(
          url + "/getMealsByDate.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "user_id": userId,
          "mounth": month,
          "day": day,
          "year": year
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {

        List<dynamic> list = jsonDecode(response.body);
        if (list.first["code"] == "0") {
          return null;
        } else {
          return list;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> getFruit(String userID, String fruitID) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/get_fruit.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'user_id': userID, 'fruit_id': fruitID}),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap;
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<dynamic> editFruitName(
      String userID, String fruitsID, String name) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/edit_fruit_name.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
          'fruit_id': fruitsID,
          'name': name
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap["message"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<dynamic> editFruitAudio(
      String userID, String fruitsID, String audioBase) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/edit_fruit_audio.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
          'fruit_id': fruitsID,
          'audio_base': audioBase
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap["message"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<dynamic> editFruitImage(
      String userID, String fruitsID, String imageBase) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/edit_fruit_audio.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
          'fruit_id': fruitsID,
          'image_base': imageBase
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap["message"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<String> editFruitBenefits(
      String userID, String fruitsID, String benefits) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/edit_fruit_audio.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
          'fruit_id': fruitsID,
          'benefits': benefits
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap["message"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<dynamic> getVegetable(String userID, String fruitID) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/get_vegetable.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'user_id': userID, 'vegetable_id': fruitID}),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap;
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<dynamic> editVegetableName(
      String userID, String fruitsID, String name) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/edit_vegetable_name.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
          'vegetable_id': fruitsID,
          'name': name
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap["message"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<dynamic> editVegetableAudio(
      String userID, String fruitsID, String audioBase) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/edit_vegetable_audio.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
          'vegetable_id': fruitsID,
          'audio_base': audioBase
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap["message"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<dynamic> editVegetableImage(
      String userID, String fruitsID, String imageBase) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/edit_vegetable_audio.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
          'vegetable_id': fruitsID,
          'image_base': imageBase
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap["message"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<String> editVegetableBenefits(
      String userID, String fruitsID, String benefits) async {
    try {
      Response response = await post(
        Uri.parse(
          url + "/edit_vegetable_audio.php",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
          'vegetable_id': fruitsID,
          'benefits': benefits
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap["message"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<Map<String, dynamic>> addHouse(
      String userID, String imageURL) async {
    try {
      Response response = await post(
        Uri.parse(url + "/addCity.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'user_id': userID, 'image_url': imageURL}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"message": "Could not connect to the server.", "code": "-1"};
      }
    } catch (e) {
      return {"message": "Could not connect to the server.", "code": "-1"};
    }
  }

  static Future<Map<String, dynamic>> addPalace(
      String userID, String imageURL) async {
    try {
      Response response = await post(
        Uri.parse(url + "/addHouseByCoins.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'user_id': userID, 'image_url': imageURL}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"message": "Could not connect to the server.", "code": "-1"};
      }
    } catch (e) {
      return {"message": "Could not connect to the server.", "code": "-1"};
    }
  }

  static Future<String> getCoins(String userID) async {
    try {
      Response response = await post(
        Uri.parse(url + "/getCoins.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["coins"];
      } else {
        return "0";
      }
    } catch (e) {
      return "0";
    }
  }

  static Future<String> addServing(
      String userID, String name, String URL) async {
    try {
      Response response = await post(
        Uri.parse(url + "/add_c_meal.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
          "name": name,
          "URL": URL,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["code"];
      } else {
        return error;
      }
    } catch (e) {
      return error;
    }
  }

  static Future<void> addCoins(String userID) async {
    try {
      Response response = await post(
        Uri.parse(url + "/addCoins.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
        }),
      );
      print(response.body);
    } catch (e) {}
  }

  static Future<List<dynamic>> getHouses(String userID) async {
    try {
      Response response = await post(
        Uri.parse(url + "/getHouses.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
