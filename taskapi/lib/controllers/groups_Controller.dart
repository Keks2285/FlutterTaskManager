import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:taskapi/model/group.dart';

import '../model/user.dart';
import '../model/user_group.dart';
import '../utils/app_responce.dart';
import '../utils/app_utils.dart';
import '../utils/model_responce.dart';


class AppGroupsConttolelr extends ResourceController {
  AppGroupsConttolelr(this.managedContext);

  final ManagedContext managedContext;

 
  @Operation.get()
  Future<Response> getGroups(
    @Bind.header(HttpHeaders.authorizationHeader) String header
  ) async {
    try {
      // Получаем id пользователя
      // Была создана новая функция ее нужно реализоваться для просмотра функции нажмите на картинку
      final id = AppUtils.getIdFromHeader(header);
      final query = Query<User>(managedContext)
        ..where((t) => t.id).equalTo(id)
        ..join(set: (t) => t.groupList).join(object: (tp) => tp.group);

      final user = await query.fetchOne();
      if (user == null) {
        return Response.notFound();
      }
//var a = user.groupList.to;
      if (user.groupList!.toList().isEmpty) {
        return Response.notFound();
      }
      List<Group> groupsOfuser = [];
      user.groupList!.forEach((element) {
        groupsOfuser.add(element.group!);
      });
      return Response.ok(groupsOfuser);
    } catch (e) {
      return AppResponse.serverError(e, message: 'Ошибка получения данных');
    }
  }

    @Operation.put()
  Future<Response> createGroup(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.body() Group group,
  ) async {
    try{
      final uid = AppUtils.getIdFromHeader(header);
      final query = Query<User>(managedContext)
        ..where((t) => t.id).equalTo(uid)
        ..join(set: (t) => t.groupList).join(object: (tp) => tp.group);
        List<Group> groupsAdminuser = [];
        final user = await query.fetchOne();
      if (user == null) {
        return Response.notFound();
      }
      
      List<Group> groupsOfuser = [];
      
      user.groupList!.forEach((element) {
        groupsOfuser.add(element.group!);
      });
      groupsOfuser=groupsOfuser.where((element) => element.adminid==uid).toList();
      if(groupsOfuser.length>=3){
        return AppResponse.badrequest( message: 'Вы уже являетесть администратором 3 групп, вы не можете создать еще');
      }
    late final int id;
      await managedContext.transaction((transaction) async {
          final qCreategroup= Query<Group>(transaction)
          ..values.nameGroup=group.nameGroup
          ..values.adminid=group.adminid;

          final createdtask = await qCreategroup.insert();
          id=createdtask.id!;
      });
      final GroupData = await managedContext.fetchObjectWithID<Group>(id);
      final UserData = await managedContext.fetchObjectWithID<User>(uid);
      await managedContext.transaction((transaction) async {
          final qCreategroup= Query<User_Group>(transaction)
          ..values.group=GroupData
          ..values.user=UserData;

           await qCreategroup.insert();
      });
      
    return Response.ok(GroupData);
    } on QueryException catch(e){
      return Response.serverError(

        body:  ModelResponse(message: e.message, error: "Not added")
      
      );
    }
  }











  @Operation.post('id')
  Future<Response> joinGroup(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    //@Bind.body() Group group,
    @Bind.path("id") int groupId
  ) async {
    try{
      final uid = AppUtils.getIdFromHeader(header);


      final GroupData = await managedContext.fetchObjectWithID<Group>(groupId);
      final UserData = await managedContext.fetchObjectWithID<User>(uid);

      final qGetUser_Group= Query<User_Group>(managedContext)
      ..where((el)=>el.user!.id).equalTo(uid)
      ..where((el) => el.group!.id).equalTo(groupId);

      final User_Group? listUser_Group = await qGetUser_Group.fetchOne();
      if(listUser_Group!=null){
         return AppResponse.badrequest( message: 'Вы уже являетесть ачленом этой группы');
      }

      final userGroupData =await managedContext.transaction((transaction) async {
          final qCreategroup= Query<User_Group>(transaction)
          ..values.group=GroupData
          ..values.user=UserData;

           await qCreategroup.insert();
      });
      return Response.ok(userGroupData);
    }on QueryException catch(e){
      return Response.serverError(

        body:  ModelResponse(message: e.message, error: "Not added")
      
      );
    }
    

  }

}





 
