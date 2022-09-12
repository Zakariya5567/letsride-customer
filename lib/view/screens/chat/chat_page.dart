import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../controller/chat_controller.dart';
import '../../../util/dimensions.dart';
import '../../../util/styles.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  Timer _timer;

  setTimer() {
    _timer = Timer.periodic(new Duration(seconds: 5), (timer) async {
      await chatController.getSupportChat();
      debugPrint("----------->>>>>>>>Time is :" + DateTime.now().toString());
    });
  }

  @override
  void initState() {
    super.initState();
    setTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: GetBuilder(
              init: ChatController(),
              builder: (controller) {
                return Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      chatController.image != null
                          ? CircleAvatar(
                              backgroundImage:
                                  NetworkImage(chatController.image),
                              maxRadius: 20,
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.grey,
                              maxRadius: 20,
                            ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              chatController.name != null

                                  ? chatController.name
                                  : " ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            //Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.settings,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
      body: GetBuilder(
          init: ChatController(),
          builder: (controller) {
            return Stack(
              children: <Widget>[
                //chat
        //===============================================================================

                chatController.isLoading == true
                    ? Center(child: CircularProgressIndicator())
                    : chatController.chat.isEmpty || chatController.chat == null
                        ? Center(
                            child: Text(
                              "Start Conversation",
                              style: robotoRegular.copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        :

                        ScrollablePositionedList.builder(
                            itemScrollController: itemScrollController,
                            initialScrollIndex: chatController.chat.length,
                            itemPositionsListener: itemPositionsListener,
                            itemCount:
                                chatController.chat.length,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final chat =
                                  //chatController.page =="chat" ?
                                  chatController.chat[index];
                              //: chatController.supportChat[index];

                              print("length :${chatController.chat.length}");
                              print("index :${index}");

                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        chatController.chat.length == index + 1
                                            ? 50.0
                                            : 0),
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left: 14,
                                        right: 14,
                                        top: 10,
                                        bottom: 10),
                                    child:

                                        Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: (chat.message != null
                                              ? Alignment.topLeft
                                              : Alignment.topRight),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8),
                                                child: Text(
                                                  chat.message != null
                                                      ? "User":
                                                  chat.reply != null
                                                      ? "Admin":"Rider",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: (chat.message != null
                                                      ? Colors.grey.shade200
                                                      : chat.riderMsg != null
                                                          ? Colors.blue[100]
                                                          : chat.reply != null
                                                              ? Colors.pink[100]
                                                              : null),
                                                ),
                                                padding: EdgeInsets.all(16),
                                                child: Text(
                                                  chat.riderMsg != null
                                                      ? chat.riderMsg
                                                      : chat.message != null
                                                          ? chat.message
                                                          : chat.reply != null
                                                              ? chat.reply
                                                              : null,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(top: 5, left: 5),
                                          child: Container(
                                            alignment: chat.message != null
                                                ? Alignment.topLeft
                                                : Alignment.topRight,
                                            child: Text(
                                              getFormattedDate(
                                                  "${chat.createdAt}"),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 8),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                //  ),
                              );
                            },
                          ),

//===============================================================================
                // TextField bar
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: chatController.messaageController,
                            decoration: InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () async {
                            chatController.setSendLoading(true);
                            await chatController.sendSupportMessage();
                            chatController.setSendLoading(false);
                          },
                          child: chatController.sendLoading == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 18,
                                ),
                          backgroundColor: Theme.of(context).primaryColor,
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  String getFormattedDate(String date) {
    // Convert into local date format.
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    var inputDate = inputFormat.parse(localDate.toString());

    var outputFormat = DateFormat("dd-MM-yyy  hh:mm:a");
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }
}
