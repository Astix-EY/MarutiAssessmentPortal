<%@ Page Title="" Language="VB" MasterPageFile="~/Task/MasterPage/Site.master" AutoEventWireup="false" CodeFile="Instructions.aspx.vb" Inherits="Data_Information_Instructions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#rolehead").css("display", "none");
            $("#liBackground").css("display", "none");
            //  debugger;

            fnChangeDataBasedOnLanguage(1)
        })

    </script>

    <script type="text/javascript">
        function fnChangeDataBasedOnLanguage(X) {
            var LngID = $("#hdnLngID").val();

            if (X == 2) {
                var LngID = $("#ddlLanguage").val();
                $("#hdnLngID").val(LngID);
            }
            // fnChangeDataOnPanelPage()

            if (LngID == "2") {
                $("#btnBack").html("Kembali");
                $("#hdnWelcome").html("SELAMAT DATANG DI FASTFORWARD!")
                $("#dvSectionIndonesia").show();
                $("#dvSectionEng").hide();
                $("#dvSectionSinhala").hide();
                $("#dvSectionTamil").hide();
                $("#ConatntMatter_btnSubmit").val("Selanjutnya")

            }
            else if (LngID == "3") {
                $("#btnBack").html("ආපසු");
                $("#hdnWelcome").html("Welcome to Assessment !")
                $("#dvSectionSinhala").show();
                $("#dvSectionIndonesia").hide();
                $("#dvSectionEng").hide();
                $("#dvSectionTamil").hide();
                $("#ConatntMatter_btnSubmit").val("ඊළඟ")

            }

            else if (LngID == "1") {
                $("#btnBack").html("மீண்டும்");
                $("#hdnWelcome").html("Welcome to Assessment !")
                $("#dvSectionTamil").show();
                $("#dvSectionIndonesia").hide();
                $("#dvSectionSinhala").hide();
                $("#dvSectionEng").hide();
                $("#ConatntMatter_btnSubmit").val("அடுத்து")

            }

            else {
                $("#btnBack").html("Back");
                $("#hdnWelcome").html("INSTRUCTIONS")

                $("#dvSectionEng").show();
                $("#dvSectionIndonesia").hide();
                $("#dvSectionSinhala").hide();
                $("#dvSectionTamil").hide();
                $("#ConatntMatter_btnSubmit").val("Next")

            }

            if (X == 2) {
                $('#dvLanguage').dialog('close');
            }

            PageMethods.fnSetSession(LngID, fnUpdateSessionSuccess, fnUpdateSessionFailed);

        }
        function fnUpdateSessionSuccess(result) {

        }
        function fnUpdateSessionFailed(result) {
            //    alert(result._message);
        }

    </script>


    <script type="text/javascript">
        function openPopup(el) {
            var LngID = $("#hdnLngID").val();
            //  alert(LngID)
            //  alert(el)
            if ($('#' + el).attr("flg") == "1") {
                $('.modal').hide();
                $('#' + el).fadeIn(200);

                if (LngID == "2") {
                    if (el == "divInd1") {
                        $("#hdnDiv1").val(1);
                    }
                    else if (el == "divInd2") {
                        $("#hdnDiv1").val(2);
                    }
                    else if (el == "divInd3") {
                        $("#hdnDiv1").val(3);
                    }
                }
                else if (LngID == "3") {
                    if (el == "divSinhala1") {
                        $("#hdnDiv1").val(1);
                    }
                    else if (el == "divSinhala2") {
                        $("#hdnDiv1").val(2);
                    }
                    else if (el == "divSinhala3") {
                        $("#hdnDiv1").val(3);
                    }
                }

                else if (LngID == "1") {
                    if (el == "divTamil1") {
                        $("#hdnDiv1").val(1);
                    }
                    else if (el == "divTamil2") {
                        $("#hdnDiv1").val(2);
                    }
                    else if (el == "divTamil3") {
                        $("#hdnDiv1").val(3);
                    }
                }

                else {
                    if (el == "div1") {
                        $("#hdnDiv1").val(1);
                    }
                    else if (el == "div2") {
                        $("#hdnDiv1").val(2);
                    }
                    else if (el == "div3") {
                        $("#hdnDiv1").val(3);
                    }
                }

            }
            else {
                alert("Please, Watch the Instruction in Order !");
            }
        }

        function closePopup() {
            var LngID = $("#hdnLngID").val();


            $('.modal').fadeOut(300);

            if (LngID == "2")   // Indonesia
            {
                if ($("#hdnDiv1").val() == 1) {
                    if ($('#divInd2').attr("flg") == "0") {
                        $('div#dvInd2').removeClass("disabled");
                    }
                    $('#divInd2').attr("flg", "1");
                }
                else if ($("#hdnDiv1").val() == 2) {
                    if ($('#divInd3').attr("flg") == "0") {
                        $('div#dvInd3').removeClass("disabled");
                    }
                    $('#divInd3').attr("flg", "1");
                }
                else if ($("#hdnDiv1").val() == 3) {
                    //  $("#ConatntMatter_btnNext").css("display", "block");
                    $("#ConatntMatter_btnSubmit").css("display", "inline-block");
                }

            }
            else if (LngID == "3")   // Sinhala
            {
                if ($("#hdnDiv1").val() == 1) {
                    if ($('#divSinhala2').attr("flg") == "0") {
                        $('div#dvSinhala2').removeClass("disabled");
                    }
                    $('#divSinhala2').attr("flg", "1");
                }
                else if ($("#hdnDiv1").val() == 2) {
                    if ($('#divSinhala3').attr("flg") == "0") {
                        $('div#dvSinhala3').removeClass("disabled");
                    }
                    $('#divSinhala3').attr("flg", "1");
                }
                else if ($("#hdnDiv1").val() == 3) {
                    //  $("#ConatntMatter_btnNext").css("display", "block");
                    $("#ConatntMatter_btnSubmit").css("display", "inline-block");
                }

            }

            else if (LngID == "1")   // Tamil
            {
                if ($("#hdnDiv1").val() == 1) {
                    if ($('#divTamil2').attr("flg") == "0") {
                        $('div#dvTamil2').removeClass("disabled");
                    }
                    $('#divTamil2').attr("flg", "1");
                }
                else if ($("#hdnDiv1").val() == 2) {
                    if ($('#divTamil3').attr("flg") == "0") {
                        $('div#dvTamil3').removeClass("disabled");
                    }
                    $('#divTamil3').attr("flg", "1");
                }
                else if ($("#hdnDiv1").val() == 3) {
                    //  $("#ConatntMatter_btnNext").css("display", "block");
                    $("#ConatntMatter_btnSubmit").css("display", "inline-block");
                }

            }
            else {

                if ($("#hdnDiv1").val() == 1) {
                    if ($('#div2').attr("flg") == "0") {
                        $('div#dv2').removeClass("disabled");
                    }
                    $('#div2').attr("flg", "1");
                }
                else if ($("#hdnDiv1").val() == 2) {
                    if ($('#div3').attr("flg") == "0") {
                        $('div#dv3').removeClass("disabled");
                    }
                    $('#div3').attr("flg", "1");
                }
                else if ($("#hdnDiv1").val() == 3) {
                    //  $("#ConatntMatter_btnNext").css("display", "block");
                    $("#ConatntMatter_btnSubmit").css("display", "inline-block");
                }

            }

        }
        //$(document).ready(function () { });
    </script>
    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "Welcome.aspx";
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="container">
        <div class="position-relative mb-5">
            <div class="back-btn">
                <a href="##" class="" onclick="fnGoBack()" id="btnBack"><i class="fa fa-arrow-left"></i>&nbsp;Back</a>
            </div>
            <div class="section-title">
                <h3 class="text-center" id="hdnWelcome">INSTRUCTIONS</h3>
                <div class="title-line-center"></div>
            </div>
        </div>
        <!---- English--------------->
        <div class="section-content" id="dvSectionEng">
            <div class="row absolute-center">
                <div class="col-sm-6 col-md-4">
                    <div id="dv1" class="panel-box panel-box-default" onclick="openPopup('div1');">
                        <%--<div class="panel-box-title" style="background-image: url('../../Images/instr-1.png')">--%>
                        <div class="panel-box-title">
                            <img src="../../Images/instr-1.png" />
                            <div class="panel-box-title-text">Step 1</div>
                        </div>
                        <div class="panel-footer">
                            What to expect from the<br />
                            Competency Development Inventory
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4">
                    <div id="dv2" class="panel-box panel-box-default disabled" onclick="openPopup('div2');">
                        <%--<div class="panel-box-title" style="background-image: url('../../Images/instr-2.png')">--%>
                        <div class="panel-box-title">
                            <img src="../../Images/instr-2.png" />
                            <div class="panel-box-title-text">Step 2</div>
                        </div>
                        <div class="panel-footer">
                            Instructions to set you up<br />
                            for success
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4">
                    <div id="dv3" class="panel-box panel-box-default disabled" onclick="openPopup('div3');">
                        <%--<div class="panel-box-title" style="background-image: url('../../Images/instr-3.png')">--%>
                        <div class="panel-box-title">
                            <img src="../../Images/instr-1.png" />
                            <div class="panel-box-title-text">Step 3</div>
                        </div>
                        <div class="panel-footer">
                            Quick tips to enhance your<br />
                            effectiveness
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!----- End English------------->

        <!---- Indonesia--------------->
        <div class="section-content" id="dvSectionIndonesia" style="display: none">
            <div class="row absolute-center">
                <div class="col-sm-6 col-md-4">
                    <div id="dvInd1" class="panel-box panel-box-default" onclick="openPopup('divInd1');">
                        <div class="box-title" style="background-image: url('../../Images/instr-1.png')">
                            <div class="box-title-text">Langkah 1</div>
                        </div>
                        <div class="panel-footer">
                            APA YANG HARUS DIHARAPKAN DARI ALAT<br />
                            INVENTARISASI PENGEMBANGAN KOMPETENSI
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4">
                    <div id="dvInd2" class="panel-box panel-box-default disabled" onclick="openPopup('divInd2');">
                        <div class="box-title" style="background-image: url('../../Images/instr-2.png')">
                            <div class="box-title-text">Langkah 2</div>
                        </div>
                        <div class="panel-footer">
                            INSTRUKSI UNTUK MEMPERSIAPKAN
                            <br />
                            KESUKSESAN ANDA

                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4">
                    <div id="dvInd3" class="panel-box panel-box-default disabled" onclick="openPopup('divInd3');">
                        <div class="box-title" style="background-image: url('../../Images/instr-3.png')">
                            <div class="box-title-text">Langkah 3</div>
                        </div>
                        <div class="panel-footer">
                            KIAT CEPAT UNTUK MENINGKATKAN
                            <br />
                            EFEKTIVITAS ANDA 

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!----- End Indonesia------------->

        <!---- Sinhala--------------->
        <div class="section-content" id="dvSectionSinhala" style="display: none">
            <div class="row absolute-center">
                <div class="col-sm-6 col-md-4">
                    <div id="dvSinhala1" class="panel-box panel-box-default" onclick="openPopup('divSinhala1');">
                        <div class="box-title" style="background-image: url('../../Images/instr-1.png')">
                            <div class="box-title-text">படி 1</div>
                        </div>
                        <div class="panel-footer">
                            இருந்து என்ன எதிர்பார்க்க வேண்டும்<br />
                            கருவி
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4">
                    <div id="dvSinhala2" class="panel-box panel-box-default disabled" onclick="openPopup('divSinhala2');">
                        <div class="box-title" style="background-image: url('../../Images/instr-2.png')">
                            <div class="box-title-text">படி 2</div>
                        </div>
                        <div class="panel-footer">
                            உங்களை அமைப்பதற்கான வழிமுறைகள்<br />
                            வெற்றிக்காக
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4">
                    <div id="dvSinhala3" class="panel-box panel-box-default disabled" onclick="openPopup('divSinhala3');">
                        <div class="box-title" style="background-image: url('../../Images/instr-3.png')">
                            <div class="box-title-text">படி 3</div>
                        </div>
                        <div class="panel-footer">
                            உங்கள் மேம்படுத்த விரைவான உதவிக்குறிப்புகள்<br />
                            செயல்திறன்
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!----- End Sinhala------------->

        <!---- Tamil--------------->
        <div class="section-content" id="dvSectionTamil" style="display: none;">
            <div class="row absolute-center">
                <div class="col-sm-6 col-md-4">
                    <div id="dvTamil1" class="panel-box panel-box-default" onclick="openPopup('divTamil1');">
                        <div class="box-title" style="background-image: url('../../Images/instr-1.png')">
                            <div class="box-title-text">Step 1</div>
                        </div>
                        <div class="panel-footer">
                            இே்ேருவியிடம்(tool)<br />
                            எதிர்பாே்ேப்படே்கூ<br />
                            <br />
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4">
                    <div id="dvTamil2" class="panel-box panel-box-default disabled" onclick="openPopup('divTamil2');">
                        <div class="box-title" style="background-image: url('../../Images/instr-2.png')">
                            <div class="box-title-text">Step 2</div>
                        </div>
                        <div class="panel-footer">
                            பவற்றி பபறுவதற்ோை<br />
                            அறிவுறுத்தல்ேள்<br />
                            <br />
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4">
                    <div id="dvTamil3" class="panel-box panel-box-default disabled" onclick="openPopup('divTamil3');">
                        <div class="box-title" style="background-image: url('../../Images/instr-3.png')">
                            <div class="box-title-text">Step 3</div>
                        </div>
                        <div class="panel-footer">
                            உங்ேள் பெயல்திறயை<br />
                            கமம்படுத்துவதற்ோை<br />
                            உதவிே்குறிப்புேள்
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!----- End Tamil------------->

        <div class="m-t-25 text-center clearfix">
            <asp:Button ID="btnSubmit" runat="server" CssClass="btns btn-submit" Text="Next" OnClick="btnSubmit_Click" Style="display: none;" />
        </div>
    </div>
    <!-----English-------------->
    <div class="modal" id="div1" role="dialog" flg="1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">What to expect from the competency development inventory</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25">
                    <ul>
                        <li>The Competency Development Inventory will help you identify the areas that you can focus on while creating your development journey.</li>
                        <li>You will go through a set of scenarios that you will need to respond to. The background information tab (if present) will provide you with relevant information that will help you navigate the scenarios effectively</li>
                        <li>The individual scenarios may have a separate preparation time and separate response time which will reflect in the relevant sections.</li>
                        <li>You will need to complete all assessments within the indicated timelines.</li>
                        <li>We request you to be mindful of the timer as it will continue to run down once a task has been initiated.</li>
                        <li>If you need any support during the assessment, you can reach out to the email ID mentioned in the tech support icon visible in the top right corner of the screen.</li>
                    </ul>
                    <div class="mb-3 text-center">
                        <input type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="div2" role="dialog" flg="0">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Competency Development Inventory guidelines:</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25 section">
                    <ul>
                        <li>You will be asked to take varied simulations which may involve working by yourself, working in teams or working in other interactive environments.</li>
                        <li>You may face situations where you may not have all the required information. In such a case, you are advised to make relevant assumptions. However, please do not create information that contrasts with the background information already provided.</li>

                    </ul>
                    <div class="mb-3 text-center">
                        <input type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="div3" role="dialog" flg="0">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Quick tips to enhance your effectiveness</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25 section">
                    <ul>
                        <li>You are required to consider all given information while responding to the simulations.</li>
                        <li>Do not overthink your responses and keep it realistic to reflect how you would operate in similar work environments.</li>
                        <li>There may or may not be a right or wrong answer to the given situations and therefore feel free to leverage your personal experiences while responding to the simulations.</li>

                    </ul>
                    <div class="mb-3 text-center">
                        <input type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>
                <%-- <div class="modal-body section">
                    <h3 class="small-heading">Be Your True Self</h3>
                    <p class="m-b-25">While you are to perform the responsibilities of the role assigned, you must still be yourself. Behave the way you would behave in usual workplace situations.</p>
                    <h3 class="small-heading">There are no right or wrong answers</h3>
                    <p class="m-b-25">There are multiple effective approaches you can take to deal with any situation. Also, there is no Pass or Fail declaration (or certification) and no right or wrong answer.</p>
                    <h3 class="small-heading">Express and Explain yourself fully</h3>
                    <p>For facilitators to understand your perspective and intent fully, you are advised to respond clearly elaborating upon your thought process. Keep your responses as detailed as possible.</p>
                    <div class="mb-3 text-center">
                        <input id="Button3" type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
    <!-----End English-------------->
    <!-----Indonesia-------------->

    <div class="modal" id="divInd1" role="dialog" flg="1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">What to expect from the Competency Development Inventory Tool?</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25">
                    <ul>
                        <li>The Competency Development Inventory tool will help you identify the key areas that you can focus on while creating your development journey.</li>
                        <li>The tool will take you through a series of questions which you will have to answer using the background information provided in the case. The questions will appear in the form of judgement-based scenarios.</li>
                        <li>You will be assuming a specific role in the simulation and details of your role and situation are provided to you as a part of the background information.  </li>
                        <li>You would be given some preparation time and will be required to answer within an assigned time.</li>
                        <li>Once you read and understand the question, you will need to select or drag and drop the best answer.</li>
                        <li>You will have to complete the 4 sections of the Capability Development Inventory within a pre-defined time.</li>
                        <li>The overall duration of the entire tool will be approximately 2 hours.</li>
                    </ul>
                    <div class="mb-3 text-center">
                        <input type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="divInd2" role="dialog" flg="0">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Competency Development Inventory tool guidelines:</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25 section">
                    <ul>
                        <li>Every question that you are asked to complete in the tool must be addressed by you and cannot be ignored or cancelled.</li>
                        <li>The tool is being administered in a proctored environment to ensure authenticity of participants. You will be required to enable your camera before proceeding with the assessment.</li>
                        <li>You may face situations where you may not have all the required information. In such a case, you are advised to make relevant assumptions. However, please do not create information that contrasts with the background information already provided.</li>

                    </ul>
                    <div class="mb-3 text-center">
                        <input type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="divInd3" role="dialog" flg="0">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Quick tips to enhance your effectiveness</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25 section">
                    <ul>
                        <li>Select the best possible response from the list of choices based on your experience of having dealt with similar situations.</li>
                        <li>There are no right or wrong answers to the questions. Your approach will be evaluated in the given situation.</li>
                        <li>Please read through the example provided carefully to understand the expectation from you.</li>

                    </ul>
                    <div class="mb-3 text-center">
                        <input type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>
                <%-- <div class="modal-body section">
                    <h3 class="small-heading">Be Your True Self</h3>
                    <p class="m-b-25">While you are to perform the responsibilities of the role assigned, you must still be yourself. Behave the way you would behave in usual workplace situations.</p>
                    <h3 class="small-heading">There are no right or wrong answers</h3>
                    <p class="m-b-25">There are multiple effective approaches you can take to deal with any situation. Also, there is no Pass or Fail declaration (or certification) and no right or wrong answer.</p>
                    <h3 class="small-heading">Express and Explain yourself fully</h3>
                    <p>For facilitators to understand your perspective and intent fully, you are advised to respond clearly elaborating upon your thought process. Keep your responses as detailed as possible.</p>
                    <div class="mb-3 text-center">
                        <input id="Button3" type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>--%>
            </div>
        </div>
    </div>

    <!-----End Indonesia-------------->

    <!-----Sinhala-------------->
    <div class="modal" id="divSinhala1" role="dialog" flg="1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">What to expect from the Competency Development Inventory Tool?</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25">
                    <ul>
                        <li>The Competency Development Inventory tool will help you identify the key areas that you can focus on while creating your development journey.</li>
                        <li>The tool will take you through a series of questions which you will have to answer using the background information provided in the case. The questions will appear in the form of judgement-based scenarios.</li>
                        <li>You will be assuming a specific role in the simulation and details of your role and situation are provided to you as a part of the background information.  </li>
                        <li>You would be given some preparation time and will be required to answer within an assigned time.</li>
                        <li>Once you read and understand the question, you will need to select or drag and drop the best answer.</li>
                        <li>You will have to complete the 4 sections of the Capability Development Inventory within a pre-defined time.</li>
                        <li>The overall duration of the entire tool will be approximately 2 hours.</li>
                    </ul>
                    <div class="mb-3 text-center">
                        <input type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="divSinhala2" role="dialog" flg="0">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Competency Development Inventory tool guidelines:</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25 section">
                    <ul>
                        <li>Every question that you are asked to complete in the tool must be addressed by you and cannot be ignored or cancelled.</li>
                        <li>The tool is being administered in a proctored environment to ensure authenticity of participants. You will be required to enable your camera before proceeding with the assessment.</li>
                        <li>You may face situations where you may not have all the required information. In such a case, you are advised to make relevant assumptions. However, please do not create information that contrasts with the background information already provided.</li>

                    </ul>
                    <div class="mb-3 text-center">
                        <input type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="divSinhala3" role="dialog" flg="0">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Quick tips to enhance your effectiveness</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25 section">
                    <ul>
                        <li>Select the best possible response from the list of choices based on your experience of having dealt with similar situations.</li>
                        <li>There are no right or wrong answers to the questions. Your approach will be evaluated in the given situation.</li>
                        <li>Please read through the example provided carefully to understand the expectation from you.</li>

                    </ul>
                    <div class="mb-3 text-center">
                        <input type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>
                <%-- <div class="modal-body section">
                    <h3 class="small-heading">Be Your True Self</h3>
                    <p class="m-b-25">While you are to perform the responsibilities of the role assigned, you must still be yourself. Behave the way you would behave in usual workplace situations.</p>
                    <h3 class="small-heading">There are no right or wrong answers</h3>
                    <p class="m-b-25">There are multiple effective approaches you can take to deal with any situation. Also, there is no Pass or Fail declaration (or certification) and no right or wrong answer.</p>
                    <h3 class="small-heading">Express and Explain yourself fully</h3>
                    <p>For facilitators to understand your perspective and intent fully, you are advised to respond clearly elaborating upon your thought process. Keep your responses as detailed as possible.</p>
                    <div class="mb-3 text-center">
                        <input id="Button3" type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
    <!-----End Sinhala-------------->

    <!-----Tamil-------------->
    <div class="modal" id="divTamil1" role="dialog" flg="1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">What to expect from the Competency Development Inventory Tool?</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25">
                    <ul>
                        <li>The Competency Development Inventory tool will help you identify the key areas that you can focus on while creating your development journey.</li>
                        <li>The tool will take you through a series of questions which you will have to answer using the background information provided in the case. The questions will appear in the form of judgement-based scenarios.</li>
                        <li>You will be assuming a specific role in the simulation and details of your role and situation are provided to you as a part of the background information.  </li>
                        <li>You would be given some preparation time and will be required to answer within an assigned time.</li>
                        <li>Once you read and understand the question, you will need to select or drag and drop the best answer.</li>
                        <li>You will have to complete the 4 sections of the Capability Development Inventory within a pre-defined time.</li>
                        <li>The overall duration of the entire tool will be approximately 2 hours.</li>
                    </ul>
                    <div class="mb-3 text-center">
                        <input type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="divTamil2" role="dialog" flg="0">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Competency Development Inventory tool guidelines:</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25 section">
                    <ul>
                        <li>Every question that you are asked to complete in the tool must be addressed by you and cannot be ignored or cancelled.</li>
                        <li>The tool is being administered in a proctored environment to ensure authenticity of participants. You will be required to enable your camera before proceeding with the assessment.</li>
                        <li>You may face situations where you may not have all the required information. In such a case, you are advised to make relevant assumptions. However, please do not create information that contrasts with the background information already provided.</li>

                    </ul>
                    <div class="mb-3 text-center">
                        <input type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="divTamil3" role="dialog" flg="0">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Quick tips to enhance your effectiveness</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25 section">
                    <ul>
                        <li>Select the best possible response from the list of choices based on your experience of having dealt with similar situations.</li>
                        <li>There are no right or wrong answers to the questions. Your approach will be evaluated in the given situation.</li>
                        <li>Please read through the example provided carefully to understand the expectation from you.</li>

                    </ul>
                    <div class="mb-3 text-center">
                        <input type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>
                <%-- <div class="modal-body section">
                    <h3 class="small-heading">Be Your True Self</h3>
                    <p class="m-b-25">While you are to perform the responsibilities of the role assigned, you must still be yourself. Behave the way you would behave in usual workplace situations.</p>
                    <h3 class="small-heading">There are no right or wrong answers</h3>
                    <p class="m-b-25">There are multiple effective approaches you can take to deal with any situation. Also, there is no Pass or Fail declaration (or certification) and no right or wrong answer.</p>
                    <h3 class="small-heading">Express and Explain yourself fully</h3>
                    <p>For facilitators to understand your perspective and intent fully, you are advised to respond clearly elaborating upon your thought process. Keep your responses as detailed as possible.</p>
                    <div class="mb-3 text-center">
                        <input id="Button3" type="button" value="Next" class="btns btn-submit" onclick="closePopup();" />
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
    <!-----End Tamil-------------->

    <input type="hidden" id="hdnDiv1" value="0" />
    <input type="hidden" id="hdnDiv2" value="0" />
    <input type="hidden" id="hdnDiv3" value="0" />
    <input type="hidden" name="ctl00$hdnRole" id="hdnRole" value="1" />

</asp:Content>

