<%@ Page Title="" Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>
<!DOCTYPE html>
<html>
<head runat="server">
<meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>Assessment</title>
    <link href="Images/favicon.ico" rel="shortcut icon" type="image/x-icon" />

    <!-- Latest compiled and minified CSS -->
    <link href="CSS/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="CSS/style.css" rel="stylesheet" type="text/css" />

    <!-- Latest compiled and minified JavaScript -->
    <script src="Scripts/jquery-1.12.4.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(window).on("load resize", function (e) {
            $('.login-box').css({
                "margin-top": ($(window).height() - $(".login-box").outerHeight()) / 2 + "px"
            });
            $('input[type="text"], input[type="password"]').focus(function () {
                $(this).data('placeholder', $(this).attr('placeholder')).attr('placeholder', '');
            }).blur(function () {
                $(this).attr('placeholder', $(this).data('placeholder'));
            });
        });
    </script>
    <!-- WARNING: Respond.js doesn't work if you view the page via file: -->
    <!--[if lt IE 9]>
  <script src="Scripts/html5shiv.min.js"></script>
  <script src="Scripts/respond.min.js"></script>
<![endif]-->

    
</head>
<body>
    <form id="form1" runat="server">
        <div class="full-background" style="background-image: url(Images/login-bg.jpg)"></div>
        <div class="login-logo">
            <img src="Images/axiata.svg" />
        </div>
		<div class="container">
            <div class="login-box">
                <h3 class="login-box-heading" id="hdMsg" runat="server"></h3>
            </div>
            </div>
</form>
</body>
</html>