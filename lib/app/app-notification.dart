import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class AppNotification{

  static deleteNotifcation(String title,String? subtitle){
     BotToast.showNotification(
      backgroundColor: Colors.red,
      leading: (_) =>const Icon(Icons.delete),
      title: (_) =>Text(title),
      subtitle: (_) => Text(subtitle ?? ""),
                      trailing: (cancel) => IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: cancel,
                          ),
                      contentPadding: const EdgeInsets.all(2),
                      onlyOne: true,
                      animationDuration:
                         const Duration(milliseconds: 300),
                      animationReverseDuration:
                         const Duration(milliseconds: 600),
                      duration: const Duration(seconds: 1)); 
  }
}