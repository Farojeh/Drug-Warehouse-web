import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';

class ALLOrder extends StatefulWidget {
  // String id ;
  //  // ignore: use_key_in_widget_constructors
  //  ALLOrder(this.id);

  @override
  State<ALLOrder> createState() => _ALLOrderState();
}

class _ALLOrderState extends State<ALLOrder> {
    bool isloading = false;
    List<dynamic> _Orders = [];
   @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,() async{
      try{
      setState(() {
        isloading = true;
      });
      await Provider.of<Mypro>(context , listen: false).getorders();
      _Orders = Provider.of<Mypro>(context , listen: false).Orders;
    }catch(error){
       showDialog(
            context: context,
            builder: (ctxx) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  title: const Text(
                    'Warning',
                    style: TextStyle(
                        color: Color.fromARGB(255, 252, 93, 93), fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  content: Text(error.toString()),
                ));
    }
    setState(() {
      isloading = false;
    });
    } );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          SizedBox(
            width: 67,
            height: 60,
            child: Image.asset(
              'assets/images/information.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(
            width: 17,
          ),
          const Text(
            "Order's Details :",
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'RobotoCondensed',
              color: Color.fromARGB(221, 3, 168, 244),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.7,
        child:isloading==false? ListView(
          children: _Orders
              .map((order) => Column(
                  children: [
                    ExpansionTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          side: const BorderSide(
                            color: Color.fromARGB(239, 1, 51, 145),
                          )),
                      iconColor: const Color.fromARGB(255, 255, 100, 100),
                      collapsedIconColor:
                          const Color.fromARGB(185, 3, 168, 244),
                      backgroundColor:
                          Color.fromARGB(147, 0, 174, 255).withOpacity(0.1),
                      title: Text(
                        '${order['user_name']}(${order['number']})',
                        style: const TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontSize: 23,
                          color: Color.fromARGB(239, 1, 51, 145),
                        ),
                      ),
                      leading: const Icon(Icons.info_outline),
                      children: [
                        ListTile(
                          title: const Text(
                            "Order's Date ",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'RobotoCondensed',
                              color: Color.fromARGB(255, 0, 135, 153),
                            ),
                          ),
                          leading: const Icon(
                            Icons.date_range_rounded,
                            size: 30,
                            color: Color.fromARGB(255, 0, 167, 189),
                          ),
                          subtitle: Text(order['date']),
                        ),
                        ListTile(
                          title: const Text(
                            "Order's State ",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'RobotoCondensed',
                              color: Color.fromARGB(255, 0, 135, 153),
                            ),
                          ),
                          leading:const  Icon(
                            Icons.settings_applications,
                            size: 30,
                            color: Color.fromARGB(255, 0, 167, 189),
                          ),
                          subtitle: Text(getstate(order['status'])),
                        ),
                        ListTile(
                          title: const Text(
                            "Order's Payment ",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'RobotoCondensed',
                              color: Color.fromARGB(255, 0, 135, 153),
                            ),
                          ),
                          leading: const Icon(
                            Icons.payment,
                            size: 30,
                            color: Color.fromARGB(255, 0, 167, 189),
                          ),
                          subtitle: Text(getpay(order['paid'])),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () async{
                                Provider.of<Mypro>(context , listen: false).changeindorder(order['id'].toString());
                                Provider.of<Mypro>(context , listen: false).changestate(order['status']);
                                Provider.of<Mypro>(context , listen: false).changepay(order['paid']);
                                 Navigator.of(context).pop(true);
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.white.withOpacity(0.0)),
                              ),
                              child: const Text(
                                'View More and Edit',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 1, 43, 121),
                                    fontFamily: 'Pacifico'),
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 300,
                      child: Divider(
                        color: Color.fromARGB(219, 3, 168, 244),
                        thickness: 1.1,
                      ),
                    )
                  ],
                ),
              )
              .toList(),
        ): const Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  String getstate(int s ){
    if(s == 1){
      return 'Requesting ';
    }else if(s == 2){
      return 'In preparation ';
    }else if (s == 3){
      return 'on the way';
    }else{
      return 'Sent';
    }
  }

  String getpay(int s ){
    if(s == 0){
      return 'Not Payment';
    }else{
      return 'Payment';
    }
  }

}