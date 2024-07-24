import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_web/desktop/provider.dart';
import 'package:provider/provider.dart';

class Info extends StatefulWidget {
  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  List<dynamic> week = [20 , 20 , 20 , 20 , 20 , 20 , 20];
  double to = 0;
  double mo = 0;
  int user = 0, admin = 0;
  bool isloading = false;
    void initState()  {
    super.initState();
    Future.delayed(Duration.zero , ()async{
      setState(() {
      isloading = true;
    });
   try{
      await Provider.of<Mypro>(context , listen: false).gettoday();
    // ignore: use_build_context_synchronously
    to = Provider.of<Mypro>(context , listen: false).today;
    await Provider.of<Mypro>(context , listen: false).getweek();
    // ignore: use_build_context_synchronously
    week = Provider.of<Mypro>(context , listen: false).week;
    await Provider.of<Mypro>(context , listen: false).getmonth();
    // ignore: use_build_context_synchronously
    mo = Provider.of<Mypro>(context , listen: false).month;

    await Provider.of<Mypro>(context , listen: false).getuser();
    // ignore: use_build_context_synchronously
    user = Provider.of<Mypro>(context , listen: false).users;

    await Provider.of<Mypro>(context , listen: false).getadmin();
    // ignore: use_build_context_synchronously
    admin = Provider.of<Mypro>(context , listen: false).admins;
   }catch(errore){
      showDialog(context: context, builder: (ctxx)=>AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40)
      ),
      title: const Text('Warning', style: TextStyle(color:  Color.fromARGB(255, 252, 93, 93) , fontSize: 25), textAlign: TextAlign.center,),
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
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.38,
        height: MediaQuery.of(context).size.height * 0.79,
        color: Colors.white,
        child: isloading==false? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.37,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(185, 3, 168, 244).withOpacity(0.3),
              ),
              child:  ListTile(
                title: Text(
                  ' The Sales For Today is ' + '$to',
                  style: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
                ),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromARGB(184, 1, 51, 145),
                  child: Icon(
                    Icons.today_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Padding(
              padding:  EdgeInsets.only(top: 16, left: 10),
              child: Text(
                'The Sales For this week :',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'RobotoCondensed',
                  color: Color.fromARGB(239, 1, 51, 145),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20 , right: 30),
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.38,
              //color: Colors.pink,
              child: BarChart(BarChartData(
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: gettitel
                    )
                  )
                ),
                maxY: 100,
                minY: 0,
                barGroups: [
                  BarChartGroupData(x: 0 ,
                   barRods: [BarChartRodData(toY: week[0],
                  width: 15,
                  color:const Color.fromARGB(237, 1, 51, 145),
                  borderRadius: BorderRadius.circular(0)
                  )]),
                  BarChartGroupData(x: 1 , barRods: [BarChartRodData(toY: week[1],
                  width: 15,
                  color:const Color.fromARGB(229, 14, 179, 255),
                  borderRadius: BorderRadius.circular(0)
                  )]),
                  BarChartGroupData(x: 2 , barRods: [BarChartRodData(toY: week[2],
                  width: 15,
                  color:const Color.fromARGB(237, 1, 51, 145),
                  borderRadius: BorderRadius.circular(0)
                  )]),
                  BarChartGroupData(x: 3 , barRods: [BarChartRodData(toY: week[3],
                  width: 15,
                  color: const Color.fromARGB(229, 14, 179, 255),
                  borderRadius: BorderRadius.circular(0)
                  )]),
                  BarChartGroupData(x: 4 , barRods: [BarChartRodData(toY: week[4],
                  width: 15,
                  color:const Color.fromARGB(237, 1, 51, 145),
                  borderRadius: BorderRadius.circular(0)
                  )]),
                  BarChartGroupData(x: 5 , barRods: [BarChartRodData(toY: week[5],
                  width: 15,
                  color:  const Color.fromARGB(229, 14, 179, 255),
                  borderRadius: BorderRadius.circular(0)
                  )]),
                  BarChartGroupData(x: 6 , barRods: [BarChartRodData(toY: week[6],
                  width: 15,
                  color:const Color.fromARGB(237, 1, 51, 145),
                  borderRadius: BorderRadius.circular(0)
                  )]),
                ]
              ))
            ),
             Container(
              margin: const EdgeInsets.only(top: 7),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.37,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(185, 3, 168, 244).withOpacity(0.3),
              ),
              child:  ListTile(
                title: Text(
                  'The Sales For this Month $mo' ,
                  style: const TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
                ),
                leading: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromARGB(184, 1, 51, 145),
                  child: Icon(
                    Icons.date_range_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               const SizedBox(width: 5,),
                             Container(
              margin: const EdgeInsets.only(top: 7),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.175,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(185, 3, 168, 244).withOpacity(0.3),
              ),
              child:  ListTile(
                title: Text(
                  'Number Of Admins is  $admin',
                  style: const TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
                ),
                leading: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromARGB(184, 1, 51, 145),
                  child: Icon(
                    Icons.admin_panel_settings_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 18,),
                         Container(
              margin: const EdgeInsets.only(top: 7 , ),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.175,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(185, 3, 168, 244).withOpacity(0.3),
              ),
              child:  ListTile(
                title: Text(
                  'Number Of Users is  $user ',
                  style: const TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
                ),
                leading: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromARGB(184, 1, 51, 145),
                  child: Icon(
                  Icons.groups,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
           const SizedBox(width: 5,),
              ],
            )
          ],
        ):const Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

    Widget gettitel (double value , TitleMeta meta){
      const st = TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
        fontSize: 14 
      );
      
      Widget text ;
      switch(value.toInt()){
        case 0 :
       text = const Text('Sun' , style: st,);
        break;
        case 1 :
       text = const Text('Mon' , style: st,);
        break;
        case 2 :
       text = const Text('tus' , style: st,);
        break;
        case 3 :
       text = const Text('Wed' , style: st,);
        break;
        case 4 :
       text = const Text('Thu' , style: st,);
        break;
        case 5 :
       text = const Text('Fri' , style: st,);
        break;
        case 6 :
       text = const Text('Sat' , style: st,);
        break;
        default:
       text = const Text('' , style: st,);
        break;        
      }
     return  SideTitleWidget(axisSide: meta.axisSide, child: text);
    }
}
