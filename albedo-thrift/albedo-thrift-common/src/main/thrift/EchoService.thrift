namespace java com.yangyang.thrift.rpc.demo
service EchoSerivce
{
	string echo(1: string msg);
}