
import 'dart:convert';
import 'dart:core';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'wael:wael12345'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};


class Crud
{
  static getRequest({required String url}) async
  {
    try
        {
          var response=await http.get(Uri.parse(url));

          if(response.statusCode==200)
            {
              return jsonDecode(response.body);
            }
          else
            {
              print("Error  ${response.statusCode}");
            }
        }catch(e)
    {
      print("Error ${e}");
    }
  }

  static postRequest({ required String url,required Map data}) async
  {
    try
    {
      var response=await http.post(Uri.parse(url),body: data,headers: myheaders);
      if(response.statusCode==200)
      {
        var resonsebody=jsonDecode(response.body);
        return resonsebody;
      }
      else
      {
        print("Error response ${response.statusCode}");
      }
    }catch(e)
    {
      print("Error  ${e}");
    }
  }
  static postRequestWithFile({required String url,required Map data, required File file})async
  {
    var  request=http.MultipartRequest("POST",Uri.parse(url));
    var length= await file.length();
    var stream=http.ByteStream(file.openRead());
    var multipartFile=http.MultipartFile("file",
        stream,
        length,
        filename:basename(file.path));
     request.files.add(multipartFile);
     request.headers.addAll(myheaders);
     data.forEach((key, value)
     {
       request.fields[key]=value;
     });
     var myrequest=await request.send();
     var response=await http.Response.fromStream(myrequest);
     if(myrequest.statusCode==200)
       {
         return jsonDecode(response.body);
       }else
         {
           print("Error  ${myrequest.statusCode}");
         }
  }
}