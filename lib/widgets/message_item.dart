

import 'package:flutter/material.dart';



class MessageItem extends StatelessWidget {
  const MessageItem({super.key});
  @override
  Widget build(BuildContext context)
  {
   return Row(
     children:
     [
       Padding(
         padding: const EdgeInsets.only(left: 10,top: 20),
         child: CircleAvatar(
             radius: 30,
             child: Icon(Icons.person,color: Colors.grey[300],size: 40,)
         ),
       ),
       const SizedBox(width: 20,),
       const Text('Katerina Zaharova',style: TextStyle(color: Colors.black,fontSize: 20),),


     ],
   );
  }
}
