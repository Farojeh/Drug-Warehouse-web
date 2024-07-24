import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';


class Comdialog extends StatefulWidget {
  const Comdialog({super.key});

  @override
  State<Comdialog> createState() => _ComdialogState();
}

class _ComdialogState extends State<Comdialog> {
  bool isloading = false;
  var com = [];
  String _baseurl = '';
  @override
  void initState() {
    super.initState();
     Future.delayed(Duration.zero, () async {
      setState(() {
        isloading = true;
      });
     try{
         await Provider.of<Mypro>(context, listen: false).getcompany();
      // ignore: use_build_context_synchronously
      com = Provider.of<Mypro>(context, listen: false).comapnies;
       _baseurl = Provider.of<Mypro>(context , listen: false).baseurl;
     }catch(errore){
       showDialog(context: context, builder: (ctxx)=>AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40)
      ),
      title: const Text('Warning', style: TextStyle(color:  Color.fromARGB(255, 252, 93, 93) , fontSize: 25), textAlign: TextAlign.center,),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                            ),
                                content: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.5,
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.4,
                                    color: Colors.white,
                                    child: isloading == false? GridView(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:MediaQuery.of(context).size.width *0.1,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20,
                                      ),
                                      children: com.map((e) => InkWell(
                                            onTap: (){
                                              Navigator.of(context).pop(e['id']);
                                            },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 1, 51, 145),
                                                        width: 1.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        height: 55,
                                                        width: 60,
                                                        child:  Image.network(
                                                      '${_baseurl}image?name=${e['icon']!}',
                                                      headers: const {"ngrok-skip-browser-warning": 'true',
                                                             'Accept':'application/json', },
                                                      // '${url}api/image?name=${e['icon']!}',
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        e['name']!,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                'RobotoCondensed',
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ):Center(
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: CircularProgressIndicator(),
                                      ),
                                    )),
                              );
  }
}