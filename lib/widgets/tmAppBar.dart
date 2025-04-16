import 'package:besttodotask/screen/profile/profileUpdateScreen.dart';
import 'package:flutter/material.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key, this.fromProfile,
  });
  final bool? fromProfile;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: (){
          if(fromProfile ?? false){
            return;
          }
          _onProfileTap(context);
        },
        child: Row(
          children: [
            CircleAvatar(),
            const SizedBox(width: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rahim Hasan',style: textTheme.bodyLarge!.copyWith(color: Colors.white),),
                Text('rahim@gmail.com',style: textTheme.bodySmall!.copyWith(color: Colors.white),)
              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.logout,color: Colors.white,)
        )
      ],
    );
  }

  void _onProfileTap(context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileUpdateScreen()));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
