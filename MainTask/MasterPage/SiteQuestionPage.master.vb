Imports System.Data
Imports System.Data.SqlClient
Imports System.Text

Partial Class Site
    Inherits System.Web.UI.MasterPage
    Dim arrPara(0, 0) As String
    Dim objCon As SqlConnection
    Dim objCom As SqlCommand
    Dim objComm As SqlCommand
    Dim objAdo As New clsConnection.clsConnection
    Dim objDr As SqlDataReader
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        hdnAssmntType.Value = Session("AssessmentType")
        hdnLngID.Value = Session("SelectedLngID")
        'fnfillLanguage(hdnAssmntType.Value)
    End Sub
    Private Sub fnfillLanguage(ByVal BandId As Integer)

        Dim Scon As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("strConn").ConnectionString)
        Dim Scmd As SqlCommand = New SqlCommand()
        Scmd.Connection = Scon
        Scmd.CommandText = "spFillDropDownForLanguage"
        Scmd.Parameters.Add("@BandId", SqlDbType.Int).Value = BandId
        Scmd.CommandType = CommandType.StoredProcedure
        Scmd.CommandTimeout = 0
        Dim Sdap As SqlDataAdapter = New SqlDataAdapter(Scmd)
        Dim dt As DataTable = New DataTable()
        Sdap.Fill(dt)
        Dim itm As ListItem = New ListItem()
        itm.Text = "- Language  -"
        itm.Value = "0"
        ddlLanguage.Items.Add(itm)

        For Each dr As DataRow In dt.Rows
            ' If dr("LngID") = 6 Then
            itm = New ListItem()
            itm.Text = dr("Descr").ToString()
            itm.Value = dr("LngID").ToString()
            '   itm.Selected = True
            ddlLanguage.Items.Add(itm)
            '   End If

        Next
    End Sub
    'Protected Sub lnkLogout_Click(sender As Object, e As EventArgs) Handles lnkLogout.Click
    '    Response.Redirect("~/CommonFolder/Logout/frmLogout.aspx")
    'End Sub
End Class

