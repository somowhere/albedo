namespace java com.albedo.java.thrift.rpc.example
service EchoSerivce
{
	string echo(1: string msg);
}

service IPushManageService {

    string getConnectServerList();
    i32 getOnlineUserNum(1: string ip);

}