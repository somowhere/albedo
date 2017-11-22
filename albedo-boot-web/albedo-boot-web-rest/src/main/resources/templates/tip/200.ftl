<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>系统提示</title>
    <link href="${ctxStatic}/common/message.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container">
    <h2>系统提示 <span>:(</span></h2>

    <span>状态:</span>&nbsp;${error!}&nbsp;(${status!})<br/>
    <span>消息:</span>&nbsp;${message!}<br/>
    <br/>
    <a class="btn" href="javascript :history.go(-1);">返回</a>
</div>
</body>
</html>
