import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';

class Stateorder extends StatefulWidget {
  const Stateorder({super.key});

  @override
  State<Stateorder> createState() => _StateorderState();
}

class _StateorderState extends State<Stateorder> {
   int si1 = 0 ;
   String id = '';
   bool isloading = false ;

    @override
  void initState() {
    super.initState();
    id = Provider.of<Mypro>(context , listen: false).idorder;
    si1 = Provider.of<Mypro>(context , listen: false).state;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
                              title: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 65 ,
                                    margin: EdgeInsets.only(right: 17),
                                    child: Image.asset('assets/images/workflow.png' , fit: BoxFit.cover,),
                                  ),
                                  const Text(
                                    'Change State : ',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'RobotoCondensed',
                                      color: Color.fromARGB(219, 14, 179, 255),
                                    ),
                                  ),
                                ],
                              ),
                              content: Container(
                                width:MediaQuery.of(context).size.width * 0.6,
                                height: MediaQuery.of(context).size.height * 0.27,
                                alignment: Alignment.topCenter,
                                child: isloading == false? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Spacer(),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 200,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                width: 1.3,
                                                color:si1==2? const Color.fromARGB(136, 255, 99, 99):const Color.fromARGB(255, 130, 129, 129),
                                              )),
                                          child:  Text('In preparation', style: TextStyle(
                                                fontSize: 25,
                                                color: si1==2? const Color.fromARGB(255, 0, 167, 189): Colors.grey,
                                                fontFamily: 'RobotoCondensed'),
                                          ),
                                        ),
                                        const SizedBox(width: 40),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 200,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                width: 1.3,
                                                color:si1<4? const Color.fromARGB(136, 255, 99, 99):const Color.fromARGB(255, 130, 129, 129),
                                              )),
                                          child:  Text('on the way', style: TextStyle(
                                                fontSize: 25,
                                                color: si1<4? const Color.fromARGB(255, 0, 167, 189): Colors.grey,
                                                fontFamily: 'RobotoCondensed' , 
                                                fontWeight: FontWeight.w300
                                                ),
                                          ),
                                        ),
                                        SizedBox(width: 40,),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 200,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                width: 1.3,
                                                color: const Color.fromARGB(136, 255, 99, 99)
                                              )),
                                          child: const Text('sent', style: TextStyle(
                                                fontSize: 25,
                                                color: Color.fromARGB(255, 0, 167, 189),
                                                fontFamily: 'RobotoCondensed' , 
                                                fontWeight: FontWeight.w300
                                                ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    const SizedBox(height: 30,),
                                    Container(
                                      padding: EdgeInsets.only(right: 30),
                                      alignment: Alignment.centerRight,
                                      child: TextButton(onPressed: ()async{
                                         if(si1 <4){
                                          setState(() {
                                            si1 +=1 ;
                                            isloading = true;
                                          });
                                          try{
                                            await Provider.of<Mypro>(context , listen: false).getstate(id);
                                            Provider.of<Mypro>(context , listen: false).changestate(si1);
                                            Navigator.of(context).pop();
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
                                             isloading = false;
                                           });
                                         }

                                        //  if(si2 == 1){
                                        //   setState(() {
                                        //     si1 = 2 ;
                                        //   });
                                        //    Navigator.of(context).pop();
                                        //    showDialog(context: context, builder: (ctx) => statedialogtest(context , ctx));
                                        //  }

                                        // if(si2 == 2){
                                        //   setState(() {
                                        //   si1 = 3;
                                        // });
                                        // Navigator.of(context).pop();
                                        // showDialog(context: context, builder: (ctx) => statedialogdone(context , ctx));
                                        // }
                                      },
                                        style: ButtonStyle(
                                          overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.0))
                                        ),
                                       child:  Text('Next' , style: TextStyle(
                                        fontSize: 25,
                                        color:si1<4? Color.fromARGB(255, 252, 104, 104):Colors.grey,
                                        fontFamily: 'Pacifico' , 
                                        fontWeight: FontWeight.w300
                                      ),)),
                                    ),
                                  ],
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
}