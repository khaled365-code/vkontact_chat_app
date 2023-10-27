

import 'package:flutter/material.dart';



class MessageItem extends StatelessWidget {  @override
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
       SizedBox(width: 20,),
       Text('Katerina Zaharova',style: TextStyle(color: Colors.black,fontSize: 20),),


     ],
   );
  }
}
