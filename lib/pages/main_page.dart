import 'package:flutter/material.dart';
import 'package:socket_demo/service/socket_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var responce = "No Data";

  _initSocketService(){
    SocketServise.connectSocketChannel();
    SocketServise.channel.stream.listen((data) {
      setState(() {
        responce = data.toString();
      });

    },
    onError: (error){
      setState(() {
        responce = error.toString();
      });
    }

    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSocketService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Socket"),

      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: StreamBuilder(
          stream: SocketServise.channel.stream,
          builder: (context, snapshot){
            return Center(
              child: Text(
                snapshot.hasData? "${snapshot.data}":"no data",
                style: TextStyle(fontSize: 22),
              ),
            );
          }
        ),
      ),
    );
  }
}
