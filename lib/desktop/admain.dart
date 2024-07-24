import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Admains extends StatefulWidget {
  const Admains({super.key});

  @override
  State<Admains> createState() => _AdmainsState();
}

class _AdmainsState extends State<Admains> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  bool b1 = false,
      b2 = false,
      b3 = false,
      b4 = false,
      b5 = false,
      b6 = false,
      b7 = false,
      b8 = false;
      List<int> per = [];
      String phone = '';
      bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.21,
          height: MediaQuery.of(context).size.height,
          // color: Colors.amber,
          alignment: Alignment.center,
          child: SizedBox(
            height: 550,
            width: 250,
            child: Image.asset(
              'assets/images/admin.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
       isloading==false? SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                child: Text(
                  'Add New Admin With Certain Permissions :',
                  style: TextStyle(
                      fontSize: 38,
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(237, 1, 51, 145)),
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Form(
                      key: _formkey,
                      child: Row(
                        children: [
                         const Icon(
                            Icons.phone,
                            size: 37,
                            color: Color.fromARGB(219, 14, 179, 255),
                          ),
                         const SizedBox(
                            width: 10,
                          ),
                        const  Text(
                            'Phone Number : ',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'RobotoCondensed',
                                color: Color.fromARGB(237, 1, 51, 145)),
                          ),
                          const SizedBox(width: 20,),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: ' admin phone ',
                                  labelStyle: TextStyle(
                                      color: const Color.fromARGB(219, 14, 179, 255).withOpacity(0.5),
                                      fontSize: 18),
                                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(
                                       color: Color.fromARGB(237, 1, 51, 145),
                                  )),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(237, 1, 51, 145),
                                      width: 1.4,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(237, 1, 51, 145),
                                          width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                              validator: (val) {
                                if (val == null ||val.isEmpty ||val.length <= 9) {
                                  return 'number is not true ';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (newValue) {
                                phone = newValue!;
                              },
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ))),
            const  Padding(
                  padding: EdgeInsets.only(left: 25, top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline_rounded,
                          size: 37, color: Color.fromARGB(219, 14, 179, 255)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Choose premissions : ',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            color: Color.fromARGB(237, 1, 51, 145),
                            fontSize: 25),
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(left: 50, top: 20),
                height: 280,
                width: 600,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(237, 1, 51, 145), width: 1.2),
                    borderRadius: BorderRadius.circular(40)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 280,
                      width: 282,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10 , left: 10),
                            child: CheckboxListTile(
                                fillColor: MaterialStateProperty.all(const Color.fromARGB(237, 1, 51, 145)),
                                checkColor: const Color.fromARGB(219, 14, 179, 255),
                                overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                value: b1,
                                title: const Text(
                                  'Add product  ',
                                  style: TextStyle(fontSize: 23 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (val) {
                                  setState(() {
                                    b1 = val!;
                                  });
                                  if(per.contains(6)){
                                    if(b1 == false){
                                      per.remove(6);
                                    }
                                  }else{
                                     if(b1 == true){
                                    per.add(6);
                                  }
                                  }
                                 
                                }),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(top: 10 , left: 10),
                            child: CheckboxListTile(
                                fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                checkColor: const Color.fromARGB(219, 14, 179, 255),
                                //activeColor: Colors.pink,
                                // tileColor: Colors.deepPurpleAccent,
                                overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                value: b2,
                                title:const Text(
                                  'Delete product  ',
                                  style: TextStyle(fontSize: 23 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (val) {
                                  setState(() {
                                    b2 = val!;
                                  });
                                   if(per.contains(7)){
                                    if(b2 == false){
                                      per.remove(7);
                                    }
                                  }else{
                                     if(b2 == true){
                                    per.add(7);
                                  }
                                  }
                                }),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(top: 10 , left: 10),
                            child: CheckboxListTile(
                                fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                checkColor: const Color.fromARGB(219, 14, 179, 255),
                                //activeColor: Colors.pink,
                                // tileColor: Colors.deepPurpleAccent,
                                overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                value: b3,
                                title: const Text(
                                  'Update product  ',
                                  style: TextStyle(fontSize: 23 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (val) {
                                  setState(() {
                                    b3 = val!;
                                  });
                                   if(per.contains(8)){
                                    if(b3 == false){
                                      per.remove(8);
                                    }
                                  }else{
                                     if(b3 == true){
                                    per.add(8);
                                  }
                                  }
                                }),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(top: 10 , left: 10),
                            child: CheckboxListTile(
                                fillColor: MaterialStateProperty.all( const Color.fromARGB(237, 1, 51, 145)),
                                checkColor: const Color.fromARGB(219, 14, 179, 255),
                                overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                value: b4,
                                title: const Text(
                                  'Change State of product  ',
                                  style: TextStyle(fontSize: 23 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (val) {
                                  setState(() {
                                    b4 = val!;
                                  });
                                   if(per.contains(4)){
                                    if(b4 == false){
                                      per.remove(4);
                                    }
                                  }else{
                                     if(b4 == true){
                                    per.add(4);
                                  }
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  const  Center(
                      child: SizedBox(
                        height: 200,
                        width: 20,
                      ),
                    ),
                    SizedBox(
                      height: 280,
                      width: 282,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10 , left: 10),
                            child: CheckboxListTile(
                                fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                checkColor: Color.fromARGB(219, 14, 179, 255),
                                overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                value: b5,
                                title: const Text(
                                  'Add Admin  ',
                                  style: TextStyle(fontSize: 23 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (val) {
                                  setState(() {
                                    b5 = val!;
                                  });
                                   if(per.contains(5)){
                                    if(b5 == false){
                                      per.remove(5);
                                    }
                                  }else{
                                     if(b5 == true){
                                    per.add(5);
                                  }
                                  }
                                }),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(top: 10 , left: 10),
                            child: CheckboxListTile(
                                fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                checkColor: Color.fromARGB(219, 14, 179, 255),
                                overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                value: b6,
                                title:const Text(
                                  'Add Company  ',
                                  style: TextStyle(fontSize: 23 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (val) {
                                  setState(() {
                                    b6 = val!;
                                  });
                                   if(per.contains(2)){
                                    if(b6 == false){
                                      per.remove(2);
                                    }
                                  }else{
                                     if(b6 == true){
                                    per.add(2);
                                  }
                                  }
                                }),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(top: 10 , left: 10),
                            child: CheckboxListTile(
                                fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                checkColor: Color.fromARGB(219, 14, 179, 255),
                                overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                value: b7,
                                title: const Text(
                                  'Delete Company  ',
                                  style: TextStyle(fontSize: 23 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (val) {
                                  setState(() {
                                    b7 = val!;
                                  });
                                   if(per.contains(1)){
                                    if(b7 == false){
                                      per.remove(1);
                                    }
                                  }else{
                                     if(b7 == true){
                                    per.add(1);
                                  }
                                  }
                                }),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(top: 10 , left: 10),
                            child: CheckboxListTile(
                                fillColor: MaterialStateProperty.all(Color.fromARGB(237, 1, 51, 145)),
                                checkColor: Color.fromARGB(219, 14, 179, 255),
                                //activeColor: Colors.pink,
                                // tileColor: Colors.deepPurpleAccent,
                                overlayColor:MaterialStateProperty.all(Colors.black.withOpacity(0.0)),
                                value: b8,
                                title: const Text(
                                  'Update Company ',
                                  style: TextStyle(fontSize: 23 , fontFamily: 'RobotoCondensed' , color:  Color.fromARGB(219, 14, 179, 255)),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (val) {
                                  setState(() {
                                    b8 = val!;
                                  });
                                   if(per.contains(3)){
                                    if(b8 == false){
                                      per.remove(3);
                                    }
                                  }else{
                                     if(b8 == true){
                                    per.add(3);
                                  }
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Row(
                children: [
                 const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20 , right: 20 , top: 35),
                    child: ElevatedButton(onPressed: ()async{
                        if(!_formkey.currentState!.validate()){return;}
                        _formkey.currentState?.save();
                          for(int i = per.length+1 ; i<=8 ; i++){
                            per.add(0);
                        }
                        try{
                        setState(() {
                          isloading = true;
                        });
                        Provider.of<Mypro>(context , listen: false).setadmin(phone, per);
                        await Provider.of<Mypro>(context , listen: false).newadmin();
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(Homepage.homename);
                        }catch(error){
                           showDialog(
                                          context: context,
                                          builder: (ctxx) => AlertDialog(
                                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(40)),
                                                title: const Text(
                                                  'Warning',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(255, 252, 93, 93),
                                                      fontSize: 25),
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: Text(error.toString()),
                                              )).then((value) {
                                                setState(() {
                                                  b1 = false;
                                                  b2 = false;
                                                  b3 = false;
                                                  b4 = false;
                                                  b5 = false;
                                                  b6 = false;
                                                 b7 = false;
                                                 b8 = false;
                                                 per = [];
                                                 phone = '';
                                                });
                                              });
                        }
                        setState(() {
                          isloading = false;
                        });
                    },
                      style:  ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),),
                        backgroundColor:const Color.fromARGB(255, 31, 183, 254)
                      ),
                     child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 7),
                      child: const Text('Confirm' ,  style: TextStyle(
                            color: Color.fromARGB(255, 1, 43, 121),
                            fontSize: 25,
                            fontFamily: 'Pacifico',
                          ),),
                    )),
                    )
                ],
              )
            ],
          ),
        ):  Center(
          child: Container(
            margin:const EdgeInsets.only(left: 100),
            child:const SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          ),
        )
      ],
    );
  }
}
