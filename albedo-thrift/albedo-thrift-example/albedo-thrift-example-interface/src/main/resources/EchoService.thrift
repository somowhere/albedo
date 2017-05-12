namespace java com.albedo.java.thrift.rpc.example
service EchoSerivce
{
	string echo(1: string msg);
}