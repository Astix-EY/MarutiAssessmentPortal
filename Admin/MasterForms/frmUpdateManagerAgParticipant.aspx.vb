Imports System.Data
Imports System.Data.SqlClient
Imports System.Text
Partial Class Admin_MasterForms_frmUpdateManagerAgParticipant
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then

            Dim strReturnTable As String = fnDisplayManagerAndParticipantList(0, "")
            dvMain.InnerHtml = strReturnTable.Split("@")(1)
        End If
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function fnDisplayManagerAndParticipantList(ByVal TypeID As Integer, ByVal SearchText As String) As String
        Dim strTable As New StringBuilder
        Dim strReturnVal As String = 1
        Dim srlNmCntr As Int16 = 1

        Dim objCon As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom As New SqlCommand("[spGetManagerListAgParticpants]", objCon)

        objCom.Parameters.Add("@TypeID", SqlDbType.Int).Value = TypeID
        objCom.Parameters.Add("@SearchText", SqlDbType.VarChar).Value = SearchText

        objCom.CommandTimeout = 0
        objCom.CommandType = CommandType.StoredProcedure

        Dim da As New SqlDataAdapter(objCom)
        Dim ds As New DataSet
        da.Fill(ds)

        'Dim dr As SqlDataReader
        'objCon.Open()
        'dr = objCom.ExecuteReader()
        Dim SetName As String = ""
        If ds.Tables(0).Rows.Count > 0 Then
            strTable.Append("<div id='dvtblbody'><table class='table table-bordered table-sm text-center' id='tblEmp'>")
            strTable.Append("<thead><tr>")
            strTable.Append("<th style='width:8%'>")
            strTable.Append("S. No.")
            strTable.Append("</th>")
            strTable.Append("<th>")
            strTable.Append("Participant Name")
            strTable.Append("</th>")
            strTable.Append("<th>")
            strTable.Append("Participant Code")
            strTable.Append("</th>")
            strTable.Append("<th>")
            strTable.Append("Level Name")
            strTable.Append("</th>")

            strTable.Append("<th>")
            strTable.Append("Manager Name")
            strTable.Append("</th>")
            strTable.Append("<th style='width:10%' colspan=2>")
            strTable.Append("Include")
            strTable.Append("</th>")
            strTable.Append("</tr></thead>")
            strTable.Append("<tbody>")

            For Each drParticipant As DataRow In ds.Tables(0).Rows


                strTable.Append("<tr flgactive = " & drParticipant.Item("flgActive") & ">")
                strTable.Append("<td>")
                strTable.Append(srlNmCntr)
                strTable.Append("</td>")

                strTable.Append("<td>")
                strTable.Append(drParticipant.Item("ParticipantName"))
                strTable.Append("</td>")

                strTable.Append("<td>")
                strTable.Append(drParticipant.Item("Empcode"))
                strTable.Append("</td>")

                If drParticipant.Item("BandID") = 1 Then
                    SetName = "Level4"
                ElseIf drParticipant.Item("BandID") = 2 Then
                    SetName = "Level3"
                Else
                    SetName = "No Level Assigned"
                End If
                strTable.Append("<td>")
                strTable.Append(SetName)
                strTable.Append("</td>")

                'Dim ddlManageName As New ListItem
                'ddlManageName.Text = "- Select Manager - "
                'ddlManageName.Value = "0"
                Dim ddlManager As String = ""
                ddlManager &= "<option value = 0>- Select Manager -</option>"
                For Each MngrNameOptions As DataRow In ds.Tables(2).Rows
                    For Each row0 As DataRow In ds.Tables(1).Rows
                        If MngrNameOptions.Item("ManagerNodeID") = row0.Item("ManagerID") And row0.Item("ParticipantID") = drParticipant.Item("ParticipantID") Then
                            ddlManager &= "<option selected value = " & MngrNameOptions.Item("ManagerNodeID") & ">" & MngrNameOptions.Item("ManagerName").ToString() & "</option>"
                        End If
                    Next row0

                    ddlManager &= "<option value = " & MngrNameOptions.Item("ManagerNodeID") & ">" & MngrNameOptions.Item("ManagerName").ToString() & "</option>"

                Next MngrNameOptions
                strTable.Append("<td>")
                strTable.Append("<Select id='ddlmanagerList' > " & ddlManager & "</select>")
                strTable.Append("</td>")

                If drParticipant.Item("flgActive") = 1 Then
                    Dim sdeletelnk = "<i Class='fa fa-times' aria-hidden='true' title='Click to remove mapping' style='font-size:15px;cursor:pointer;' PNodeID =" & drParticipant.Item("ParticipantID") & "   onclick='fnDeleteParticipantMapping(this)'></i>"
                    strTable.Append("<td style='text-align:center'>")
                    strTable.Append("<input flgexist='1' flg=0 type=checkbox checked disabled ParticipantID = '" & drParticipant.Item("ParticipantID") & "'>")
                    strTable.Append("</td>")
                    strTable.Append("<td style='text-align:center'>")
                    strTable.Append(sdeletelnk)
                    strTable.Append("</td>")
                Else
                    strTable.Append("<td style='text-align:center'>")
                    strTable.Append("<input flgexist='0' flg=0 type=checkbox  ParticipantID = '" & drParticipant.Item("ParticipantID") & "'>")
                    strTable.Append("</td>")
                    strTable.Append("<td>&nbsp;</td>")
                End If


                strTable.Append("</tr>")

                srlNmCntr = srlNmCntr + 1
            Next drParticipant
            strTable.Append("</tbody>")
            strTable.Append("</table></div>")

        Else
            strTable.Append("<div class='text-danger text-center'>")
            strTable.Append("No Record Found...")
            strTable.Append("</div>")
        End If

        '    strReturnVal = "1@" & HttpContext.Current.Server.HtmlDecode(strTable.ToString)
        strReturnVal = "1@" & strTable.ToString
        Return strReturnVal
    End Function
End Class
