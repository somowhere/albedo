<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>您的请求无法被处理</title>
    <link href="${ctxStatic}/common/message.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container">
    <h2>500 <span>:(</span></h2>

    <p>抱歉,发生了一个错误.</p>

    <span>状态:</span>&nbsp;${error!}&nbsp;(${error!})<br/>
    <span>消息:</span>&nbsp;${message!}<br/>
    <br/>
    <a class="btn" href="javascript :history.go(-1);">返回</a>
    <a class="btn" href="${ctx!}/login">去登录</a>
</div>
</body>
</html>
