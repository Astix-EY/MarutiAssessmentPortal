
Partial Class frmError
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        Dim EmpCode = Session("EmpCode")
        Dim Name = Session("Name")
        Dim EmailId = Session("EmailId")
        Dim Level = Session("Level")
        Dim AssessmentType = Session("AssessmentType")

        If EmpCode = "" Or EmpCode Is Nothing Then
            spEmpCode.Attributes.Add("class", "clsRed")
            spEmpCode.InnerText = "Employee Code Not Found..."
        Else
            spEmpCode.InnerText = EmpCode
        End If
        If Name = "" Or Name Is Nothing Then
            spName.Attributes.Add("class", "clsRed")
            spName.InnerText = "Name Not Found..."
        Else
            spName.InnerText = Name
        End If
        If EmailId = "" Or EmailId Is Nothing Then
            spEmailId.Attributes.Add("class", "clsRed")
            spEmailId.InnerText = "EmailID Not Found..."
        Else
            spEmailId.InnerText = EmailId
        End If
        If Level = "" Or Level Is Nothing Then
            spLevel.Attributes.Add("class", "clsRed")
            spLevel.InnerText = "Level Not Found..."
        Else
            spLevel.InnerText = Level
        End If
        If AssessmentType = "" Or AssessmentType Is Nothing Then
            spAssessmentType.Attributes.Add("class", "clsRed")
            spAssessmentType.InnerText = "AssessmentType Not Found..."
        Else
            spAssessmentType.InnerText = AssessmentType
        End If

        Session("EmpCode") = ""
        Session("Name") = ""
        Session("EmailId") = ""
        Session("Level") = ""
        Session("AssessmentType") = ""

    End Sub
End Class
