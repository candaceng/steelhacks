import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:steelhacks/shared/state.dart';
import 'package:provider/provider.dart';
import 'package:tts/tts.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.lightBlue),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            SizedBox(width: 10),
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      name: "Me",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    Response(text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Flexible(
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          )
      ),
      Divider(height: 1.0),
      Container(
        decoration: BoxDecoration(color: Theme
            .of(context)
            .cardColor),
        child: _buildTextComposer(),
      ),
    ]);
  }

  void Response(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
        fileJson: "assets/sensental-f182f0d25abc.json").build();
    Dialogflow dialogflow = Dialogflow(
        authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage message = new ChatMessage(
      text: response.getMessage(),
      name: "",
      type: false,
    );
    Tts.speak(response.getMessage());
    setState(() {
      _messages.insert(0, message);
    });
  }

}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: Image.asset("assets/bot.png"),
          )
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name, style: TextStyle(fontWeight:FontWeight.bold )),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: ChatBubble(
                clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                backGroundColor: Provider.of<AppStateNotifier>(context).isDark? Colors.grey[700] : Color(0xffE7E7ED),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(text),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 5.0, right: 15),
              child: ChatBubble(
                clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
                alignment: Alignment.topRight,
                //backGroundColor: Colors.lightBlue[500],
                backGroundColor: Colors.lightBlue,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(text, style: TextStyle(color: Colors.white)),
                ),
              )
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}

