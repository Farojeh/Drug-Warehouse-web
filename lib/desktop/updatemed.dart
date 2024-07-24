import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Updatemed extends StatefulWidget {
  String id;
  // ignore: use_key_in_widget_constructors
  Updatemed(this.id);
  @override
  State<Updatemed> createState() => _UpdatemedState();
}

class _UpdatemedState extends State<Updatemed> {
  Map<String, dynamic> _showpro = {};

  bool isloading = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      setState(() {
        isloading = true;
      });
      try {
        await Provider.of<Mypro>(context, listen: false).getshowmed(widget.id);
        _showpro = Provider.of<Mypro>(context, listen: false).showpro;
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
    //  print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    String comname = '';
    String sinname = '';
    String price = '';
    String des = '';
    final GlobalKey<FormState> _formkey = GlobalKey();
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.98,
        color: Colors.white,
        child: Form(
          key: _formkey,
          child: isloading == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          margin: EdgeInsets.only(right: 17),
                          child: Image.asset(
                            'assets/images/med.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Text(
                          'Update Medicine : ',
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
                              style: TextStyle(
                                fontSize: 30,
                                color: Color.fromARGB(255, 1, 43, 121),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
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
                                              color:
                                                  Colors.grey.withOpacity(0.2)),
                                          child: const Icon(
                                            Icons.add,
                                            color: Color.fromARGB(
                                                255, 0, 118, 173),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            height: 200,
                            width: 300,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 25),
                                  height: 60,
                                  width: 280,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText:
                                            '${_showpro['product']?['commercial_name']}',
                                        hintStyle: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'RobotoCondensed',
                                            color:
                                                Color.fromARGB(255, 1, 43, 121)
                                                    .withOpacity(0.6)),
                                        labelText: ' Commercial Name ',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                    219, 14, 179, 255)
                                                .withOpacity(0.6),
                                            fontSize: 18),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 1, 43, 121),
                                        )),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 1, 43, 121),
                                            width: 1.4,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 1, 43, 121),
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0))),
                                    validator: (val) {
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      if (newValue == null ||newValue.isEmpty) {comname ='${_showpro['product']?['commercial_name']}';
                                      } else {
                                        comname = newValue;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: 60,
                                  width: 280,
                                  //  color: Colors.blue,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText:
                                            '(${_showpro['product']?['scientific_name']} )',
                                        hintStyle: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'RobotoCondensed',
                                            color:
                                                Color.fromARGB(255, 1, 43, 121)
                                                    .withOpacity(0.6)),
                                        labelText: ' scientific Name ',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                    219, 14, 179, 255)
                                                .withOpacity(0.6),
                                            fontSize: 18),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 1, 43, 121),
                                        )),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 1, 43, 121),
                                            width: 1.4,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 1, 43, 121),
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0))),
                                    validator: (val) {
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      if (newValue == null ||
                                          newValue.isEmpty) {
                                        sinname = _showpro['product']
                                            ?['scientific_name'];
                                      } else {
                                        sinname = newValue;
                                      }
                                    },
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 15,
                        child: const DottedLine(
                          lineThickness: 2,
                          direction: Axis.horizontal,
                          dashLength: 10,
                          lineLength: double.infinity,
                          dashColor: Color.fromARGB(255, 1, 43, 121),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          InkWell(
                            onTap: () {
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
                                        content: Text(" You Can't Edit this"),
                                      ));
                            },
                            child: SizedBox(
                                height: 60,
                                width: 160,
                                child: Card(
                                  shadowColor:
                                      Color.fromARGB(184, 14, 179, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  elevation: 4,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: 25,
                                          child: Image.asset(
                                            'assets/images/addcom.png',
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Company',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'RobotoCondensed',
                                            color:
                                                Color.fromARGB(255, 1, 43, 121),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
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
                                        content: Text(" You Can't Edit this"),
                                      ));
                            },
                            child: SizedBox(
                                height: 70,
                                width: 160,
                                child: Card(
                                  shadowColor:
                                      Color.fromARGB(184, 14, 179, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  // color:Color.fromARGB(255, 245, 252, 255) ,
                                  elevation: 4,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                            'assets/images/error.png',
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 70,
                                          width: 80,
                                          child: const Text(
                                            'Expiration date',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'RobotoCondensed',
                                              color: Color.fromARGB(
                                                  255, 1, 43, 121),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
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
                                        content: Text(" You Can't Edit this"),
                                      ));
                            },
                            child: SizedBox(
                                height: 60,
                                width: 160,
                                child: Card(
                                  shadowColor:
                                      Color.fromARGB(184, 14, 179, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  // color:Color.fromARGB(255, 245, 252, 255) ,
                                  elevation: 4,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 25,
                                          width: 22,
                                          child: Image.asset(
                                            'assets/images/addcat.png',
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Category',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'RobotoCondensed',
                                            color:
                                                Color.fromARGB(255, 1, 43, 121),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 30,
                            color: Color.fromARGB(255, 1, 43, 121),
                          ),
                          const Text(
                            '  Stock :',
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 30,
                              color: Color.fromARGB(219, 14, 179, 255),
                            ),
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                          Container(
                            height: 40,
                            width: 160,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 1, 43, 121),
                                    width: 1.2),
                                borderRadius: BorderRadius.circular(40)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 25,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          219, 14, 179, 255),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          // stock = stock + 1;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                ),
                                Text(
                                  '${(_showpro['product']?['quantity']).toString()}',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.black),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 25,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          219, 14, 179, 255),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          //   stock = stock - 1;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.price_change_outlined,
                            size: 30,
                            color: Color.fromARGB(255, 1, 43, 121),
                          ),
                          const Text(
                            '  Price :',
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 30,
                              color: Color.fromARGB(219, 14, 179, 255),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 35,
                            width: 150,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: (_showpro['product']?['price'])
                                      .toString(),
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(255, 63, 63, 63),
                                      fontSize: 15),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color.fromARGB(255, 1, 43, 121),
                                  )),
                                  border: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                              validator: (val) {
                                return null;
                              },
                              onSaved: (newValue) {
                                if (newValue == null || newValue.isEmpty) {
                                  price = (_showpro['product']?['price'])
                                      .toString();
                                } else {
                                  price = newValue;
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                                  Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.description_outlined,
                      size: 30,
                      color: Color.fromARGB(255, 1, 43, 121),
                    ),
                    const Text(
                      '  Description :',
                      style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 30,
                        color: Color.fromARGB(219, 14, 179, 255),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 60,
                      width: 270,
                      child:TextFormField(
                        maxLines: 6,
                        minLines: 2,
                         keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText:  '${_showpro['product']?['description']}',
                                  labelText: ' Add Some Description ',
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
                                return null;
                              },
                              onSaved: (newValue) {
                                 if (newValue == null || newValue.isEmpty) {
                                  des = (_showpro['product']?['description'])
                                      .toString();
                                } else {
                                  des = newValue;
                                }
                              },
                             
                            ),
                    )
                  ],
                ),
              ),
                                     
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 35),
                      child: Row(
                        children: [
                          Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              if (!_formkey.currentState!.validate()) {
                                return;
                              }
                              _formkey.currentState?.save();
                              setState(() {
                                isloading = true;
                              });
                              try {
                                print(comname);
                                Provider.of<Mypro>(context, listen: false).setupdatemedecien(comname, sinname, des, price);
                                await Provider.of<Mypro>(context, listen: false).getupdatemedicen(widget.id);
                                Navigator.of(context).pop(true);
                              } catch (errore) {
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
                                          content: Text(errore.toString()),
                                        ));
                              }
                              setState(() {
                                isloading = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 162, 231, 255),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
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
                )
              : const Center(
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }
}
