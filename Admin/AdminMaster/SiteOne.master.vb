Imports System.Data.SqlClient

Partial Class Site
    Inherits System.Web.UI.MasterPage
    Dim arrPara(0, 0) As String
    Dim objCon As SqlConnection
    Dim objCom As SqlCommand
    Dim objComm As SqlCommand
    Dim objAdo As New clsConnection.clsConnection
    Dim objDr As SqlDataReader
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)



    End Sub



End Class

