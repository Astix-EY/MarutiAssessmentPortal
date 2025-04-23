<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="frmExerciseElapsedTimeUpdation.aspx.cs" Inherits="frmExerciseElapsedTimeUpdation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">

    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;">
  <link href="../../JDatatable/jquery.dataTables.css" rel="stylesheet" />
    <script src="../../JDatatable/dataTables.js"></script>

        <script type="text/javascript">

            function getlist() {
            
                var usercode = $("#ConatntMatter_txtusercode").val();

            $("#dvFadeForProcessing").show();
            $.ajax({

                type: "POST",
                url: "frmExerciseElapsedTimeUpdation.aspx/getdata",
                data: "{usercode:'" + usercode + "'}",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                async: "true",
                success: function (response) {

                    if (response.d != "0") {

                        $('#divData').html(response.d);

                    }
                    else {
                        $('#divData').html("<span style='color:red;font-weight: bold'>No record(s) found</span>");
                      
                    }
                    $("#dvFadeForProcessing").hide();
                },

                error: function (response) {
                    $("#dvFadeForProcessing").hide();
                    alert(response.status + ' ' + response.statusText + ' ' + response.responseText);
                }

            });

            }


            function changemain(obj) {
                //alert('hi');
                //var par = $(obj).parent().parent(); //tr    
                var par = $(obj).closest('tr');
                var $tds = $(par).find('td');

                //alert('hi');
                //$tds.eq(2).find('input[type="text"]').css("display", "block");
                par.find('input[type="text"]').css("display", "block");
                par.find('div').css("display", "none");


                $(obj).siblings("#hidchange").val("1")
            

                $(obj).siblings("#lbCancel").css("display", "inline-block");
                $(obj).siblings("#lbSave").css("display", "inline-block");
                $(obj).css("display", "none");

            };


            function Cancel(obj) {
               
                var par = $(obj).closest('tr');
                var $tds = $(par).find('td');

           
                par.find('input[type="text"]').css("display", "none");
                par.find('div').css("display", "block");


                $(obj).siblings("#hidchange").val("0")


                $(obj).siblings("#lbEdit").css("display", "inline-block");
                $(obj).siblings("#lbSave").css("display", "none");
                $(obj).css("display", "none");



            }


            function Save(obj) {
                var scon = confirm("Are you sure want to extend exercise time?");
                if(scon){
                    var par = $(obj).closest('tr');
                    var RspExerciseId = par.find('input[type="text"]').attr('id');
                    var ElapsedTimeMin = par.find('input[type="text"]').val();
                    var LoginId = $("#ConatntMatter_hdnLoginId").val();
                    fnStartLoading();
                    PageMethods.ExerciseElapsedTimeUpdation(RspExerciseId, ElapsedTimeMin,LoginId, exci_pass, fnFail);
                }
            }


          
            function exci_pass(res) {
                //$("#dvTaskRptContent").html(res);
                fnEndLoading();
                if (res.split("^")[0] == "1") {
                    alert("Error:" + res.split("^")[1]);
                    return false;
                }
                //window.location.reload();
                getlist();
            }

            function fnFail(err) {
                fnEndLoading();
                alert(err._message);
                
            }


            function fnStartLoading() {
                $("#dvFadeForProcessing").css("display", "block");
            }

            function fnEndLoading() {
                $("#dvFadeForProcessing").css("display", "none");
            }

            function whichButton(event) {
                if (event.button == 2)//RIGHT CLICK
                {
                    alert("Not Allow Right Click!");
                }
            }
            function noCTRL(e) {
                //alert(e);
                //e.preventDefault();

                var code = (document.all) ? event.keyCode : e.which;
                var msg = "Sorry, this functionality is disabled.";
                if (parseInt(code) == 17) //CTRL
                {
                    alert(msg);
                    window.event.returnValue = false;
                }
            }

            function isNumberKeyNotDecimal(evt) {
                //debugger;
                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;


                return true;
            }

 </script>


    <style>
        .form-control {
            height:30px;
            margin-right:5px;
            float:none;
        }

        img {
            vertical-align: middle;
            height: 25px;
        }

        /*.table {
            width: 70%;
            max-width: 70%;
        }*/

        .clsDiscPer {
             /*border: solid 1px #FF0000;*/  
             background-color:salmon!important;
             color:black;
        }

        
        .ui-multiselect span.ui-icon { float:right;background-color:#F1F1F1;border:1px solid #A6A8AD;height:20px }
    .ui-icon-triangle-1-s {
        background-position: -65px -12px;
    }

    </style>   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" Runat="Server">
     <div id="dvFadeForProcessing" style="position: fixed;display:none; z-index: 99999999; top: 0; bottom: 0; left: 0; right: 0; opacity: .80; -moz-opacity: 0.8; filter: alpha(opacity=80); background-color: #ccc;">
        <div id="Div1" runat="server" align="center" style="position: absolute; width: 50px; top: 30%; left: 45%;">
            <img alt="" title="Loading..." src="../../Images/blue-loading.gif" style="height: 50px;" />
        </div>
    </div>
    <div style="margin-top:30px">
  <div class="form-inline" >
            <div class="form-group">
                <label for="exampleInputName2">Enter User Code</label>
                <input type="text" class="form-control" id="txtusercode" runat="server" />
                <input type="button" value="View" class="btn btn-default btn-sm" onclick="getlist();" />
            </div>            
        </div>
            
         <div style="padding-bottom: 80px; margin-top: 10px">
            <div id="divData" class="table-responsive"></div>
        </div>
        </div>
    <asp:HiddenField runat="server" ID="hdnLoginId" Value="0" />
</asp:Content>

