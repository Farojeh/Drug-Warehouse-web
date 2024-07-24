import 'package:flutter/material.dart';
import 'package:flutter_web/data.dart';
import 'package:flutter_web/desktop/home.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:flutter_web/desktop/updatecom.dart';
import 'package:provider/provider.dart';
import 'homewidget.dart';

// ignore: must_be_immutable
class Companies extends StatefulWidget {
  String id;
  // ignore: use_key_in_widget_constructors
  Companies(this.id);

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  var companycat = [];
  bool isload = false;
  bool isfirstload = false;
  List<dynamic> perm =[];
  String _baseurl = '';
  Map<String, dynamic> _showcom = {};
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        setState(() {
          isfirstload = true;
        });
        await Provider.of<Mypro>(context, listen: false).getcomcat(widget.id, '1');
        companycat = Provider.of<Mypro>(context, listen: false).comcat;
        perm = Provider.of<Mypro>(context , listen: false).permissions;
        _baseurl = Provider.of<Mypro>(context , listen: false).baseurl;
          await Provider.of<Mypro>(context, listen: false).getshowcom(widget.id);
        _showcom = Provider.of<Mypro>(context, listen: false).showcom;
      } catch (error) {
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
        isfirstload = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isfirstload==false?  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50, top: 10),
          child:Row(
            children: [
              SizedBox(
                width: 70,
                height: 60,
                child:_showcom['icon']==null?Container() :Image.network(
                              '${_baseurl}image?name=${_showcom['icon']}',
                                headers: const {"ngrok-skip-browser-warning": 'true',
                                         'Accept':'application/json', },
                            fit: BoxFit.fitWidth,
                            )
              ),
               Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text('${_showcom['name']}',
                  style:const TextStyle(
                      color:  Color.fromARGB(255, 1, 51, 145),
                      fontSize: 30,
                      fontFamily: 'RobotoCondensed'),
                ),
              ),
             const Spacer(),
              ElevatedButton(
                onPressed: () async {
                 if(perm.any((element) => element['id']==3)){
                     showDialog(context: context, builder: (_)=>Updatecompany(widget.id)).then((value)async {
                    if(value == true){
                       
                        try{
                           setState(() {
                          isload = true;
                        });
                           await Provider.of<Mypro>(context, listen: false).getshowcom(widget.id);
                          _showcom = Provider.of<Mypro>(context, listen: false).showcom;
                        }catch(error){
                            showDialog(
                       context: context,
                       builder: (ctxx) => AlertDialog(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  title: const Text('Warning',style: TextStyle(
                        color: Color.fromARGB(255, 252, 93, 93), fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  content: Text(error.toString()),
                ));

                        }
                        setState(() {
                          isload = false;
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
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Color.fromARGB(255, 162, 231, 255),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Color.fromARGB(255, 1, 43, 121),
                      fontSize: 25,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 30,),
              ElevatedButton(
                onPressed: ()async {
                  if(perm.any((element) => element['id']==1)){
                    setState(() {
                    isload = true ;
                  });
                  try{
                    await Provider.of<Mypro>(context , listen: false).deletecompany(widget.id);
                     Navigator.of(context).pop();
                     Navigator.of(context).pushNamed(Homepage.homename);

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
                    isload = false;
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
                  backgroundColor: Color.fromARGB(255, 162, 231, 255),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Color.fromARGB(255, 1, 43, 121),
                      fontSize: 25,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
              ),
             const SizedBox(width: 60,)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
          child: Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5, left: 15, right: 15, bottom: 5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...cat.map((e) => Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: InkWell(
                                      onTap: () async {
                                        int index = cat.indexOf(e);
                                        Provider.of<Mypro>(context,listen: false).changeind(index);
                                        setState(() {
                                          isload = true;
                                        });
                                        try {
                                          setState(() {
                                            isload = true;
                                          });
                                          await Provider.of<Mypro>(context,listen: false).getcomcat(widget.id, (cat[Provider.of<Mypro>(context , listen: false).indmed]['id']).toString());
                                          companycat = Provider.of<Mypro>(context,listen: false).comcat;
                                        } catch (error) {
                                          showDialog(
                                              context: context,
                                              builder: (ctxx) => AlertDialog(shape:RoundedRectangleBorder(
                                                            borderRadius:BorderRadius.circular(40)),
                                                    title: const Text('Warning',style: TextStyle(
                                                          color: Color.fromARGB(255, 252, 93, 93),fontSize: 25),
                                                      textAlign:TextAlign.center,),
                                                    content:Text(error.toString()),));
                                        }
                                        setState(() {
                                          isload = false;
                                        });
                                      },
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.white.withOpacity(0.0)),
                                      child: Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 1, 51, 145),
                                              width: 1.2),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              height: 70,
                                              width: 90,
                                              child: Image.asset(
                                                e['image']!,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              e['name']!,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'RobotoCondensed',
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 20),
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.4,
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              child: Image.asset(
                cat[Provider.of<Mypro>(context).indmed]['image']!,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              cat[Provider.of<Mypro>(context).indmed]['name']!,
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'RobotoCondensed',
                  color: Colors.black),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 3, left: 50),
          height: MediaQuery.of(context).size.height * 0.49,
          width: MediaQuery.of(context).size.width * 0.7,
          child: isload == false? SizedBox(
            child:companycat.isNotEmpty? GridView(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          MediaQuery.of(context).size.width * 0.24,
                      childAspectRatio: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                    ),
                    children: companycat.map((e) => InkWell(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.white.withOpacity(0)),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) =>Meddetails(e['id'].toString())).then((value){
                                      if(value == true){
                                        Future.delayed(Duration.zero , ()async{
                                          setState(() {
                                      isload = true;
                                    });
                                    try{
                                       await Provider.of<Mypro>(context, listen: false).getcomcat(widget.id,(cat[Provider.of<Mypro>(context , listen: false).indmed]['id']).toString());
                                       companycat = Provider.of<Mypro>(context, listen: false).comcat;
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
                                              ));
                                    }
                                     setState(() {
                                      isload = false;
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
                  ):Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 250,
                          height: 220,
                          child: Image.asset('assets/images/love.jpg', fit: BoxFit.fitWidth,),
                        ),
                        Text('No Item In This Category'),
                      ],
                    ),
                  ),
          )
              : const Center(
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(),
                  ),
                ),
        )
      ],
    ): const Center(
      child: SizedBox(
        width: 70,
        height: 70,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Container medprice(Map<String, dynamic> e) {
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

  Column meddetails(Map<String, dynamic> e) {
    return Column(
      children: [
        const Spacer(),
        Text(
          e['commercial_name']!,
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
              fontSize: 16,
              color: Color.fromARGB(255, 45, 45, 45)),
        ),
        const SizedBox(
          height: 5,
        ),
        const Spacer(),
      ],
    );
  }

  Container medimage(Map<String, dynamic> e) {
    return Container(
      height: 75,
      width: 90,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: e['photo'] != 'no_photo'
              ? Image.network(
                  '${_baseurl}image?name=${e['photo']!}' ,
                    headers: const {"ngrok-skip-browser-warning": 'true',
                            'Accept':'application/json', },
                  // '${url}api/image?name=${e['photo']!}',
                  fit: BoxFit.fitWidth,
                )
              : Image.asset(
                  'assets/images/def.png',
                  fit: BoxFit.fitHeight,
                )),
    );
  }
}
