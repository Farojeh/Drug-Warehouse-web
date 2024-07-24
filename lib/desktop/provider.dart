// ignore_for_file: unnecessary_new
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web/desktop/model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class Mypro with ChangeNotifier{
  Map<String , String> userreg = {
    'phone_number': '',
    'password': '',
    'c_password':'',
    'name': '',
  };

  Map<String , String> userlog ={
    'phone_number': '',
    'password': '',
  };

  Map<String , String> userinfo = {
    'id':'',
    'name':'',
    'phone_number':'',
    'token':'',
  };
   

  List<dynamic> comapnies = [];
  List<dynamic> lastmed = [];
  double today = 0;
  double month = 0;
  int users = 0 ;
  int admins = 0;
  List<dynamic> week = [];
  Map<String , dynamic> showpro ={};
  Map<String , dynamic> showcom ={};
  

  List<dynamic> searchlist = [];
  List<dynamic> lastsearch = [];

  List<dynamic> comcat = [];

  List<dynamic> permissions = [];

 List<dynamic> Orders = [];

  List<dynamic> sporder = [];

  List<dynamic> alladmins = [];

  bool issuper = false;

  Map<String , String> jsonadmin = {
    "phone_number":"",
    "permissions[0]":'',
    "permissions[1]":'',
    "permissions[2]":'',
    "permissions[3]":'',
    "permissions[4]":'',
    "permissions[5]":'',
    "permissions[6]":'',
    "permissions[7]":'',
    "permissions[8]":'',
  };

  Admin admin =Admin(0, []);

  Map <String , String> medecin ={
    'scientific_name':'',
    'commercial_name':'',
    'description':'',
    'quantity':'',
    'price':'',
    'expiration_date':'',
    'classification_id':'',
    'company_id':'',
    'is_otc':''
  };

   Map <String , String> company ={
    'name':''
  };

   Map <String , String> updatemedecin ={
    'scientific_name':'',
    'commercial_name':'',
    'description':'',
    'price':'',
  };

  Map <String , String> updatecompany ={
    'name':'',
    '_method':'PUT'
  };

   void setadmin(String phone , List<int> perr){
    jsonadmin['phone_number']= phone;
    jsonadmin['permissions[0]']=perr[0].toString();
    jsonadmin['permissions[1]']=perr[1].toString();
    jsonadmin['permissions[2]']=perr[2].toString();
    jsonadmin['permissions[3]']=perr[3].toString();
    jsonadmin['permissions[4]']=perr[4].toString();
    jsonadmin['permissions[5]']=perr[5].toString();
    jsonadmin['permissions[6]']=perr[6].toString();
    jsonadmin['permissions[7]']=perr[7].toString();

   }

  void setmapmedecien(String comname ,String sinname ,String des , int price ,  int stock , String extime ,int catid , int comid , String isotc){
    medecin['scientific_name'] = sinname ;
    medecin['commercial_name'] = comname ;
    medecin['description'] = des ;
    medecin['quantity'] = stock.toString() ;
    medecin['price'] = price.toString() ;
    medecin['expiration_date'] = extime;
    medecin['classification_id'] = catid.toString() ;
    medecin['company_id'] = comid.toString();
    medecin['is_otc']= isotc;
  }

  void setmapcompany(String name){
    company['name'] = name;
  }

  void setupdatemedecien(String comname ,String sinname ,String des , String price ){
    updatemedecin['scientific_name'] = sinname ;
    updatemedecin['commercial_name'] = comname ;
    updatemedecin['description'] = des ;
    updatemedecin['price'] = price.toString() ;
  }

  void setupdatecompany(String name ){
    updatecompany['name'] = name ;
  }
    
    void setmap(Map user){
      userreg['phone_number']=user['phone_number'];
      userreg['password']=user['password'];
      userreg['name']=user['name'];
      userreg['c_password']=user['password'];
      notifyListeners();
    }

     void setmaplog(Map user){
      userlog['phone_number']=user['phone_number'];
      userlog['password']=user['password'];
      notifyListeners();
    }



    String baseurl = 'https://3217-5-0-169-77.ngrok-free.app/api/';
  
  Future setregister ()async{
    final String url = '${baseurl}admin/register';
    try{
     final res = await http.post(Uri.parse(url) ,
     headers: {'Accept':'application/json'},
     body: userreg
     );
     final resdata = json.decode(res.body);
      if(resdata['success']== true){
       userinfo['id'] = resdata['data']['id'].toString();
       userinfo['name']=resdata['data']['name'];
       userinfo['phone_number']=resdata['data']['phone_number'];
       userinfo['token']=resdata['data']['token'];
      }
     else{
      throw '${resdata['message']}';
     }
    }catch(errore){
      rethrow ;
    }

  }

   Future getsearch (String searchword)async{
    final String url = '${baseurl}products';
    try{
     final res = await http.post(Uri.parse(url) ,
     headers: {'Accept':'application/json',
       'Authorization': 'Bearer ${userinfo['token']}',
     },
     body: {'search_word':searchword}
     );
     final resdata = json.decode(res.body);
      if(resdata['success']== true){
         searchlist = resdata['data']['data'] as List<dynamic>;
      }
     else{
      throw '${resdata['message']}';
     }
    }catch(errore){
      rethrow ;
    }

  }


  Future<void> postReport(String date) async {
    final String url = '${baseurl}admin-report';
    try {
      await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer ${userinfo['token']}',
      }, body: {
        'date': date,
      });
    } catch (errore) {
      throw '$errore';
    }
  }



  Future newadmin ( )async{
    final String url = '${baseurl}admin/add';
    try{
     final res = await http.post(Uri.parse(url) ,
     headers: {
      "Accept":"application/json",
       "Authorization": "Bearer ${userinfo['token']}",
     },
     body:jsonadmin
     );
     final resdata = json.decode(res.body);
     if(res.statusCode == 422){
      throw resdata['message'];
     }
      if(resdata['success']== false || res.statusCode == 400){
         throw resdata['message'];     
      }
      else if (res.statusCode == 500){
        throw 'NO Internet , Please Try Again';
      }
    }catch(errore){
      rethrow ;
    }

  }


  Future getlastsearch ()async{
    final String url = '${baseurl}search/products';
    try{
     final res = await http.get(Uri.parse(url) ,
     headers: {'Accept':'application/json',
     "ngrok-skip-browser-warning": 'true',
       'Authorization': 'Bearer ${userinfo['token']}',
     },
     );
     final resdata = json.decode(res.body);
      if(resdata['success']== true ){
        lastsearch = [];
        if(resdata['data']!=null){ lastsearch = resdata['data'] as List<dynamic>;}
        
      }
     else{
      throw '${resdata['message']}';
     }
    }catch(errore){
      rethrow ;
    }

  }

 Future getorders ()async{
    final String url = '${baseurl}carts/all-carts';
    try{
     final res = await http.get(Uri.parse(url) ,
     headers: {'Accept':'application/json',
     "ngrok-skip-browser-warning": 'true',
       'Authorization': 'Bearer ${userinfo['token']}',
     },
     );
     final resdata = json.decode(res.body);
      if(resdata['success']== true ){
         Orders = resdata['data'] as List<dynamic>;
      }
      else if(resdata['success']== false){
           Orders=[];
      }
     else{
      throw '${resdata['message']}';
     }
    }catch(errore){
      rethrow ;
    }

  }

  Future deletlastsearch (String id)async{
    final String url = '${baseurl}search/delete/$id';
    try{
     final res = await http.get(Uri.parse(url),
     headers: {'Accept':'application/json',
     "ngrok-skip-browser-warning": 'true',
       'Authorization': 'Bearer ${userinfo['token']}',
     },
     );
     final resdata = json.decode(res.body);
      if(resdata['success']== true ){}
     else{
      throw '${resdata['message']}';
     }
    }catch(errore){
      rethrow ;
    }

  }

 Future deletadmin (String phone)async{
    final String url = '${baseurl}admin/delete?phone_number';
    try{
     final res = await http.post(Uri.parse(url),
     headers: {'Accept':'application/json',
       'Authorization': 'Bearer ${userinfo['token']}',
     },
     body: {
      'phone_number':phone
     }
     );
     final resdata = json.decode(res.body);
      if(resdata['success']== true ){}
     else{
      throw '${resdata['message']}';
     }
    }catch(errore){
      rethrow ;
    }

  }


  Future setlogin()async{
    final String url = '${baseurl}admin/login';
    try{
     final res = await http.post(Uri.parse(url) ,
     headers: {
      "ngrok-skip-browser-warning": 'true',
      'Accept':'application/json',
     },
     body: userlog
     );
   
     final resdata = json.decode(res.body);
      if(resdata['success']== true){
       userinfo['id'] = resdata['data']['id'].toString();
       userinfo['name']=resdata['data']['name'];
       userinfo['phone_number']=resdata['data']['phone_number'];
       userinfo['token']=resdata['data']['token'];
      
      }
     if(res.statusCode == 422 || res.statusCode == 400){
      throw '${resdata['message']}';
     }
    }catch(errore){
      rethrow ;
    }
  }


    Future<void> getper ()async{
    final String url = '${baseurl}admin/permissions';
    try{
     final res = await http.get(Uri.parse(url) ,       
     headers: {
       "ngrok-skip-browser-warning": 'true',
      'Accept':'application/json', 
      'Authorization': 'Bearer ${userinfo['token']}'
     }
     );
   final resdata = json.decode(res.body);
   permissions = resdata['data']['permissions'] as List<dynamic>;
    }catch(errore){
       throw'$errore';
    }
  }

  Future<void> getalladmins ()async{
    final String url = '${baseurl}admin';
    try{
     final res = await http.get(Uri.parse(url) ,       
     headers: {
       "ngrok-skip-browser-warning": 'true',
      'Accept':'application/json', 
      'Authorization': 'Bearer ${userinfo['token']}'
     }
     );
   final resdata = json.decode(res.body);
   alladmins = resdata['data'] as List<dynamic>;
    }catch(errore){
       throw'$errore';
    }
  }

  Future<void> getcompany ()async{
    final String url = '${baseurl}companies';
    try{
     final res = await http.get(Uri.parse(url) ,       
     headers: {
      "ngrok-skip-browser-warning": 'true',
     'Accept':'application/json',
      'Authorization': 'Bearer ${userinfo['token']}'
     }
     );
   final resdata = json.decode(res.body);
   comapnies = resdata['data'] as List<dynamic>;

    }catch(errore){
       throw'$errore';
        
    }
  }
  
   Future<void> getrecentmed ()async{
    final String url = '${baseurl}latest/product';
    try{
     final res = await http.get(Uri.parse(url) , 
     headers: {
      "ngrok-skip-browser-warning": 'true',
      'Accept':'application/json',
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
   final resdata = json.decode(res.body);
   lastmed = resdata['data'] as List<dynamic>;

    }catch(errore){
      throw'$errore';
    }
  }

  Future<void> gettoday ()async{
    final String url = '${baseurl}today';
    try{
     final res = await http.get(Uri.parse(url) , 
     headers: {
      'Accept':'application/json' ,
      "ngrok-skip-browser-warning": 'true',
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
   final resdata = json.decode(res.body);
   today = resdata['data']['total'];

    }catch(errore){
      throw'$errore';
    }
  }

  Future<void> getsuper ()async{
    final String url = '${baseurl}admin/is_super_admin';
    try{
     final res = await http.get(Uri.parse(url) , 
     headers: {
      'Accept':'application/json' ,
      "ngrok-skip-browser-warning": 'true',
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
   final resdata = json.decode(res.body);
   issuper = resdata['data']['is_super_admin'];

    }catch(errore){
      throw'$errore';
    }
  }

  Future<void> getuser ()async{
    final String url = '${baseurl}users/num';
    try{
     final res = await http.get(Uri.parse(url) , 
     headers: {
      'Accept':'application/json' ,
      "ngrok-skip-browser-warning": 'true',
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
   final resdata = json.decode(res.body);
   users = resdata['data']['count'];

    }catch(errore){
      throw'$errore';
    }
  }

  Future<void> getadmin ()async{
    final String url = '${baseurl}admins/num';
    try{
     final res = await http.get(Uri.parse(url) , 
     headers: {
      'Accept':'application/json' ,
      "ngrok-skip-browser-warning": 'true',
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
   final resdata = json.decode(res.body);
   admins = resdata['data']['count'];

    }catch(errore){
      throw'$errore';
    }
  }

  Future<void> getweek ()async{
    final String url = '${baseurl}week';
    try{
     final res = await http.get(Uri.parse(url) , 
     headers: {
      'Accept':'application/json' ,
      "ngrok-skip-browser-warning": 'true',
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
   final resdata = json.decode(res.body);
   week = resdata['data']['ratios'] as List<dynamic>;
    }catch(errore){
      throw'$errore';
    }
  }
  
   Future<void> getmonth ()async{
    final String url = '${baseurl}month';
    try{
     final res = await http.get(Uri.parse(url) , 
     headers: {
      'Accept':'application/json' ,
      "ngrok-skip-browser-warning": 'true',
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
   final resdata = json.decode(res.body);
   month = resdata['data']['total'];

    }catch(errore){
      throw'$errore';
    }
  }
   
    Future setmedicen (var _selectedfile)async{
    final String url = '${baseurl}products/create';
    try{
     final request = http.MultipartRequest('POST',Uri.parse(url));
    
    request.headers.addAll({'Accept':'application/json' ,
      'Authorization': 'Bearer ${userinfo['token']}',
      },);
      request.fields.addAll(medecin);
      if(_selectedfile!= null){
         request.files.add( http.MultipartFile.fromBytes('photo', _selectedfile!,
      contentType: MediaType('image', 'JPG'),filename: "any_name"
      ));
      }
     var res= await request.send();
     var response = await http.Response.fromStream(res);
     if(response.statusCode == 500){
      throw 'No Internet , Please try again';
     }
     }
    catch(errore){
      rethrow ;
    }
  }



     Future setcompany (var _selectedfile)async{
    final String url = '${baseurl}companies';
    try{
     final request = http.MultipartRequest('POST',Uri.parse(url));
    
    request.headers.addAll({'Accept':'application/json' ,
      'Authorization': 'Bearer ${userinfo['token']}',
      },);
      request.fields.addAll(company);
      request.files.add( http.MultipartFile.fromBytes('icon', _selectedfile!,
      contentType: MediaType('image', 'JPG'),filename: "any_name"
      ));
     var res= await request.send();
     var response = await http.Response.fromStream(res);
      if(response.statusCode == 500){
      throw 'No Internet , Please try again';
     }
     }
    catch(errore){
      rethrow ;
    }
  }



  
   Future getupdatemedicen (String id )async{
    final String url = '${baseurl}products/$id';
    try{
     final res = await http.post(Uri.parse(url) ,
     headers: {'Accept':'application/json' ,
      'Authorization': 'Bearer ${userinfo['token']}',
      },
     body: updatemedecin
     );
     if(res.statusCode == 500 ){
      throw ' No Internet , Please try again';
     }
     }
    catch(errore){
      rethrow ;
    }

  }

     Future getupdatecompany (String id )async{
    final String url = '${baseurl}companies/$id';
    try{
     final res = await http.post(Uri.parse(url) ,
     headers: {'Accept':'application/json' ,
      'Authorization': 'Bearer ${userinfo['token']}',
      },
     body: updatecompany
     );
     if(res.statusCode == 500 ){
      throw ' No Internet , Please try again';
     }
     else if (res.statusCode == 422){
      throw 'The icon field is required';
     }
     }
    catch(errore){
      rethrow ;
    }
  }

   Future<void> getshowmed (String id)async{
    final String url = '${baseurl}products/$id';
    try{
     final res = await http.get(Uri.parse(url), 
     headers: {
      'Accept':'application/json' ,
      "ngrok-skip-browser-warning": 'true',
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
   final resdata = json.decode(res.body);
   showpro = resdata['data'] as Map<String , dynamic>;

    }catch(errore){
      throw'$errore';
    }
  }

  Future<void> getshowcom (String id)async{
    final String url = '${baseurl}companies/$id';
    try{
     final res = await http.get(Uri.parse(url), 
     headers: {
      'Accept':'application/json' ,
      "ngrok-skip-browser-warning": 'true',
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
   final resdata = json.decode(res.body);
   showcom = resdata['data'] as Map<String , dynamic>;

    }catch(errore){
      throw'$errore';
    }
  }

   Future<void> deletemed (String id)async{
    final String url = '${baseurl}products/$id';
    try{
      await http.delete(Uri.parse(url), 
     headers: {
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
    }catch(errore){
      throw'$errore';
    }
  }

   Future getcomcat(String idcom , String idcat)async{
    final String url = '${baseurl}products';
    try{
     final res = await http.post(Uri.parse(url) ,
     headers: {'Accept':'application/json',
     'Authorization': 'Bearer ${userinfo['token']}'},
     body: {
      'company':idcom,
      'classification':idcat
     });
     final resdata = json.decode(res.body);
      if(resdata['success']== true){
         comcat = resdata['data']['data'] as List<dynamic>;
      }
     if(res.statusCode == 422 || res.statusCode == 400){
      throw '${resdata['message']}';
     }
    }catch(errore){
      rethrow ;
    }
  }

  Future<void> deletecompany (String id)async{
    final String url = '${baseurl}companies/$id';
    try{
       await http.delete(Uri.parse(url), 
     headers: {
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
    }catch(errore){
      throw'$errore';
    }
  }

 Future<void> getorder (String id)async{
    final String url = '${baseurl}carts/order/$id';
    try{
     final res = await http.get(Uri.parse(url), 
     headers: {
      'Accept':'application/json' ,
      "ngrok-skip-browser-warning": 'true',
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
   final resdata = json.decode(res.body);
    if(resdata['success'] == true){
      sporder = resdata['data'] as List<dynamic>;
      return;
    }
     throw 'It is a wrong';
    }catch(errore){
      throw'$errore';
    }
  }

Future<void> getpaid (String id)async{
    final String url = '${baseurl}carts/paid/$id';
    try{
     final res = await http.put(Uri.parse(url), 
     headers: {
      'Accept':'application/json' ,
      "ngrok-skip-browser-warning": 'true',
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
   final resdata = json.decode(res.body);
    if(res.statusCode == 400){
      throw resdata['message'];
    }

    }catch(errore){
      throw'$errore';
    }
  }

  Future<void> getstate (String id)async{
    final String url = '${baseurl}carts/next/$id';
    try{
     final res = await http.put(Uri.parse(url), 
     headers: {
      'Accept':'application/json' ,
      "ngrok-skip-browser-warning": 'true',
      'Authorization': 'Bearer ${userinfo['token']}',
     }
     );
   final resdata = json.decode(res.body);
    if(res.statusCode == 400){
      throw resdata['message'];
    }

    }catch(errore){
      throw'$errore';
    }
  }

  int indmed = 0 ;
  void changeind (int newind){
    indmed = newind ;
    notifyListeners();
   }

   String idorder = '0';
   void changeindorder (String id){
    idorder = id ;
    notifyListeners();
   }

   int state = 0 ;
   void changestate(int s){
    state = s;
    notifyListeners();
   }

   int payment = 0;
  void changepay (int p){
    payment = p ;
    notifyListeners();
  }

 

}