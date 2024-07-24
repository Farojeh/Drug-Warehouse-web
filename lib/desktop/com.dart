import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';

class ADDcompany extends StatefulWidget {
  const ADDcompany({super.key});

  @override
  State<ADDcompany> createState() => _ADDcompanyState();
}

class _ADDcompanyState extends State<ADDcompany>{
   final GlobalKey<FormState> _formkey = GlobalKey();
    String companyname = '';
    List<int>? _selectedfile ;
   Uint8List? _bytesdata ;
   bool isloading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height*0.43,
        width: MediaQuery.of(context).size.width*0.45,
        child: isloading == false? Form(
          key: _formkey,
          child:Column(
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
                  SizedBox(width: 10,),
                  const Text(
                    'Add Company : ',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(219, 14, 179, 255),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
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
                        child:  _bytesdata == null ? Center(
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
                                  onPressed: fetchimage,
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
                        )
                      ):Image.memory(_bytesdata! , fit: BoxFit.fitHeight,),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        height: 200,
                        width: 300,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              height: 60,
                              width: 280,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text('Please Enter The Name of Company :' , 
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'RobotoCondensed',
                                  color: Color.fromARGB(255, 1, 43, 121)
                                ),),
                              )                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 60,
                              width: 280,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: " Company's Name ",
                                    labelStyle:  TextStyle(
                                        color: Color.fromARGB(219, 14, 179, 255).withOpacity(0.6), fontSize: 18),
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
                                  return 'company name is Empty ';
                                } else{ return null;}
                              },
                              onSaved: (newValue) {
                                companyname = newValue!;
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
                    Spacer(),
                    ElevatedButton(
                      onPressed: (){pressed(context);},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),),
                        backgroundColor: Color.fromARGB(255, 162, 231, 255),
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
          ) ): const Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          ),
      ),
    );
  }

  fetchimage() async{
    html.FileUploadInputElement uploadinput =html.FileUploadInputElement();
    uploadinput.multiple = true ;
    uploadinput.draggable = true ;
    uploadinput.click();

    uploadinput.onChange.listen((event) { 
      final files = uploadinput.files;
      final file = files![0];
      final reader = html.FileReader();
      reader.onLoadEnd.listen((event) { 
        setState(() {
          _bytesdata = Base64Decoder().convert(reader.result.toString().split(",").last);
          _selectedfile = _bytesdata;
        });
      });
      reader.readAsDataUrl(file);
    });
   }

  void pressed(BuildContext ctx)async{
    if(!_formkey.currentState!.validate()){
  return;
    }
    if (_bytesdata == null ){
      showDialog(context: ctx, builder: (_)=>AlertDialog(
        content: Text('Please Choose photo' , style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontFamily: 'RobotoCondensed'
        ),),
      ));
      return;
    }

    _formkey.currentState?.save();
     setState(() {
       isloading = true;
     });
     try{
       Provider.of<Mypro>(ctx , listen: false).setmapcompany(companyname);
       await Provider.of<Mypro>(ctx , listen: false).setcompany(_selectedfile);
       // ignore: use_build_context_synchronously
       Navigator.of(ctx).pop(true);
     }catch(error){
       showDialog(context: ctx, builder: (ctxx)=>AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40)
      ),
      title: const Text('Warning', style: TextStyle(color:  Color.fromARGB(255, 252, 93, 93) , fontSize: 25), textAlign: TextAlign.center,),
      content: Text(error.toString()),
    ));
     }
     setState(() {
       isloading=false;
     });
  }


}