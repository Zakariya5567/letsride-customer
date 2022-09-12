import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api/chat_api.dart';
import '../data/model/response/get_chat_model.dart';
import '../data/model/response/order_model.dart';

class ChatController extends GetxController{

OrderModel orderModel=OrderModel();
TextEditingController messaageController =TextEditingController();
GetChatModel getChatModel;
ChatApi chatApi=ChatApi();


List chat=[];
List supportChat=[];


 String image;
 String name;
 int orderId;
 int userId;

 
 setOrderId(int id){
   orderId=id;
   print("setting_order id is ----------$orderId");
   update();
 }
 setUserId(int id){
  userId=id;
  print("support message user id is ----------$userId");
  update();
}
 setChatHeader(String setName,String setImage){
    image=setImage;
    name=setName;

    print("image is : $image");
    print("name is : $name");

    update();
 }

  
  bool isLoading;
  bool refreshLoadig;
  bool sendLoading;
  String page;

  setPage(String newPage){
    page=newPage;
    update();
  }

 setLoading(bool value){
       isLoading = value;
       print("=======>>>>>>>>>>>>>>>>>>> Loading is $isLoading");

       update();
  }

 setRefreshLoading(bool value){
       refreshLoadig = value;

       print("in controller =======>>>>>>>>>>>>>>>>>>>refreah Loading is $isLoading");
       update();
  }

  setSendLoading(bool value){
       sendLoading = value;

       print("=======>>>>>>>>>>>>>>>>>>>send Loading is $isLoading");
       update();
  }


//========================================================================================================
//get support chat


  getSupportChat() async {

    page="support";
    print(" support message ==========================>>>");

    getChatModel = await chatApi.getSupportMessageApi();
    chat.clear();
    chat=getChatModel.conversation;
    update();
  }


  //----------------------------------------------------
  // send support
  sendSupportMessage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getInt("user_id");

    getChatModel = await chatApi.sendSupportMessageApi(
        {
      "message":messaageController.text==null?" ":messaageController.text,
      "user_type":"1",
      "user_id":userId.toString()
    }
    );
    messaageController.clear();
    await getSupportChat();
    update();
  }

}