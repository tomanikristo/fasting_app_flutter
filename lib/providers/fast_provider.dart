import 'package:flutter/material.dart';

import './fast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FastProvider with ChangeNotifier {
  static Color _color = Colors.red;
  List<Fast> _officialFasts = [
    Fast(
      id: 'c1',
      title: '16-8',
      time: 16,
      color: _color,
      isActive: false,
    ),
    Fast(
      id: 'c2',
      title: '17-7',
      time: 17,
      color: _color,
      isActive: false,
    ),
    Fast(
      id: 'c3',
      title: '18-6',
      time: 18,
      color: _color,
      isActive: false,
    ),
    Fast(
      id: 'c4',
      title: '19-5',
      time: 19,
      color: _color,
      isActive: false,
    ),
    Fast(
      id: 'c5',
      title: '20-4',
      time: 20,
      color: _color,
      isActive: false,
    ),
    Fast(
      id: 'c6',
      title: '21-3',
      time: 21,
      color: _color,
      isActive: false,
    ),
    Fast(
      id: 'c7',
      title: '22-2',
      time: 22,
      color: _color,
      isActive: false,
    ),
    Fast(
      id: 'c8',
      title: '23-1',
      time: 23,
      color: _color,
      isActive: false,
    ),
  ];

  List<Fast> get officialFasts {
    return [..._officialFasts];
  }

  Fast findById(String id) {
    return officialFasts.firstWhere((fst) => fst.id == id);
  }
  
  Future<void> fetchandSetFast() async {
    const url = 'https://ifast-d9cb1.firebaseio.com/fasts.json';
    try {
      final response = await http.get(url);
      print(
        json.decode(response.body),
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Fast> loadadedFasts = [];
      extractedData.forEach((fastId, fastData) {
        loadadedFasts.add(Fast(
            id: fastId,
            time: fastData['time'],
            title: fastData['title'],
            isActive: fastData['isActive']));
      });
      _officialFasts= loadadedFasts + _officialFasts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addFast(Fast fast) {
    const url = 'https://ifast-d9cb1.firebaseio.com/fasts.json';
    return http
        .post(url,
            body: json.encode({
              'title': fast.title,
              'time': fast.time,
              'fastStartTime': fast.fastStartTime.toString(),
              'isActive': fast.isActive = false,
            }))
        .then((response) {
      print(json.decode(response.body));
      final newProduct = Fast(
        title: fast.title,
        time: fast.time,
        fastStartTime: fast.fastStartTime,
        id: json.decode(response.body)['name'],
        isActive: fast.isActive = false,
        color: fast.color,
      );
      _officialFasts.add(newProduct);
      _officialFasts.insert(0, newProduct);
      notifyListeners();
    }).catchError((error) {
      print('IDK something went wrong');
      throw error;
    });
  }

   int showActiveTime( fast){
    if(fast.activeTime == null){
      return fast.activeTime = 0;
    }else{
      return fast.activeTime;
    }
  }
}
