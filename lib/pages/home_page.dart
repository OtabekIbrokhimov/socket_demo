import 'package:flutter/material.dart';
import 'package:socket_demo/service/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var response = "No Data";

  _initSocketServise() {
    SocketServise.connectSocketChannel();
    SocketServise.channel.stream.listen((data) {
      setState(() {
        response = data.toString();
        //   print(response);
      });
    }, onError: (error) {
      setState(() {
        response = error.toString();
        print(response);
      });
    });
  }

  List btcPrize(String responce) {
    String prize = "no data";
    String price = "no data";
    List list = ["47000"];
    for (int i = 0; i < response.length; i++) {
      if (response[i] == "p" && response[i + 4] == "e") {
        prize = response.substring(i + 7, i + 15);
        for (int j = 0; j < prize.length; i++) {
          for (int k = 0; k < 10; i++) {
            if (prize[j] == k.toString() || prize[j] == ".") {
              price += prize[j];
            }
          }
        }
        list.add(price);
      }
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    _initSocketServise();
    btcPrize(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Socket"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: btcPrize(response).length+1,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 40,
                        width: 40,
                        child: Text(
                          btcPrize(response)[index]+btcPrize(response).length.toString(),
                          style: TextStyle(fontSize: 20,color: Colors.black),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
