import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/payment.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:flutter_web/desktop/state.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class Orderdet extends StatefulWidget {

  @override
  State<Orderdet> createState() => _OrderdetState();
}

class _OrderdetState extends State<Orderdet> {
  String id = '';
  int state = 0;
  int paid = 0;
  List<dynamic> _order = [];
  bool isloading = false;
  List<dynamic> perm =[];
   String getstate(int s ){
    if(s == 1){
      return 'Under Acceptance ';
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
    String _baseurl = '';

     @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero , ()async{
     try{
      setState(() {
        isloading = true ;
      });
       id = Provider.of<Mypro>(context , listen: false).idorder;
       state = Provider.of<Mypro>(context , listen: false).state;
       paid = Provider.of<Mypro>(context, listen: false).payment;
       await Provider.of<Mypro>(context , listen: false).getorder(id);
      _order = Provider.of<Mypro>(context , listen: false).sporder;
      _baseurl = Provider.of<Mypro>(context , listen: false).baseurl;
      await Provider.of<Mypro>(context , listen: false).getper();
      perm = Provider.of<Mypro>(context , listen: false).permissions;
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
        isloading = false ;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return isloading == false ? Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.13,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      'assets/images/clipboard.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 30),
                  ShaderMask(
                    shaderCallback: (boonds) => const LinearGradient(colors: [
                      Color.fromARGB(226, 14, 179, 255),
                      Color.fromARGB(255, 0, 167, 189),
                      Color.fromARGB(255, 252, 104, 104),
                      Color.fromARGB(226, 14, 179, 255),
                      Color.fromARGB(255, 0, 160, 181),
                      Color.fromARGB(255, 255, 99, 99)
                    ]).createShader(Rect.fromLTWH(0, 0, boonds.width, boonds.height)),
                    child: const Text(
                      'Order Details : ',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontFamily: 'RobotoCondensed'),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const Spacer(),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: 350,
              alignment: Alignment.center,
              child:(state > 1)? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      if(perm.any((element) => element['id']==4)){
                        showDialog(
                          context: context,
                          builder: (ctx) => Payment()).then((value) {
                           setState(() {
                             isloading = true ;
                           });
                           paid = Provider.of<Mypro>(context, listen: false).payment;
                           setState(() {
                             isloading = false ;
                           });
                          });
                      }else{
                         showDialog(
                    context: context,
                    builder: (ctxx) => AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(40)),
                        title: const Text('Warning',style: TextStyle(color: Color.fromARGB(255, 252, 93, 93),
                                          fontSize: 25),
                                          textAlign: TextAlign.center,),
                        content: const Text('You are not have permission to do that'),
                                              ));
                      }
                      
                    },
                    overlayColor: MaterialStateProperty.all(
                        Colors.white.withOpacity(0.0)),
                    child: SizedBox(
                        width: 350,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.payment,
                              color: Color.fromARGB(255, 248, 100, 100),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Payment',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(219, 14, 179, 255),
                                  fontFamily: 'RobotoCondensed'),
                            ),
                            const Text(
                              ' :',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 252, 104, 104),
                                  fontFamily: 'RobotoCondensed'),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(getpay(paid),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 0, 167, 189),
                                    fontFamily: 'RobotoCondensed'))
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      if(perm.any((element) => element['id']==4)){
                          showDialog(context: context, builder:((context) => Stateorder())).then((value) {
                           setState(() {
                             isloading = true ;
                           });
                           state = Provider.of<Mypro>(context, listen: false).state;
                           setState(() {
                             isloading = false ;
                           });
                          });
                      }else{
                        showDialog(
                    context: context,
                    builder: (ctxx) => AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(40)),
                        title: const Text('Warning',style: TextStyle(color: Color.fromARGB(255, 252, 93, 93),
                                          fontSize: 25),
                                          textAlign: TextAlign.center,),
                        content: const Text('You are not have permission to do that'),
                                              ));
                      }
                    
                    },
                    overlayColor: MaterialStateProperty.all(
                        Colors.white.withOpacity(0.0)),
                    child: SizedBox(
                        width: 350,
                        height: 30,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.settings_applications_outlined,
                              color: Color.fromARGB(255, 248, 100, 100),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'State',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(219, 14, 179, 255),
                                  fontFamily: 'RobotoCondensed'),
                            ),
                            const Text(
                              ' :',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 252, 104, 104),
                                  fontFamily: 'RobotoCondensed'),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(getstate(state),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 0, 167, 189),
                                    fontFamily: 'RobotoCondensed'))
                          ],
                        )),
                  ),
                ],
              ):Center(
                child: ElevatedButton(onPressed: ()async{
                 if(perm.any((element) => element['id']==4)){
                     try{
                     setState(() {
                       isloading = true;
                     state = 2;});
                     await Provider.of<Mypro>(context , listen: false).getstate(id);
                     Provider.of<Mypro>(context , listen: false).changestate(state);
                  }catch(error){
                      showDialog(
                          context: context,
                          builder: (ctxx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                          title: const Text('Warning',style: TextStyle(
                          color: Color.fromARGB(255, 252, 93, 93), fontSize: 25),
                          textAlign: TextAlign.center),
                          content: Text(error.toString())));
                  }
                  setState(() {
                    isloading = false ;
                  });
                 }else{
                  
                         showDialog(
                    context: context,
                    builder: (ctxx) => AlertDialog(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(40)),
                        title: const Text('Warning',style: TextStyle(color: Color.fromARGB(255, 252, 93, 93),
                                          fontSize: 25),
                                          textAlign: TextAlign.center,),
                        content: const Text('You are not have permission to do that'),
                                              ));
                 }

                },
                  style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Color.fromARGB(255, 162, 231, 255),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    'Accept Order',
                    style: TextStyle(
                      color: Color.fromARGB(255, 1, 43, 121),
                      fontSize: 25,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
                 ),
              ),
            )
          ],
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.76,
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.3,
              childAspectRatio: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            children: _order.map((ord) => Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(237, 1, 58, 165),
                          ),
                          borderRadius: BorderRadius.circular(40)),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 8 , top: 5 , bottom: 5),
                             alignment: Alignment.center,
                             height: 95,
                            width: 119,
                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                           child: ClipRRect(
                           borderRadius: BorderRadius.circular(10),
                           child: ord['photo'] != 'no photo' 
                          ? Image.network(
                      '${_baseurl}image?name=${ord['photo']}' ,
                       headers: const {"ngrok-skip-browser-warning": 'true',
                            'Accept':'application/json', },
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/def.png',
                  fit: BoxFit.fitHeight,
                )),
    ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                ord['commercial_name']!,
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontFamily: 'RobotoCondensed',
                                  color: Color.fromARGB(226, 14, 179, 255),
                                ),
                              ),
                              Text(
                                ord['scientific_name']!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'RobotoCondensed',
                                  color: Color.fromARGB(255, 0, 167, 189),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Quantity :${ord['quantity']!}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'RobotoCondensed',
                                      color: Color.fromARGB(255, 0, 167, 189),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    'Price : ${ord['total']!}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'RobotoCondensed',
                                      color: Color.fromARGB(255, 0, 167, 189),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        )
      ],
    ): const Center(
      child: SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(),
      ),
    );
  }

      
}
