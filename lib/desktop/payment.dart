import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});
  
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
   int pi1 = 0 ;
   String id = '';
   bool isloading = false ;
   
    @override
  void initState() {
    super.initState();
    id = Provider.of<Mypro>(context , listen: false).idorder;
    pi1 = Provider.of<Mypro>(context , listen: false).payment;
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
                                    margin: const EdgeInsets.only(right: 17),
                                    child: Image.asset('assets/images/payment.png' , fit: BoxFit.cover,),
                                  ),
                                  const Text(
                                    'Change Payment : ',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'RobotoCondensed',
                                      color: Color.fromARGB(219, 14, 179, 255),
                                    ),
                                  ),
                                ],
                              ),
                              content:  Container(
                                width:MediaQuery.of(context).size.width * 0.45,
                                height: MediaQuery.of(context).size.height * 0.27,
                                alignment: Alignment.topCenter,
                                child:isloading == false ? Column(
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
                                                color: ( pi1 == 0)? const Color.fromARGB(136, 255, 99, 99):const Color.fromARGB(255, 130, 129, 129),
                                              )),
                                          child:  Text('Not Payment', style: TextStyle(
                                                fontSize: 25,
                                                color:(pi1 == 0)? const Color.fromARGB(255, 0, 167, 189): Colors.grey,
                                                fontFamily: 'RobotoCondensed'),
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
                                          child: const Text('Payment', style: TextStyle(
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
                                    SizedBox(height: 15,),
                                    Container(
                                      padding: EdgeInsets.only(right: 30),
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          const SizedBox(height: 20,),
                                          TextButton(onPressed: ()async{
                                              if(pi1 == 0){
                                                try{
                                               setState(() {
                                              isloading = true;
                                              pi1 = 1;
                                                });
                                              await Provider.of<Mypro>(context , listen: false).getpaid(id);
                                              Provider.of<Mypro>(context , listen: false).changepay(pi1);
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
                                                isloading = false ;
                                              });
                                              }
                                          },
                                            style: ButtonStyle(
                                              overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.0))
                                            ),
                                           child:  Text('Next' , style: TextStyle(
                                            fontSize: 25,
                                            color:( pi1 == 0)? Color.fromARGB(255, 252, 104, 104):Colors.grey,
                                            fontFamily: 'Pacifico' , 
                                            fontWeight: FontWeight.w300
                                          ),)),
                                          const SizedBox(height: 5,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ): const Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              )
                            );
  }
}