
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResturantAppbar extends StatelessWidget {
  const ResturantAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true, //appbar pinned
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset('assets/images/Header-image.png',
        fit: BoxFit.cover,)

      ),

      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: SvgPicture.asset(
            'assets/icons/back.svg',

          ),
        ),

      ),


      actions: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: SvgPicture.asset(
            'assets/icons/share.svg',
            color: Colors.black,
            
          ),
        ),

         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 18),
           child: CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              color: Colors.black,
             
         
            ),
                       ),
         )
      ],



// end



    );
  }
}