Imports System.Data
Imports System.Data.SqlClient
Imports System.Text
Partial Class L3DirectSales_Task2_CaseProbing
    Inherits System.Web.UI.Page
    Dim ExerciseID As Integer = 0
    Dim BandID As Integer = 0
    Dim ExerciseType As Integer = 0
    Public TimeAllotedSec As Integer = 0
    Dim arrPara(0, 1) As String

    Dim ElapsedTimeMin As Integer = 0
    Dim ElapsedTimeSec As Integer = 0
    Dim TimeAlloted As Integer = 0
    Dim PGNmbr As Integer = 0
    Dim Direction As Integer = 0
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        hdnToolID.Value = IIf(IsNothing(Request.QueryString("ToolID")), 0, Request.QueryString("ToolID"))
        hdnExerciseID.Value = IIf(IsNothing(Request.QueryString("ExerciseID")), 0, Request.QueryString("ExerciseID"))
        BandID = IIf(IsNothing(Request.QueryString("BandID")), 0, Request.QueryString("BandID"))
        ExerciseType = IIf(IsNothing(Request.QueryString("ExerciseType")), 0, Request.QueryString("ExerciseType"))

        PGNmbr = IIf(IsNothing(Request.QueryString("PGNmbr")), 0, Request.QueryString("PGNmbr"))
        hdnRspID.Value = IIf(IsNothing(Request.QueryString("RspID")), 0, Request.QueryString("RspID"))
        hdnLoginID.Value = IIf(IsNothing(Request.QueryString("intLoginID")), 0, Request.QueryString("intLoginID"))
    End Sub
    Private Sub btnStartENG_Click(sender As Object, e As EventArgs) Handles btnStartENG.Click
        Response.Redirect("frmQusetionnaire.aspx?MenuId=8" & "&ExerciseID=" & hdnExerciseID.Value & "&RspID=" & hdnRspID.Value & "&BandID=2" & "&intLoginID=" & hdnLoginID.Value & "&ToolID=" & hdnToolID.Value)
    End Sub
    Private Sub btnStartINDO_Click(sender As Object, e As EventArgs) Handles btnStartINDO.Click
        Response.Redirect("../Questionnaire/frmQusetionnaire.aspx?MenuId=8" & "&ExerciseID=7" & "&RspID=" & hdnRspID.Value & "&BandID=4" & "&intLoginID=" & hdnLoginID.Value)
    End Sub
    Private Sub btnStartSIN_Click(sender As Object, e As EventArgs) Handles btnStartSIN.Click
        Response.Redirect("../Questionnaire/frmQusetionnaire.aspx?MenuId=8" & "&ExerciseID=7" & "&RspID=" & hdnRspID.Value & "&BandID=4" & "&intLoginID=" & hdnLoginID.Value)
    End Sub
    Private Sub btnStartTAMIL_Click(sender As Object, e As EventArgs) Handles btnStartTAMIL.Click
        Response.Redirect("../Questionnaire/frmQusetionnaire.aspx?MenuId=8" & "&ExerciseID=7" & "&RspID=" & hdnRspID.Value & "&BandID=4" & "&intLoginID=" & hdnLoginID.Value)
    End Sub
End Class
