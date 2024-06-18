<%@ Page Title="" Language="VB"  AutoEventWireup="false" CodeFile="Error.aspx.vb" Inherits="frmError" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" crossorigin="anonymous">

    <style type="text/css">
        .clsRed
        {
            color:red;

        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
       <div class="row">
 <table align="center" style="width: 100%" class="table table-bordered">
            <thead>
                <tr>
                    <th colspan="3" style="font-size:14pt;text-align:center">Some of the records which are either blank or not found (highlighted in red color) . Kindly pass correct details.   </th>
                </tr>
            </thead>
                 </table>
        <table align="center" style="width: 50%" class="table table-bordered">
            <thead>
                <tr>
                    <th colspan="3">Your Details are  </th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>EmpCode </td>
                    <td style="width: 2%">:
                    </td>
                    <td>
                        <span id="spEmpCode" runat="server"></span>
                    </td>
                </tr>
                <tr>
                    <td>Name </td>
                    <td style="width: 2%">:
                    </td>
                    <td>
                        <span id="spName" runat="server"></span>
                    </td>
                </tr>
                <tr>
                    <td>EmailId</td>
                    <td style="width: 2%">:
                    </td>
                    <td>
                       <span id="spEmailId" runat="server"></span>
                    </td>
                </tr>
                <tr>
                    <td>Level</td>
                    <td style="width: 2%">:
                    </td>
                    <td>
                       <span id="spLevel" runat="server"></span>
                    </td>
                </tr>
                <tr>
                    <td>AssessmentType</td>
                    <td style="width: 2%">:
                    </td>
                    <td>
                       <span id="spAssessmentType" runat="server"></span>
                    </td>
                </tr>                     
            </tbody>
        </table>
           
    </div>
    </form>
</body>
</html>
  


