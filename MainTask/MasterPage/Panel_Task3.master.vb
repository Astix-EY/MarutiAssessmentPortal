Imports System.Data
Imports System.Data.SqlClient
Imports System.Text
Partial Class Data_MasterPage_Panel
    Inherits System.Web.UI.MasterPage
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        hdnToolID.Value = Request.QueryString("ToolID")

        hdnExerciseID.Value = Request.QueryString("ExerciseID")
        hdnRspId.Value = Request.QueryString("RspID")
        hdnLoginID.Value = Request.QueryString("intLoginID")

        hdnMenuId.Value = Request.QueryString("MenuId")
        hdnAssmntType.Value = Session("AssessmentType")
        hdnFlagPageToOpen.Value = Session("flgPageToOpen")
        hdnLngID.Value = Session("SelectedLngID")
        hdnAssmntType.Value = 4
        fnfillLanguage(hdnAssmntType.Value)
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
End Class

