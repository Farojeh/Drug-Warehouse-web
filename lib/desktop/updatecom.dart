import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Updatecompany extends StatefulWidget {
  String id ;
  // ignore: use_key_in_widget_constructors
  Updatecompany(this.id);

  @override
  State<Updatecompany> createState() => _UpdatecompanyState();
}

class _UpdatecompanyState extends State<Updatecompany> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  String name ='';
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height*0.43,
        width: MediaQuery.of(context).size.width*0.45,
        child: Form(
          key: _formkey,
          child:  isloading == false?  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    margin: EdgeInsets.only(right: 17),
                    child: Image.asset(
                      'assets/images/com.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                 const SizedBox(width: 10,),
                  const Text(
                    'Add Company : ',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(219, 14, 179, 255),
                    ),
                  ),
                 const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'X',
                        style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 1, 43, 121),),
                      ))
                ],
              ),
               Padding(
                 padding: const EdgeInsets.only(left: 20),
                 child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 150,
                        child: Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 150,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: 160,
                                      width: 150,
                                      child: Image.asset(
                                        'assets/images/border.png',
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: Image.asset(
                                        'assets/images/pic.png',
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.grey.withOpacity(0.2)),
                                      child: const Icon(
                                        Icons.add,
                                        color: Color.fromARGB(255, 0, 118, 173),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        height: 200,
                        width: 300,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 25),
                              height: 60,
                              width: 280,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child:const Text('Please Enter The Name of Company :' , 
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'RobotoCondensed',
                                  color: Color.fromARGB(255, 1, 43, 121)
                                ),),
                              )                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 60,
                              width: 280,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: " Company's Name ",
                                    labelStyle:  TextStyle(
                                        color: const Color.fromARGB(219, 14, 179, 255).withOpacity(0.6), fontSize: 18),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromARGB(255, 1, 43, 121),
                                    )),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 1, 43, 121),
                                        width: 1.4,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 1, 43, 121), width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'scientific Name is Empty ';
                                  } else{ return null;}
                                },
                                onSaved: (newValue) {
                                 name = newValue!;
                                },
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                             ),
               ),
               Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                child: Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: ()async{
                         if (!_formkey.currentState!.validate()) {
                                return;
                              }
                              _formkey.currentState?.save();
                              try{
                              setState(() {
                                isloading = true;
                              });
                              Provider.of<Mypro>(context , listen: false).setupdatecompany(name);
                              await Provider.of<Mypro>(context , listen: false).getupdatecompany(widget.id);
                              Navigator.of(context).pop(true);
                              }catch(error){
                                 showDialog(
                                context: context,
                                builder: (ctxx) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      title: const Text(
                                        'Warning',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 252, 93, 93),
                                            fontSize: 25),
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Text(error.toString()),
                                    ));
                              }
                              setState(() {
                                isloading = false;
                              });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),),
                        backgroundColor: const Color.fromARGB(255, 162, 231, 255),
                      ),
                      child:const Padding(
                        padding:  EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            color: Color.fromARGB(255, 1, 43, 121),
                            fontSize: 25,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ): const Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
          ) ),
      ),
    );
  }
}