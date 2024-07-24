import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:flutter_web/desktop/updatemed.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Meddetails extends StatefulWidget {
  String id;
  // ignore: use_key_in_widget_constructors
  Meddetails(this.id);

  @override
  State<Meddetails> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Meddetails> {
  
  Map<String, dynamic> _showpro = {};
  bool isloading = false;
  List<dynamic> perm =[];
   String _baseurl = '';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      setState(() {
        isloading = true;
      });
      try {
        await Provider.of<Mypro>(context, listen: false).getshowmed(widget.id);
        _showpro = Provider.of<Mypro>(context, listen: false).showpro;
        perm = Provider.of<Mypro>(context , listen: false).permissions;
        _baseurl = Provider.of<Mypro>(context , listen: false).baseurl;
      } catch (errore) {
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
                  content: Text(errore.toString()),
                ));
      }
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.99,
        color: Colors.white,
        child: isloading == false? SingleChildScrollView(
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.25,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: (_showpro['product']?['photo']) == null
                            ? Image.asset(
                                'assets/images/def.png',
                                fit: BoxFit.fitWidth,
                              )
                            : Image.network(
                                '${_baseurl}image?name=${_showpro['product']?['photo']}',
                                  headers: const {"ngrok-skip-browser-warning": 'true',
                                           'Accept':'application/json', },
                                fit: BoxFit.fitHeight,
                              ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 9, left: 0),
                        child: ListTile(
                          title: Text(
                            '${_showpro['product']?['commercial_name']}',
                            style: const TextStyle(
                                fontFamily: 'RobotoCondensed',
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          subtitle: Text(
                              '(${_showpro['product']?['scientific_name']} )'),
                        )),
                    SizedBox(
                        height: 18,
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: const Divider(
                          color: Color.fromARGB(158, 1, 51, 145),
                        )),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 70,
                          child: Column(
                            children: [
                              const Spacer(),
                              const Text('Stock',
                                  style: TextStyle(
                                      fontFamily: 'RobotoCondensed',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200,
                                      color: Color.fromARGB(237, 1, 51, 145))),
                              const Spacer(),
                              const Spacer(),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 70,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color:
                                            const Color.fromARGB(185, 3, 168, 244)
                                                .withOpacity(0.3)),
                                    child: Text(
                                        '${(_showpro['product']?['quantity']).toString()}',
                                        style: const TextStyle(
                                            fontFamily: 'RobotoCondensed',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w200,
                                            color: Color.fromARGB(
                                                237, 1, 51, 145)))),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: 10,
                            child: const DottedLine(
                              lineThickness: 2,
                              direction: Axis.vertical,
                              dashLength: 7,
                              lineLength: 50,
                              dashColor: Color.fromARGB(237, 1, 51, 145),
                            )),
                        Container(
                          width: 100,
                          height: 70,
                          //color: Colors.amber,
                          child: Column(
                            children: [
                              const Spacer(),
                              const Text('Category',
                                  style: TextStyle(
                                      fontFamily: 'RobotoCondensed',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200,
                                      color: Color.fromARGB(237, 1, 51, 145))),
                              const Spacer(),
                              const Spacer(),
                              const Spacer(),
                              Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 30,
                                child: Text(
                                    '${_showpro['product']?['classification']?['name']}',
                                    style: const TextStyle(
                                        fontFamily: 'RobotoCondensed',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200,
                                        color: Color.fromARGB(185, 3, 168, 244))),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: 10,
                            child: const DottedLine(
                              lineThickness: 2,
                              direction: Axis.vertical,
                              dashLength: 7,
                              lineLength: 50,
                              dashColor: Color.fromARGB(237, 1, 51, 145),
                            )),
                        Container(
                          width: 100,
                          height: 70,
                          //color: Colors.amber,
                          child: Column(
                            children: [
                              const Spacer(),
                              const Text('Total Price',
                                  style: TextStyle(
                                      fontFamily: 'RobotoCondensed',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200,
                                      color: Color.fromARGB(237, 1, 51, 145))),
                              const Spacer(),
                              const Spacer(),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 70,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color:
                                            const Color.fromARGB(185, 3, 168, 244)
                                                .withOpacity(0.3)),
                                    child: Text(
                                        (_showpro['product']?['price']).toString(),
                                        style: const TextStyle(
                                            fontFamily: 'RobotoCondensed',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w200,
                                            color: Color.fromARGB(
                                                237, 1, 51, 145)))),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 18,
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: const Divider(
                          color: Color.fromARGB(158, 1, 51, 145),
                        )),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Company : ',
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 23,
                              color: Color.fromARGB(248, 1, 51, 145),
                            ),
                          ),
                        ),
                        Text('${_showpro['product']?['company']?['name']}',
                            style: const TextStyle(
                                fontFamily: 'RobotoCondensed',
                                fontWeight: FontWeight.w200,
                                fontSize: 18,
                                color: Color.fromARGB(185, 3, 168, 244)))
                      ],
                    ),
                    SizedBox(
                        height: 6,
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: Container()),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            ' Expiration Date : ',
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 23,
                              color: Color.fromARGB(248, 1, 51, 145),
                            ),
                          ),
                        ),
                        Text('${_showpro['product']?['expiration_date']}',
                            style: const TextStyle(
                                fontFamily: 'RobotoCondensed',
                                fontWeight: FontWeight.w200,
                                fontSize: 18,
                                color: Color.fromARGB(185, 3, 168, 244)))
                      ],
                    ),
                    SizedBox(
                        height: 6,
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: Container()),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Description  :',
                        style: TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontSize: 23,
                          color: Color.fromARGB(248, 1, 51, 145),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8, top: 5 , bottom: 12),
                      alignment: Alignment.topCenter,
                    //  height: 95,
                      child: Text(
                        '${_showpro['product']?['description']}',
                        style: const TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontWeight: FontWeight.w200,
                            fontSize: 18,
                            color: Color.fromARGB(185, 3, 168, 244)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      children: [
                       const SizedBox(width: 30,),
                        ElevatedButton(
                          onPressed: () async{
                          if(perm.any((element) => element['id']==8)){
                            await showDialog(context: context,barrierDismissible: false, builder: (stx)=> Updatemed(( _showpro['product']?['id']).toString())).then((value) {
                            Navigator.of(context).pop(value);
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
                            backgroundColor: const Color.fromARGB(255, 162, 231, 255)),
                          child: const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            child: Text(
                              'Edit ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 1, 43, 121),
                                fontSize: 22,
                                fontFamily: 'Pacifico',
                              ),
                            ),
                          ),
                        ),
                       const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                           if(perm.any((element) => element['id']==7)){
                              setState(() {
                              isloading = true;
                            });
                            try {
                              Provider.of<Mypro>(context, listen: false).deletemed((_showpro['product']?['id']).toString());
                              Navigator.of(context).pop(true);
                            } catch (error) {
                              showDialog(
                                  context: context,
                                  builder: (ctxx) => AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(40)),
                                        title: const Text('Warning',
                                          style: TextStyle(
                                              color: Color.fromARGB(255, 252, 93, 93),
                                              fontSize: 25),
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Text(error.toString()),
                                      ));
                            }
                            setState(() {
                              isloading = false;
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
                            backgroundColor:
                                const Color.fromARGB(255, 162, 231, 255),
                          ),
                          child: const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            child: Text(
                              'Delete ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 1, 43, 121),
                                fontSize: 22,
                                fontFamily: 'Pacifico',
                              ),
                            ),
                          ),
                        ),
                       const SizedBox(width: 30),
                      ],
                    )
                  ],
                ),
        )
            : const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }
}
