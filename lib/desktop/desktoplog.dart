import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/home.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';

class Desktoplogin extends StatefulWidget {
  const Desktoplogin({super.key});

  @override
  State<Desktoplogin> createState() => _DesktoploginState();
}
bool isloading = false ;
enum switch_mode { signup, login }

class _DesktoploginState extends State<Desktoplogin> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  switch_mode mode = switch_mode.signup;
 /* Map<String, String?> user = {
    'number': '',
    'password': '',
    'name': '',
  };*/
  
   Map<String, String?> user ={};
   Map<String, String?> userlog ={};
   @override
  void didChangeDependencies() {
    user = Provider.of<Mypro>(context , listen:  true).userreg;
    userlog =  Provider.of<Mypro>(context , listen:  true).userlog;
    super.didChangeDependencies();
  }

  var pass = TextEditingController();
  var pv = true;
  var pvc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
             Color.fromARGB(185, 3, 168, 244),
            Color.fromARGB(255, 162, 231, 255),
            Color.fromARGB(185, 3, 168, 244),
            Color.fromARGB(255, 162, 231, 255),

          ]),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Row(
                      children: [
                         Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 25,   top: 10 ),
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: SizedBox(
                        width: 120,
                        height: 75,
                        child:  Image.asset('assets/images/logomed.png' , fit: BoxFit.fitWidth,),
                      )
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 3,   top: 10 ),
                          height: MediaQuery.of(context).size.height * 0.18,
                          child: const Text(
                            'MedHouse Website',
                            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 1, 51, 145) , fontFamily: 'RobotoCondensed'),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 10),
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shadowColor: Colors.black,
                        elevation: 20,
                        color: const Color.fromARGB(255, 246, 253, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child:isloading== false? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10 , bottom: 30),
                              alignment: Alignment.center,
                              child: const Text(
                                'Login or Signup',
                                style: TextStyle(
                                    fontSize: 40,
                                    color:Color.fromARGB(185, 3, 168, 244),
                                    fontFamily: 'Pacifico'
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.27,
                              width: MediaQuery.of(context).size.width * 0.65,
                             // color: Colors.amber,
                              child: LayoutBuilder(
                                  builder: (ctx, cont) => Form(
                                        key: _formkey,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width:(mode==switch_mode.signup)? cont.maxWidth * 0.45:cont.maxWidth * 0.53,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      labelText: ' Phone Number ',
                                                      labelStyle: TextStyle(
                                                          color: const Color.fromARGB(184, 1, 51, 145).withOpacity(0.5),
                                                          fontSize: 18),
                                                      icon:const Icon(Icons.phone,
                                                        color:  Color.fromARGB(184, 1, 51, 145) , size: 37,),
                                                      focusedBorder:const OutlineInputBorder( borderSide: BorderSide(
                                                         color: Color.fromARGB(184, 1, 51, 145),
                                                      )),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                          color: Color.fromARGB(184, 1, 51, 145),
                                                          width: 1.4,
                                                        ),
                                                        borderRadius:  BorderRadius.circular(30),
                                                      ),
                                                      border: OutlineInputBorder( borderSide: const BorderSide( color: Color.fromARGB(255, 30, 47, 233),width: 2.0),
                                                             borderRadius: BorderRadius.circular(8.0))
                                                      
                                                    ),
                                                    validator: (val) {
                                                     if (val == null ||val.isEmpty || val.length <= 9) {
                                                        return 'number is not true ';
                                                      } else
                                                        return null;
                                                    },
                                                    onSaved: (newValue) {
                                                      if(mode == switch_mode.login){
                                                        userlog['phone_number'] = newValue;
                                                      }
                                                      else{
                                                        user['phone_number'] = newValue;
                                                      }
                                                    },
                                                    keyboardType: TextInputType.number,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: cont.maxHeight * 0.2,
                                                ),
                                              if(mode==switch_mode.signup)SizedBox(
                                                  width: cont.maxWidth * 0.45,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                       icon:const Icon(
                                                          Icons.person,size: 37,
                                                          color:  Color.fromARGB(184, 1, 51, 145),),
                                                      labelText: ' Name ',
                                                      labelStyle: TextStyle(
                                                          color: const Color.fromARGB(184, 1, 51, 145).withOpacity(0.5),
                                                          fontSize: 18),
                                                      focusedBorder:const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                        color: Color.fromARGB(184, 1, 51, 145),
                                                      )),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide:const BorderSide(
                                                          color:  Color.fromARGB(184, 1, 51, 145),
                                                          width: 1.4,
                                                        ),
                                                        borderRadius:  BorderRadius.circular(30),
                                                      ),
                                                      border: OutlineInputBorder( borderSide: const BorderSide( color: Color.fromARGB(255, 30, 47, 233),width: 2.0),
                                                             borderRadius: BorderRadius.circular(8.0))
                                                    ),
                                                    validator: (val) {
                                                        if (val == null ||val.isEmpty ) {
                                                        return 'please enter your name  ';
                                                      } else
                                                        return null;
                                                    },
                                                    onSaved: (newValue) {
                                                      if(mode==switch_mode.signup){
                                                          user['name'] = newValue;
                                                      }
                                                    
                                                    },
                                                    keyboardType: TextInputType.name,
                                                  ),
                                                ),
                                              ],
                                            ),
                                             Padding(
                                               padding: const EdgeInsets.only(top: 30 , bottom: 0),
                                               child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:(mode==switch_mode.signup)? cont.maxWidth * 0.45:cont.maxWidth * 0.53,
                                                    child: TextFormField(
                                                      controller: pass,
                                                      obscureText: pv,
                                                      decoration: InputDecoration(
                                                        labelText: ' Password ',
                                                        labelStyle:TextStyle(
                                                            color:const  Color.fromARGB(184, 1, 51, 145).withOpacity(0.5),
                                                            fontSize: 18),
                                                          suffixIcon: Padding(
                                                            padding: const EdgeInsets.only(left:5.0),
                                                            child: IconButton(
                                                              onPressed:(){setState(() {
                                                                pv = !pv;
                                                              });} ,
                                                               icon: Icon(pv?Icons.visibility:Icons.visibility_off)),
                                                          ),
                                                        icon:const Icon(Icons.password, size: 37,
                                                          color:  Color.fromARGB(184, 1, 51, 145)),
                                                        focusedBorder:const OutlineInputBorder( borderSide: BorderSide(
                                                           color: Color.fromARGB(184, 1, 51, 145),
                                                        )),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                            color: Color.fromARGB(184, 1, 51, 145),
                                                            width: 1.4,
                                                          ),
                                                          borderRadius:  BorderRadius.circular(30),
                                                        ), 
                                                         border: OutlineInputBorder( borderSide: const BorderSide( color: Color.fromARGB(255, 30, 47, 233),width: 2.0),
                                                             borderRadius: BorderRadius.circular(8.0))),
                                                      validator: (val) {
                                                        if (val == null || val.isEmpty ||val.length < 8) {
                                                          return 'Password is too short  ';
                                                        } else
                                                          return null;
                                                      },
                                                      onSaved: (newValue) {
                                                        if(mode == switch_mode.login){
                                                           userlog['password'] = newValue;
                                                        }
                                                        else{
                                                          user['password'] = newValue;
                                                        }
                                                        
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox( width: cont.maxHeight * 0.2),
                                                  if(mode==switch_mode.signup) SizedBox(
                                                    width: cont.maxWidth * 0.45,
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: ' Confirm pssword ',
                                                        labelStyle: TextStyle(
                                                            color:const Color.fromARGB(184, 1, 51, 145).withOpacity(0.5),
                                                            fontSize: 18),
                                                           suffixIcon: Padding(
                                                            padding: const EdgeInsets.only(left:5.0),
                                                            child: IconButton(
                                                              onPressed:(){setState(() {
                                                                pvc = !pvc;
                                                              });} ,
                                                               icon: Icon(pvc?Icons.visibility:Icons.visibility_off)),
                                                          ),
                                                        icon:const Icon(
                                                          Icons.password_sharp,size: 37,
                                                          color:  Color.fromARGB(184, 1, 51, 145),),
                                                        focusedBorder:const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                          color: Color.fromARGB(184, 1, 51, 145))),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide:const BorderSide(
                                                            color: Color.fromARGB(184, 1, 51, 145),
                                                            width: 1.4,
                                                          ),
                                                          borderRadius:  BorderRadius.circular(30),
                                                        ),
                                                        border: OutlineInputBorder( borderSide: const BorderSide( color: Color.fromARGB(255, 30, 47, 233),width: 2.0),
                                                             borderRadius: BorderRadius.circular(8.0))
                                                      ),
                                                      obscureText: pvc,
                                                      validator:  (vall) {
                                                        if(mode == switch_mode.login){return null ;}
                                                        else{
                                                              if(vall == null || vall.isEmpty || vall != pass.text){
                                                               return'password is not true ';
                                                           } else{return null ;}
                                                         }},
                                                    ),
                                                  ),
                                                ],
                                                                                         ),
                                             ),
                                          ],
                                        ),
                                      )),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height*0.2,
                                  width: MediaQuery.of(context).size.width*0.2,
                                  child: Image.asset('assets/images/sidemed.png' , fit: BoxFit.fitHeight,),
                                ),
                                 SizedBox(width: MediaQuery.of(context).size.width*0.004,),
                                ElevatedButton(
                                  onPressed: (){pressed(context);},
                                  style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(40, 16, 40, 16),
                                  backgroundColor: const Color.fromARGB(255, 61, 121, 212),
                                 shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(30))),
                                  child: Text(
                                 (mode == switch_mode.login) ? ' Login ' : 'SignUp',
                                   style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic , fontFamily: 'Pacifico' ),
                                 )),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.009,),
                                 const Text( ' __ ', style: TextStyle( fontSize: 18 , color:Color.fromARGB(185, 3, 168, 244),fontFamily: 'Pacifico' )),
                                 const  Text( ' OR ', style: TextStyle( fontSize: 23 , color:Color.fromARGB(185, 3, 168, 244),fontFamily: 'Pacifico' )),
                                 const Text( ' __ ', style: TextStyle( fontSize: 18 , color:Color.fromARGB(185, 3, 168, 244),fontFamily: 'Pacifico' )),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.009,),
                              TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.0))
                                ),
                                 onPressed: switchm,
                                 child:  Text((mode==switch_mode.login)?"Signup instead":' Login instead',
                                     style: const TextStyle(fontSize: 25, color: Color.fromARGB(255, 61, 121, 212), fontWeight: FontWeight.w400 , fontFamily: 'Pacifico')))
                              ],
                            )
                          ],
                        ):const Center(
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
                flex: 2,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Image.asset(
                    'assets/images/doctor.png',
                    fit: BoxFit.cover,
                  ),
                )),
          ],
        ),
      ),
    );
  }

     void switchm (){
  if(mode == switch_mode.login){
    setState(() {
      mode = switch_mode.signup;
    });
  }else{
    setState(() {
      mode = switch_mode.login;
    });
  }
}

void pressed (BuildContext ctx)async{
if(!_formkey.currentState!.validate()){
  return;
}
_formkey.currentState?.save();
  setState(() {
    isloading = true;
  });
  try{
    if( mode == switch_mode.signup){
     Provider.of<Mypro>(context , listen: false).setmap(user);
     await Provider.of<Mypro>(context , listen: false).setregister();
     // ignore: use_build_context_synchronously
     Navigator.of(context).pushReplacementNamed(Homepage.homename);
    }
    else{
    Provider.of<Mypro>(context , listen: false).setmaplog(userlog);
    await Provider.of<Mypro>(context , listen: false).setlogin();
    // ignore: use_build_context_synchronously
     Navigator.of(context).pushReplacementNamed(Homepage.homename);
    }
  }catch(er){
    //Toast.show(er.toString() , duration:4,gravity: Toast.center );
    showDialog(context: ctx, builder: (ctxx)=>AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40)
      ),
      title: const Text('Warning', style: TextStyle(color:  Color.fromARGB(255, 252, 93, 93) , fontSize: 25), textAlign: TextAlign.center,),
      content: Text(er.toString()),
    ));
  }
   setState(() {
     isloading = false;
   });
 
}




}
