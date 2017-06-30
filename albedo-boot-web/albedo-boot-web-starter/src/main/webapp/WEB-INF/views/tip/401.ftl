<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>您的请求无法被处理</title>
    <link href="${ctxStatic}/common/message.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container">
    <h2>
        401<span>:(</span>
    </h2>

    <p>${message!'未经授权，无法访问'}</p>

    <a class="btn" href="${ctx!}/login">去登录</a>
</div>
</body>
</html>
