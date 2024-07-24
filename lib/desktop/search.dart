import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';
import 'homewidget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isload = false;
  bool islast = true;
  // String val = '' ;
  List<dynamic> li = [];
  List<dynamic> search = [];
  String _baseurl = '';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      setState(() {
        isload = true;
      });
      try {
        await Provider.of<Mypro>(context, listen: false).getlastsearch();
        li = Provider.of<Mypro>(context, listen: false).lastsearch;
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
        isload = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: SizedBox(
        width: MediaQuery.of(context).size.width * 0.18,
        child: TextFormField(
          decoration: InputDecoration(
              labelText: ' Search ',
              labelStyle: TextStyle(
                  color: const Color.fromARGB(184, 1, 51, 145).withOpacity(0.5),
                  fontSize: 18),
              prefixIcon: const Icon(Icons.search,
                  color: Color.fromARGB(184, 1, 51, 145)),
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(184, 1, 51, 145))),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(184, 1, 51, 145),
                  width: 1.4,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 30, 47, 233), width: 2.0),
                  borderRadius: BorderRadius.circular(8.0))),
          onChanged: (value) async {
            setState(() {
              isload = true;
            });
            try {
              await Provider.of<Mypro>(context, listen: false).getsearch(value);
              setState(() {
                islast = false;
              });
              search = Provider.of<Mypro>(context, listen: false).searchlist;
            } catch (error) {
              showDialog(
                  context: context,
                  builder: (ctxx) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
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
          },
          keyboardType: TextInputType.number,
        ),
      ),
      content: isload == false? Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.3,
              child: islast == true? Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child:!li.isEmpty? ListView.builder(
                          itemCount: li.length,
                          itemBuilder: (ctx, ind) => Container(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          showDialog(
                                              context: context,
                                              builder: (ctx) => Meddetails(
                                                  '${li[ind]['id']}?in_search=true'));
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.lock_clock,
                                              size: 20,
                                              color: Color.fromARGB(
                                                  255, 1, 43, 121),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(
                                              li[ind]['commercial_name'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      185, 3, 168, 244),
                                                  fontFamily:
                                                      'RobotoCondensed'),
                                            ),
                                            const Spacer(),
                                            TextButton(
                                              onPressed: () async {
                                                setState(() {
                                                  isload = true;
                                                });
                                                try {
                                                  await Provider.of<Mypro>(context,listen: false).deletlastsearch((li[ind]['id']).toString());
                                                  await Provider.of<Mypro>(context,listen: false).getlastsearch();
                                                  li = Provider.of<Mypro>(context,listen: false).lastsearch;
                                                } catch (error) {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (ctxx) => AlertDialog(
                                                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(40)),
                                                                title:const Text('Warning',style: TextStyle(
                                                                      color: Color.fromARGB(255,252,93,93),
                                                                      fontSize:25),
                                                                  textAlign:TextAlign.center,
                                                                ),
                                                                content: Text(error.toString()),
                                                              ));
                                                }
                                                setState(() {
                                                  isload = false;
                                                });
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                size: 20,
                                                color: Color.fromARGB(
                                                    255, 230, 108, 99),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.black38,
                                    ),
                                  ],
                                ),
                              )):Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 240,
                                      height: 180,
                                      child: Image.asset('assets/images/love.jpg', fit: BoxFit.cover,),
                                    ),
                                    const SizedBox(height: 10,),
                                    const Text('No Item yet')
                                  ],
                                ),
                              ),
                    )
                  : Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child:search.isNotEmpty? ListView.builder(
                          itemCount: search.length,
                          itemBuilder: (ctx, ind) => Container(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          showDialog(
                                              context: context,
                                              builder: (ctx) => Meddetails(
                                                  '${search[ind]['id']}?in_search=true'));
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: search[ind]['photo'] ==
                                                      'no_photo'
                                                  ? Image.asset(
                                                      'assets/images/def.png',
                                                      fit: BoxFit.fitHeight,
                                                    )
                                                  : Image.network(
                                                      '${_baseurl}image?name=${search[ind]['photo']}',
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(
                                              search[ind]['commercial_name'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      185, 3, 168, 244),
                                                  fontFamily:
                                                      'RobotoCondensed'),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.black38,
                                    ),
                                  ],
                                ),
                              )):Center(
                                 child: Column(
                                  children: [
                                    SizedBox(
                                      width: 240,
                                      height: 180,
                                      child: Image.asset('assets/images/love.jpg', fit: BoxFit.cover,),
                                    ),
                                    const SizedBox(height: 10,),
                                    const Text('No thing')
                                  ],
                                ),
                              ),
                    ))
          : Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.3,
              child: const Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
    );
  }
}
