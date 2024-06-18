<%@ Page Language="C#" AutoEventWireup="false" CodeFile="Login.aspx.cs" Inherits="AssessorLogin" %>

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
     <link href="CSS/font-awesome.css" rel="stylesheet" type="text/css" />
    <link href="CSS/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="CSS/style.css" rel="stylesheet" type="text/css" />

    <!-- Latest compiled and minified JavaScript -->
    <script src="Scripts/jquery-1.12.4.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(window).on("load resize", function () {
            // Var Background image
            var pageSection = $(".full-background");
            pageSection.each(function (indx) {
                if ($(this).attr("data-background")) {
                    $(this).css("background-image", "url(" + $(this).data("background") + ")");
                }
            });

            $(".login-left").css({
                marginTop: ($(window).height() - $(".login-left").outerHeight()) / 2 + "px"
            });
            $(".loginfrm").css({
                marginTop: ($(window).height() - $(".loginfrm").outerHeight()) / 2 + "px"
            });

            $('input[type="text"], input[type="password"]').focus(function () {
                $(this).data('placeholder', $(this).attr('placeholder')).attr('placeholder', '');
            }).blur(function () {
                $(this).attr('placeholder', $(this).data('placeholder'));
            });

            $("#tconditions").click(function () {
                 $('#dvtconditions').fadeIn(200);
                $(".modal-lg").css({ maxWidth: '80%' });
                $(".section-content > p").css({ "margin-bottom": ".5rem" });
            });
        });

        function closePopup() {
            $('.modal').hide();
        }
        function fnValidate() {
            document.getElementById("<%=hdnRes.ClientID %>").value = screen.availWidth + "*" + screen.availHeight;
            if (document.getElementById("txtUserName").value == "") {
                document.getElementById("lblloginmsg").innerText = "User Name can't be blank";
                document.getElementById("txtUserName").focus();
                return false;
            }
            if (document.getElementById("txtPwd").value == "") {
                document.getElementById("lblloginmsg").innerText = "Password can't be blank";
                document.getElementById("txtPwd").focus();
                return false;
            }
            if ($("#hdnTermsConfirmation").val() == "0") {
                if ($("#terms_conditions").prop("checked") == false) {
                    document.getElementById("lblloginmsg").innerText = "* Please agree to the Terms and Condition";
                    return false;
                }
            }
            return true;
        }

        function fnShowDialog() {
            var valid = fnValidate();

            if (valid == false) {
                return false;
            }
            else {
                document.getElementById("<%=btnSubmit.ClientID %>").click();
            }

        }

       


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
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="login-left">
                        <div class="login-logo">
                            <img src="Images/ey-logo-fullw.svg" alt="EY Logo" />
                        </div>
                        <h3 class="login-title ">CRAFTING YOUR PERSONAL JOURNEY</h3>
                
                    </div>
                </div>
               <div class="col-md-5 offset-md-1">
                    
                    <div class="loginfrm cls-4">
                        <div class="login-box">
                            <div class="login-box-msg">
                                <h3 class="title">Login</h3>
                            </div>
 
                            <div class="login-box-body clearfix">
                                <div class="input-group frm-group-txt">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fa fa-user"></i></span>
                                    </div>
                                    <input type="text" class="form-control" id="txtUserName" runat="server" placeholder="User Name" autocomplete="off" />
                                </div>
                                <div class="input-group frm-group-txt">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fa fa-lock"></i></span>
                                    </div>
                                    <input type="password" class="form-control" id="txtPwd" runat="server" placeholder="Password" autocomplete="off" />
                                </div>

                                <div class="frm-group-txt-I">
                                <div class="form-check" id="dvTermsNotChecked">
                                    <input class="form-check-input" type="checkbox" value="" id="terms_conditions">
                                    <label class="form-check-label" for="defaultCheck1">
                                        I agree to the <span class="conditions" id="tconditions">Terms & Conditions</span>
                                    </label>
                                </div>
                            </div>
                            <div class="frm-group-txt-I">
                                <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" CssClass="btns btn-submit col-12" Text="Submit" Style="display: none;" />
                                <input type="button" class="btns btn-submit col-12" value="Submit" onclick="fnShowDialog()" />
                            </div>

                                <div class="frm-group-txt-I text-center">
                                    <asp:Label ID="lblloginmsg" runat="server" CssClass="alertcls alert-danger"></asp:Label>
                                </div>

                                <%--<div class="bottom-text text-right mb-3">
                                    <span class="forgotpwd">Forgot <a href="#" onclick="fnForgotPwd()">Password</a>?</span>
                                </div>--%>

                            </div>
                        </div>
                         <div class="login-box alt">
                            <div class="toggle"></div>
                        </div>
                        <div class="login-box"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal" id="dvtconditions" style="display: none">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" runat="server" id="h5">TERMS OF SERVICE</h5>
                        <div class="close" onclick="closePopup();">&times;</div>
                    </div>
                    <div class="modal-body p-t-25">
                        <p class="font-weight-bold" runat="server" id="P1">CONFIDENTIALITY</p>
                        <p runat="server" id="P2">You acknowledge that in the course of using the Services you may have access to Confidential Information. You shall not at any time use or disclose to any third party (and shall use your best endeavours to prevent the publication or disclosure of) any Confidential Information. </p>
                        <p runat="server" id="P3">The restriction in this clause does not apply to:</p>
                        <ol type="a">
                            <li runat="server" id="l1">any use or disclosure required by law, or</li>
                            <li runat="server" id="l2">any information which is already in, or comes into, the public domain otherwise than through your unauthorised disclosure.</li>
                        </ol>
                        <p class="font-weight-bold" runat="server" id="P4">INTELLECTUAL PROPERTY RIGHTS</p>
                        <p runat="server" id="P5">We are the owner or the licensee of all intellectual property rights in the Site and the Service and in the material published on it. Those works are protected by copyright laws and treaties around the world.  All such rights are reserved.</p>
                        <p runat="server" id="P6">Save as expressly set out in these Candidate Terms of Service, you shall have no right, title or interest in and no right to use in any way whatsoever the Site or Service.</p>
                        <p class="font-weight-bold" runat="server" id="P7">DATA PROTECTION</p>
                        <p runat="server" id="P8">We process personal data in accordance with our Privacy Policy. Please ensure that you have read and understood our Privacy Policy before using our Service. Any changes to our Privacy Policy will be posted to our site. All data provided here will can be used for research purposes without specific reference to your name or details.</p>
                        <p class="font-weight-bold" runat="server" id="P9">OTHER TERMS:</p>
                        <p runat="server" id="P10">Although we ask registered users for certain information relating to their identity, we do not warrant this information has been confirmed or verified and we are not responsible for ensuring the accuracy or truthfulness of registered users&rsquo; purported identities or the validity of the information that they provide to us.</p>
                        <p runat="server" id="P11">We will not be liable in contract, tort (including negligence) or otherwise incurred by you in connection with the Site or Services or in connection with the use, inability to use, or results of the use of the Site or Services for any (i) loss of profits, anticipated savings, business opportunity, goodwill or loss of or damage to (including corruption) data (whether direct or indirect) or any indirect or consequential losses; (ii) loss of data; (iii) any loss arising from your failure to provide accurate and complete information when required to do so.</p>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hdnRes" runat="server" />
        <input type="hidden" id="hdnAgree" runat="server" value="0">
        <asp:HiddenField ID="hdnTermsConfirmation" runat="server" Value="0" />
    </form>
</body>
</html>
