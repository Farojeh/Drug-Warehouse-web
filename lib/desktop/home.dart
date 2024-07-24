import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/Allorders.dart';
import 'package:flutter_web/desktop/addmedicen.dart';
import 'package:flutter_web/desktop/admain.dart';
import 'package:flutter_web/desktop/alladmin.dart';
import 'package:flutter_web/desktop/com.dart';
import 'package:flutter_web/desktop/companies.dart';
import 'package:flutter_web/desktop/homewidget.dart';
import 'package:flutter_web/desktop/info.dart';
import 'package:flutter_web/desktop/search.dart';
import 'package:flutter_web/desktop/orderdet.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
   int ind ;
   // ignore: use_key_in_widget_constructors
   Homepage(this.ind);
  static const homename = 'Home Page';

  @override
  State<Homepage> createState() => _HomepageState(ind);
}

class _HomepageState extends State<Homepage> {
   DateTime extime = DateTime(2022);
  String finishtime = '';
  int _ind;
  _HomepageState(this._ind);
  String _baseurl = '';
  var com = [];
  var lastmed = [];
  bool isloading = false;
  String idcompany = '0';
  List<dynamic> perm =[];
  bool issuper = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      setState(() {
        isloading = true;
      });
      try {
        await Provider.of<Mypro>(context, listen: false).getcompany();
        // ignore: use_build_context_synchronously
        com = Provider.of<Mypro>(context, listen: false).comapnies;
        await Provider.of<Mypro>(context, listen: false).getrecentmed();
        // ignore: use_build_context_synchronously
        lastmed = Provider.of<Mypro>(context, listen: false).lastmed;
        await Provider.of<Mypro>(context , listen: false).getper();
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
   //  index = widget.ind;
    List<Widget> body = [homepage(context), Orderdet(),
     Companies(idcompany), Admains()];
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(184, 14, 179, 255),
            Color.fromARGB(255, 162, 231, 255),
            Color.fromARGB(184, 12, 175, 251),
            Color.fromARGB(255, 162, 231, 255),
          ]),
        ),
        child: Row(
          children: [
            drawerside(context,perm),
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.only(right: 10, left: 10, top: 15),
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.82,
                child: Card(
                  color: Colors.white,
                  elevation: 20,
                  shadowColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: LayoutBuilder(
                    builder: (ctx, cont) => Container(
                      margin: const EdgeInsets.only(left: 15),
                      width: cont.maxWidth * 0.97,
                      height: MediaQuery.of(context).size.height,
                      child: body[_ind],//index
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget homepage(BuildContext context) {
    return isloading == false
        ? Column(
            children: [
              welcomcont(context),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.27,
                child: Column(
                  children: [
                    ListTile(
                      leading: SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          'assets/images/com.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: const Text('  Companies :',
                          style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 28,
                              color: Color.fromARGB(213, 1, 51, 145))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 30),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ...com.map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Card(
                                        shadowColor: const Color.fromARGB(237, 1, 51, 145).withOpacity(0.3),
                                        elevation: 6,
                                        child: InkWell(
                                          overlayColor:
                                              MaterialStateProperty.all(Colors.white.withOpacity(0)),
                                          onTap: () {
                                            setState(() {
                                              idcompany = e['id'].toString();
                                              _ind = 2;
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            height: 120,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                            child: Column(
                                              children: [
                                                const Spacer(),
                                                Container(
                                                  height: 75,
                                                  width: 90,
                                                  decoration:
                                                      const BoxDecoration(),
                                                  child: ClipRRect(
                                                    child: Image.network(
                                                      '${_baseurl}image?name=${e['icon']!}',
                                                      headers: const {"ngrok-skip-browser-warning": 'true',
                                                             'Accept':'application/json', },
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  e['name']!,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'RobotoCondensed',
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                                const Spacer()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    'assets/images/medlast.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text('Recently Add :',
                    style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 28,
                        color: Color.fromARGB(213, 1, 51, 145))),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.292,
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.only(left: 30),
                child: GridView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: lastmed
                      .map((e) => InkWell(
                            overlayColor: MaterialStateProperty.all(
                                Colors.white.withOpacity(0)),
                            onTap: () {
                              showDialog(
                                      context: context,
                                      builder: (ctx) =>Meddetails(e['id'].toString()))
                                  .then((value) {
                                if (value == true) {
                                  setState(() {
                                    _ind = 0;
                                  });
                                  Future.delayed(Duration.zero, () async {
                                    setState(() {
                                      isloading = true;
                                    });
                                    try {
                                      await Provider.of<Mypro>(context,listen: false).getcompany();
                                      // ignore: use_build_context_synchronously
                                      com = Provider.of<Mypro>(context,listen: false).comapnies;
                                      await Provider.of<Mypro>(context,listen: false).getrecentmed();
                                      // ignore: use_build_context_synchronously
                                      lastmed = Provider.of<Mypro>(context,listen: false).lastmed;
                                    } catch (error) {
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
                                              ));
                                    }
                                    setState(() {
                                      isloading = false;
                                    });
                                  });
                                }
                              });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: const Color.fromARGB(184, 132, 205, 239)
                                  .withOpacity(0.3),
                              elevation: 20,
                              shadowColor: Colors.black.withOpacity(0),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  medimage(e),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  meddetails(e),
                                  const Spacer(),
                                  const Spacer(),
                                  medprice(e),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          )
        : const Center(
            child: SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(),
            ),
          );
  }

  Container medprice(var e) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: 50,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromARGB(185, 3, 168, 244),
        ),
        child: Text(
          e['price'].toString(),
          style: const TextStyle(
              fontFamily: 'RobotoCondensed', fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Column meddetails(var e) {
    return Column(
      children: [
        const Spacer(),
        Text(
          e['commercial_name'].toString(),
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontFamily: 'RobotoCondensed', fontSize: 19, color: Colors.black),
        ),
        const Spacer(),
        Text(
          e['company']?['name'],
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 13,
              color: Color.fromARGB(255, 45, 45, 45)),
        ),
        const SizedBox(
          height: 5,
        ),
        const Spacer(),
      ],
    );
  }

  Container medimage(var e) {
    return Container(
      height: 60,
      width: 70,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: e['photo'] != 'no_photo'
              ? Image.network(
                  '${_baseurl}image?name=${e['photo']!}' ,
                   headers: const {"ngrok-skip-browser-warning": 'true',
                            'Accept':'application/json', },
                  fit: BoxFit.fitWidth,
                )
              : Image.asset(
                  'assets/images/def.png',
                  fit: BoxFit.fitHeight,
                )),
    );
  }

  Padding welcomcont(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              // Color.fromARGB(255, 179, 233, 252),
              Color.fromARGB(184, 76, 197, 252),
              Color.fromARGB(255, 162, 231, 255),
              Color.fromARGB(184, 76, 197, 252),
              Color.fromARGB(255, 162, 231, 255),
            ]),
            borderRadius:  BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, right: 5, left: 30, bottom: 10),
              height: 350 ,
              width: 100 ,
              child: Image.asset(
                'assets/images/nn.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, left:10 ),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome TO Pharmapal Dashboard',
                      style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: Color.fromARGB(207, 1, 58, 165),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: MediaQuery.of(context).size.width * 0.46,
                      child: const Text(
                        'Where you can manage all the links between the warehouse and pharmacies in terms of adding companies and medicines and admins easily and flexibly ',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 23,
                          fontWeight: FontWeight.w100,
                          color: Color.fromARGB(255, 44, 67, 111),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 5, bottom: 10),
              height: 400 ,
              width: MediaQuery.of(context).size.width * 0.22,
              child: Image.asset('assets/images/pp.png' , fit: BoxFit.fitHeight ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded drawerside(BuildContext context,List<dynamic> perm ) {
    return Expanded(
        flex: 1,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 64,
                    height: 70,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 140,
                    child: Text(
                      'MedHouse website',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'RobotoCondensed',
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                child: const Divider(
                  thickness: 1.1,
                  color: Color.fromARGB(88, 39, 3, 47),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                setState(() {
                  _ind = 0;
                });
                Future.delayed(Duration.zero, () async {
                  setState(() {
                    isloading = true;
                  });
                  await Provider.of<Mypro>(context, listen: false).getcompany();
                  // ignore: use_build_context_synchronously
                  com = Provider.of<Mypro>(context, listen: false).comapnies;
                  // ignore: use_build_context_synchronously
                  await Provider.of<Mypro>(context, listen: false).getrecentmed();
                  // ignore: use_build_context_synchronously
                  lastmed = Provider.of<Mypro>(context, listen: false).lastmed;
                  setState(() {
                    isloading = false;
                  });
                });
              },
              title: const Text('Home Page',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(255, 1, 43, 121))),
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: ()async {     
                 try{
                  setState(() {
                    isloading = true;
                  });
                  await Provider.of<Mypro>(context , listen: false).getsuper();
                  // ignore: use_build_context_synchronously
                  issuper = Provider.of<Mypro>(context , listen: false).issuper;
                  setState(() {
                    isloading = false;
                  });
                  // ignore: use_build_context_synchronously
                  if(issuper==true){  showDialog(context: context, builder: (ctx) => const Alladmins());
                  }else{
                     // ignore: use_build_context_synchronously
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
                  content: const Text('You Are not a Super Admin'),
                ));
                  }
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
              title: const Text('All Admins',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(255, 1, 43, 121))),
              leading: const Icon(
                Icons.admin_panel_settings_outlined,
                color: Colors.white,
              ),
            ),
            ListTile(
             onTap: () {
               if(perm.any((element) => element['id']==5)){
                 setState(() {
                  _ind = 3;
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
              title: const Text('Add Admins',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(255, 1, 43, 121))),
              leading: const Icon(
                Icons.person_add_alt_1_rounded,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
               if(perm.any((element) => element['id']==6)){
                   showDialog(
                        context: context,
                        builder: (ctx) => const Addmed(),
                        barrierDismissible: false)
                    .then((value) {
                  setState(() {
                    _ind = 0;
                  });
                 if(value == true){
                   Future.delayed(Duration.zero, () async {
                    setState(() {
                      isloading = true;
                    });
                    await Provider.of<Mypro>(context, listen: false).getcompany();
                    // ignore: use_build_context_synchronously
                    com = Provider.of<Mypro>(context, listen: false).comapnies;
                    // ignore: use_build_context_synchronously
                    await Provider.of<Mypro>(context, listen: false).getrecentmed();
                    // ignore: use_build_context_synchronously
                    lastmed =Provider.of<Mypro>(context, listen: false).lastmed;
                    setState(() {
                      isloading = false;
                    });
                  });
                 }
                });
               }else{}
              },
              title: const Text('Add Medicen',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(255, 1, 43, 121))),
              leading: const Icon(
                Icons.medication_liquid_rounded,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
               if(perm.any((element) => element['id']==2)){
                  showDialog(
                    context: context,
                    builder: (ctx) => const ADDcompany(),
                    barrierDismissible: false) .then((value) {
                  setState(() {
                    _ind = 0;
                  });
                 if(value == true){
                   Future.delayed(Duration.zero, () async {
                    setState(() {
                      isloading = true;
                    });
                    await Provider.of<Mypro>(context, listen: false).getcompany();
                    // ignore: use_build_context_synchronously
                    com = Provider.of<Mypro>(context, listen: false).comapnies;
                    // ignore: use_build_context_synchronously
                    await Provider.of<Mypro>(context, listen: false).getrecentmed();
                    // ignore: use_build_context_synchronously
                    lastmed =Provider.of<Mypro>(context, listen: false).lastmed;
                    setState(() {
                      isloading = false;
                    });
                  });
                 }
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
              title: const Text('Add Company',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(255, 1, 43, 121))),
              leading: const Icon(
                Icons.add_business_sharp,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () async{
              //   try{
              //  //  await Provider.of<Mypro>(context , listen: false).get
              //   }catch(error){}
                showDialog(context: context, builder: (_) => ALLOrder()).then((value) {
                  if(value == true){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Homepage(1)));
                  }
                });
              },
              title: const Text('The Orders',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(255, 1, 43, 121))),
              leading: const Icon(
                Icons.shopping_cart_sharp,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (innerctx) => const Search());
              },
              title: const Text('Search',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(255, 1, 43, 121))),
              leading: const Icon(
                Icons.search_rounded,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(context: context, builder: (ctx) => Info());
              },
              title: const Text('Information',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(255, 1, 43, 121))),
              leading: const Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime.now(),
                          ).then((value)async {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              isloading = true ;
                              extime = value;
                              finishtime = '${extime.year.toString()}-${extime.month.toString()}-${extime.day.toString()}';
                            });
                            try{
                              await Provider.of<Mypro>(context , listen: false).postReport(finishtime);
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

                          });
              },
              title: const Text('Report',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed',
                      color: Color.fromARGB(255, 1, 43, 121))),
              leading: const Icon(
                Icons.picture_as_pdf,
                color: Colors.white,
              ),
            ),          
          ],
        ));
  }

}
