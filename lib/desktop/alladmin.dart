import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';

class Alladmins extends StatefulWidget {
  const Alladmins({super.key});

  @override
  State<Alladmins> createState() => _AlladminsState();
}

class _AlladminsState extends State<Alladmins> {
   
    List<dynamic> admins =[];
    bool isloading = false ;
   @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, ()async{
      try{
        setState(() {
          isloading = true;
        });
        await Provider.of<Mypro>(context , listen: false).getalladmins();
        admins = Provider.of<Mypro>(context , listen: false).alladmins;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            width: 60,
            height: 65,
            margin: const EdgeInsets.only(right: 17),
            child: Image.asset(
              'assets/images/cv.png',
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            'All Admins  : ',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'RobotoCondensed',
              color: Color.fromARGB(219, 14, 179, 255),
            ),
          ),
        ],
      ),
      content: Container(
        height: MediaQuery.of(context).size.height*0.7,
        width: MediaQuery.of(context).size.width*0.8,
        child: isloading == false? ListView.builder(
          itemCount: admins.length,
          itemBuilder: (_ , index)=>Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 230,
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                     const Icon(Icons.person , size: 30, color: Color.fromARGB(219, 14, 179, 255),),
                     const SizedBox(width: 10,),
                      Text('${admins[index]['name']}  ' , style:const TextStyle(
                        color:  Color.fromARGB(237, 1, 58, 165),
                        fontSize: 25,
                        fontFamily: 'RobotoCondensed'
                      ),),
                      Text('(${admins[index]['phone_number']})' , style:const TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 15,
                        color: Colors.grey
                      ),),
                     const Text('  :' , style: TextStyle(
                         color:  Color.fromARGB(237, 1, 58, 165),
                        fontSize: 30,
                        fontFamily: 'RobotoCondensed'
                      ),)
                    ],
                  ) ,
                ),
                SizedBox(
                   width: 710,
                   height: 110,
                   child: Column(
                    children: [
                      Row(
                        children: [
                           SizedBox(
                           width: 170,
                          height: 50,
                          child: CheckboxListTile(
                                    fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                    checkColor: const Color.fromARGB(219, 14, 179, 255),
                                    overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                    value:((admins[index]['permissions'] as List<dynamic>).any((element) => element['id']==6))?true:false,
                                    title: const Text(
                                      'Add Product',
                                      style: TextStyle(fontSize: 15 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (val) {}
                                    ),
                        ),
                         SizedBox(
                          width: 177,
                          height: 50,
                          child: CheckboxListTile(
                                    fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                    checkColor: const Color.fromARGB(219, 14, 179, 255),
                                    overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                    value: ((admins[index]['permissions'] as List<dynamic>).any((element) => element['id']==7))?true:false,
                                    title: const Text(
                                      'Delete Product',
                                      style: TextStyle(fontSize: 15 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (val) {}),
                        ),
                         SizedBox(
                          width: 177,
                          height: 50,
                          child: CheckboxListTile(
                                    fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                    checkColor: const Color.fromARGB(219, 14, 179, 255),
                                    overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                    value: ((admins[index]['permissions'] as List<dynamic>).any((element) => element['id']==8))?true:false,
                                    title: const Text(
                                      'Update Product',
                                      style: TextStyle(fontSize: 15 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (val) {}),
                        ),
                         SizedBox(
                           width: 170,
                          height: 50,
                          child: CheckboxListTile(
                                    fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                    checkColor: const Color.fromARGB(219, 14, 179, 255),
                                    overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                    value: ((admins[index]['permissions'] as List<dynamic>).any((element) => element['id']==5))?true:false,
                                    title: const Text(
                                      'Add Admins',
                                      style: TextStyle(fontSize: 15 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (val) {}),
                        ),
                        ],
                      ),
                     Row(
                        children: [
                           SizedBox(
                          width: 170,
                          height: 50,
                          child: CheckboxListTile(
                                    fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                    checkColor: const Color.fromARGB(219, 14, 179, 255),
                                    overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                    value: ((admins[index]['permissions'] as List<dynamic>).any((element) => element['id']==2))?true:false,
                                    title: const Text(
                                      'Add Company',
                                      style: TextStyle(fontSize: 15 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (val) {}
                                    ),
                        ),
                         SizedBox(
                          width: 180,
                          height: 50,
                          child: CheckboxListTile(
                                    fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                    checkColor: const Color.fromARGB(219, 14, 179, 255),
                                    overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                    value: ((admins[index]['permissions'] as List<dynamic>).any((element) => element['id']==1))?true:false,
                                    title: const Text(
                                      'Delete Company',
                                      style: TextStyle(fontSize: 15 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (val) {}),
                        ),
                         SizedBox(
                           width: 180,
                          height: 50,
                          child: CheckboxListTile(
                                    fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                    checkColor: const Color.fromARGB(219, 14, 179, 255),
                                    overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                    value: ((admins[index]['permissions'] as List<dynamic>).any((element) => element['id']==3))?true:false,
                                    title: const Text(
                                      'Update Company',
                                      style: TextStyle(fontSize: 15 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (val) {}),
                        ),
                         SizedBox(
                          width: 170,
                          height: 50,
                          child: CheckboxListTile(
                                    fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                    checkColor: const Color.fromARGB(219, 14, 179, 255),
                                    overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                    value: ((admins[index]['permissions'] as List<dynamic>).any((element) => element['id']==4))?true:false,
                                    title: const Text(
                                      'Change state of product',
                                      style: TextStyle(fontSize: 12 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (val) {}),
                        ),
                        ],
                      ),

                    ],
                   ),
                ),
                Container(
                  width: 60,
                  height: 70,
                  alignment: Alignment.center,
                  child: TextButton(onPressed: ()async{
                    try{
                      setState(() {
                        isloading = true;
                      });
                       await Provider.of<Mypro>(context,listen: false).deletadmin((admins[index]['phone_number']).toString());
                       await Provider.of<Mypro>(context , listen: false).getalladmins();
                       admins = Provider.of<Mypro>(context , listen: false).alladmins;

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
                  },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.0))
                    ),
                   child: Icon(Icons.person_remove , size: 40 , color: const Color.fromARGB(255, 255, 111, 111),)),
                )
              ],
            ),
            Container(
              width:MediaQuery.of(context).size.width*0.7 ,
              alignment: Alignment.center,
              child: SizedBox(
                width:MediaQuery.of(context).size.width*0.6 ,
                child: Divider(
                  thickness: 1.2,
                  color:Color.fromARGB(255, 1, 43, 121) ,
                ),
              ),
            )
          ],
        ),
)   :const Center(
  child: SizedBox(
    width: 60,
    height: 60,
    child: CircularProgressIndicator(),
  ),
)   
      ),
    );
  }
}
