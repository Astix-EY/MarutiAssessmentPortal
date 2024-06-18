<%@ Page Title="" Language="VB" MasterPageFile="~/DataB/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="TaskExample.aspx.vb" Inherits="Data_Exercise_TaskExample" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../../Scripts/jquery-ui.js"></script>


    <style type="text/css">
        .ml_2 {
            margin-left: -2px;
        }

        .ques-panel,
        .ques-panel-no,
        .ans-panel-no,
        .priority-heading,
        .priority-heading_sub,
        .ans-panel,
        .ans-panel-box > p {
            border: 1px solid #808080;
            text-align: center;
        }

        .ques-panel {
            color: #FFF;
            background: #808080;
            margin-bottom: 5px;
            padding: 5px;
            font-size: .75rem;
            padding-left: 15px !important;
            min-height: 50px;
            position: relative;
        }

        .ques-panel-no,
        .ans-panel-no {
            display: inline-block;
            width: 28px;
            height: 28px;
            line-height: 28px;
            border-radius: 50%;
            background: #00A3AE;
            color: #FFF;
            font-weight: 600;
        }

        .ques-panel-no {
            position: absolute;
            top: 0;
            left: -12px;
            margin-top: 10px;
        }

        .priority-heading {
            background: #FFC000;
            padding: 6px;
            color: #000;
            margin-bottom: 5px;
        }

        .priority-heading_sub {
            background: #F2F2F2;
            padding: 6px;
            font-size: .7rem;
            color: #000;
            min-height: 48px;
        }

        .ans-panel-box {
            position: relative;
            display: block;
            margin-top: 5px;
        }

        .ans-panel {
            width: 50px;
            position: absolute;
            right: 0;
            top: 0;
        }

        .ans-panel-box > p {
            margin-right: 55px;
            padding: 10px;
            font-size: .7rem;
            margin-bottom: 0;
        }

        .ans-panel,
        .ans-panel-box > p {
            min-height: 106px;
            display: -webkit-box !important;
            display: -ms-flexbox !important;
            display: flex !important;
            -webkit-box-pack: center !important;
            -ms-flex-pack: center !important;
            justify-content: center !important;
            -webkit-box-align: center !important;
            -ms-flex-align: center !important;
            align-items: center !important;
        }

        /*ul.no-list{
            margin:0;
            margin-left: 10px;
            padding:0;
            list-style:none;
            counter-reset: step;
        }
        ul.no-list > li{            
            position: relative;
            padding: 5px 20px;
            background: #808080;
            margin-bottom: 4px;
        }

        ul.no-list > li::before {
            content: counter(step);
            counter-increment: step;
            position: absolute;
            left: -10px;
            top: 5px;
            width: 22px;
            height: 22px;
            line-height: 22px;
            border-radius: 50%;
            background:#194597;
            color:#FFF;
            display: inline-block;
            text-align: center;
        }*/

        /*.box {
            width: 33.33333333%;
            float: left;
            position: relative;
            min-height: 1px;
            padding: 0 8px;
            margin: 5px 0;
        }
        .box > .box-header{
            background:#194597;
            padding: 10px 15px;   
            color:#FFF;         
            font-weight:600;
            text-transform:uppercase;
            text-align:center;
            border-radius: 6px 6px 0 0;
        }

         .box > .box-body {
            background-color: rgba(86,61,124,.1);
            border: 1px solid #194597;
            min-height: 220px;
            padding: 0 5px 0 28px;
            position: relative;
            border-radius: 0 0 6px 6px;
            -moz-border-radius: 0 0 6px 6px;
            -webkit-border-radius: 0 0 6px 6px;
        }*/

        /*.clsQstDropableMain{
            border: 1px solid #194597; 
            min-height: 100px;
            counter-reset: step;
            padding:10px;
             border-radius: 6px;
            -moz-border-radius: 6px;
            -webkit-border-radius: 6px;
        }

        .clsQstDropableMain > .clsdivdraggable {
            width:48%;
            float:left;
            cursor: pointer;
            position: relative;
            margin-bottom:5px;
            margin-left: 12px;
            margin-right: 4px;
            border: 1px solid #AAA; 
            padding: 5px;
            padding-left:15px !important;
            font-size:.75rem;
            background: #dee9ff;
        }
        span.spn{
            width: 22px;
            height: 22px;
            line-height: 22px;
            border-radius: 50%;
            background:#194597;
            color:#FFF;
            display: inline-block;
            text-align: center;
            margin-left: -28px;
            margin-right: 6px;
        }*/
        /*.clsQstDropableMain > .clsdivdraggable::before {
            content: counter(step);
            counter-increment: step;
            position: absolute;
            left: -26px;
            top: 5px;
            width: 22px;
            height: 22px;
            line-height: 22px;
            border-radius: 50%;
            background:#194597;
            color:#FFF;
            display: inline-block;
            text-align: center;
        }*/
    </style>
    <script>
        $(function () {
            $(".clsdivdraggable").draggable({
                start: function (event, ui) {
                    $(ui.helper).css({ width: "230px", "border": "1px solid #194597", "padding": "5px", "color": "black", cursor: "move" });
                    $(this).data("startingScrollTop", window.pageYOffset);

                },
                drag: function (event, ui) {
                    // if (navigator.appName == "Microsoft Internet Explorer") {
                    var st = parseInt($(this).data("startingScrollTop"));
                    ui.position.top -= st;
                    // }
                },
                appendTo: "body",
                helper: "clone",
                cursor: "move",
                revert: "invalid"
            });

            $(".clsdivdroppable").droppable({
                activeClass: 'droppable-active',
                hoverClass: 'droppable-hover',
                over: function (event, ui) {
                    //var $this = $(this);
                },
                drop: function (event, ui) {
                    if ($(this).children().length == $(this).data("max")) {
                        return false;
                    }
                    $(ui.draggable).css({ top: 0, left: 0, bottom: 0, "border-color": "transparent", "margin-bottom": "4px", "padding": "4px", width: "100%", "font-size": ".75rem", "color": "black" }).appendTo(this);
                }
            });

        });

    </script>

    <script type="text/javascript">
        (function ($) {
            $.fn.blink = function (options) {
                var defaults = {
                    delay: 500
                };
                var options = $.extend(defaults, options);
                var obj = $(this);
                setInterval(function () {
                    $(obj).fadeOut().fadeIn();
                }, options.delay);
            }

        }(jQuery))


    </script>

    <script type="text/javascript">

        function fnChangeDataBasedOnLanguage(X) {
            var LngID = $("#hdnLngID").val();

            if (X == 2) {
                var LngID = $("#ddlLanguage").val();
                $("#hdnLngID").val(LngID);
            }

            fnChangeDataOnPanelPage()

            if (LngID == "1") {
                $(".priority-heading_sub").css("height", "90px");
                $(".ans-panel, .ans-panel-box > p").css("height", "220px");
                $(".ques-panel").css("height", "85px");

                $("#dvTamil").show();
                $("#dvSinhala").hide();
                $("#dvIndonesia").hide();
                $("#dvEnglish").hide();
            }

            else if (LngID == "2") {
                $(".priority-heading_sub").css("height", "60px");
                $(".ans-panel, .ans-panel-box > p").css("height", "130px");
                $(".ques-panel").css("height", "68px");

                $("#dvIndonesia").show();
                $("#dvEnglish").hide();
                $("#dvSinhala").hide();
                $("#dvTamil").hide();
            }
            else if (LngID == "3") {
                $(".priority-heading_sub").css("height", "82px");
                $(".ans-panel, .ans-panel-box > p").css("height", "158px");
                $(".ques-panel").css("height", "68px");

                $("#dvSinhala").show();
                $("#dvIndonesia").hide();
                $("#dvEnglish").hide();
                $("#dvTamil").hide();
            }

            else {
                $(".priority-heading_sub").css("height", "48px");
                $(".ans-panel, .ans-panel-box > p").css("height", "106px");
                $(".ques-panel").css("height", "50px");

                $("#dvEnglish").show();
                $("#dvIndonesia").hide();
                $("#dvSinhala").hide();
                $("#dvTamil").hide();
            }

            if (X == 2) {
                $('#dvLanguage').dialog('close');
            }

            PageMethods.fnSetSession(LngID, fnUpdateSessionSuccess, fnUpdateSessionFailed);

        }
        //function fnChangeDataBasedOnLanguage(X) {
        //    var LngID = $("#hdnLngID").val();

        //    if (X == 2) {
        //        var LngID = $("#ddlLanguage").val();
        //        $("#hdnLngID").val(LngID);
        //    }

        //    fnChangeDataOnPanelPage()

        //    if (LngID == "2") {

        //        $("#dvIndonesia").show();
        //        $("#dvEnglish").hide();
        //        $("#dvSinhala").hide();
        //        $("#dvTamil").hide();
        //    }
        //    else if (LngID == "3") {

        //        $("#dvSinhala").show();
        //        $("#dvIndonesia").hide();
        //        $("#dvEnglish").hide();
        //        $("#dvTamil").hide();
        //    }
        //    else if (LngID == "1") {
        //        $("#dvTamil").show();
        //        $("#dvSinhala").hide();
        //        $("#dvIndonesia").hide();
        //        $("#dvEnglish").hide();
        //    }

        //    else {
        //        $("#dvEnglish").show();
        //        $("#dvIndonesia").hide();
        //        $("#dvSinhala").hide();
        //        $("#dvTamil").hide();
        //    }

        //    if (X == 2) {
        //        $('#dvLanguage').dialog('close');
        //    }

        //    PageMethods.fnSetSession(LngID, fnUpdateSessionSuccess, fnUpdateSessionFailed);

        //}
        function fnUpdateSessionSuccess(result) {

        }
        function fnUpdateSessionFailed(result) {
            //    alert(result._message);
        }

        function fnMyExercise() {

            window.location.href = "../Exercise/ExerciseMain.aspx?MenuId=8";

        }

    </script>

    <script type="text/javascript">
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
        $(document).ready(function () {

            //if ($("#hdnFlagPageToOpen").val() == "3") {
            //    f1();
            //}
            //else {
            //    $("#theTime").hide();
            //}

            fnChangeDataBasedOnLanguage(1)
        });
        function f1() {

            if (IsUpdateTimer == 0) { return; }
            SecondCounter = parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value);
            if (SecondCounter <= 0) {
                IsUpdateTimer = 0;

                //$("#theTime").addClass("blinkmsg");

                //$('.blinkmsg').blink({
                //    delay: "1500"
                //});


                return;
            }
            SecondCounter = SecondCounter - 1;
            hours = Math.floor(SecondCounter / 3600);
            Minutes = Math.floor((SecondCounter - (hours * 3600)) / 60);
            Seconds = SecondCounter - (hours * 3600) - (Minutes * 60);


            if (Seconds < 10 && Minutes < 10) {
                document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds;
            }
            else if (Seconds < 10 && Minutes > 9) {
                document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + Minutes + ":" + "0" + Seconds;
            }
            else if (Seconds > 9 && Minutes < 10) {
                document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + "0" + Minutes + ":" + Seconds;
            }
            else if (Seconds > 9 && Minutes > 9) {
                document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + Minutes + ":" + Seconds;
            }
            document.getElementById("ConatntMatterRight_hdnCounter").value = SecondCounter;

            if (((hours * 60) + Minutes) == 5 && Seconds == 0) {

                $("#dvDialog")[0].innerHTML = "<center>Reading Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " </center>";
                $("#dvDialog").dialog({
                    title: 'Alert',
                    modal: true,
                    width: '30%',
                    buttons: [{
                        text: "OK",
                        click: function () {
                            $("#dvDialog").dialog("close");
                        }
                    }]
                });

                //   document.getElementById("dvDialog").innerHTML = "<center>Your Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " After that your window will be closed automatically.</center>";
            }

            counter++;
            counterAutoSaveTxt++;
            if (counter == 10) {//Auto Time Update
                counter = 0;

            }
            if (counterAutoSaveTxt == 30) {//Auto Text Save
                counterAutoSaveTxt = 0;

            }

            if (SecondCounter == 0) {
                // alert("Level Complete");
                IsUpdateTimer = 0;
                counter = 0;


                $("#theTime").addClass("blinkmsg");

                $('.blinkmsg').blink({
                    delay: "1500"
                });
                alert("Your scheduled time for reading the background information is over. You will now be redirected to your tasks page. Please start Task 1.");
                if ($("#hdnAssmntType").val() == "1") {
                    window.location.href = "../Exercise/ExerciseMain_L4.aspx?MenuId=8";
                }
                else {
                    window.location.href = "../Exercise/ExerciseMain_L3.aspx?MenuId=8";
                }
                return;
            }
            // }
            setTimeout("f1()", 1000);

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
    <time id="theTime" class="fst-color" style="display: none">Reading Time Left  00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">

    <!------------ English------------------>
    <div id="dvEnglish">
        <div class="section-title">
            <h3 class="text-center">Case Study</h3>
            <div class="title-line-center"></div>
        </div>
        <p><strong>Current Situation<br />
        </strong>Bharat Manufacturing Solutions (BMS) has recently acquired XYZ Manufacturing, a company specializing in advanced robotics for industrial automation. XYZ Manufacturing has a strong R&amp;D team, innovative product line, and a different organizational culture compared to BMS. The acquisition aims to enhance BMS's product offerings and market presence in the industrial automation sector.</p>
        <p><strong><u>Problem Statement:</u></strong><br /> Post-acquisition, BMS faces significant challenges in integrating XYZ Manufacturing into its existing corporate structure. These challenges include cultural misalignment, redundant processes, and systems incompatibility, which could potentially lead to operational inefficiencies, employee dissatisfaction, and a decline in productivity.</p>
        <p><strong><u>Note:</u></strong><br /> BMS has acquired XYZ while the above scenarios and challenges prevail at the organization during integration.&nbsp;&nbsp;</p>
        <p><strong><u>Your Role:</u></strong><br /> You are the CHRO of BMS and are expected to manage the integration of BMS and XYZ in a seamless manner.</p>
        <p><strong><u>Your Task:<br /> </u></strong>In your role, you are supposed to think through the scanarios and select the best possible options.</p>
        <%--      <p>You are scheduled to meet Mustafa to understand his needs as well as build a positive rapport with him. Mustafa has a very busy schedule, hence he expects you to come well prepared for the meeting so that you both can make most out of the meeting time.</p>
        <p>What information will you gather before you go to meet Mr. Mustafa at Sunrise Group? Classify the following as “Most important” “Moderately important” “Least important”</p>

        <div class="row ml_2">
            <div class="col-4">
                <div class="ques-panel"><span class="ques-panel-no">1</span>Look up company website and basic details in annual statements</div>
                <div class="ques-panel"><span class="ques-panel-no">4</span>Get more information on sector and business outlook</div>
            </div>
            <div class="col-4">
                <div class="ques-panel"><span class="ques-panel-no">2</span>Talk to your manager as well as colleagues and prepare with them for your meeting</div>
                <div class="ques-panel"><span class="ques-panel-no">5</span>Look up profile of Mr. Mustafa -CTO</div>
            </div>
            <div class="col-4">
                <div class="ques-panel"><span class="ques-panel-no">3</span>Research on you competitors offering and product portfolio</div>
                <div class="ques-panel"><span class="ques-panel-no">6</span>Talk to someone who knows Mr. Mustafa is personal capacity</div>
            </div>
        </div>
        <h4 class="small-heading mt-3 text-center">Solution and Explanation</h4>
        <div class="row">
            <div class="col-4">
                <div class="priority-heading">Most Important</div>
                <div class="priority-heading_sub">Priority #1 Company & Client Background details</div>
                <div class="ans-panel-box">
                    <p>Performing secondary research about the company will be critical to build strategic alliances and partnerships for mutual benefit which can be leveraged during the meeting</p>
                    <div class="ans-panel"><span class="ans-panel-no">1</span></div>
                </div>
                <div class="ans-panel-box">
                    <p>Performing secondary research about the person you are meeting will be critical to build strategic alliances and partnerships for mutual benefit which can be leveraged during the meeting</p>
                    <div class="ans-panel"><span class="ans-panel-no">5</span></div>
                </div>

            </div>
            <div class="col-4">
                <div class="priority-heading">Moderately Important</div>
                <div class="priority-heading_sub">Priority # 2 Stakeholder connect to understand client priorities & current business outlook</div>
                <div class="ans-panel-box">
                    <p>Monitoring marketplace trends, opportunities, business outlook in general can help in showcasing your knowledge and application better</p>
                    <div class="ans-panel"><span class="ans-panel-no">4</span></div>
                </div>
                <div class="ans-panel-box">
                    <p>Collaborating with internal colleagues/stakeholders to discuss your approach, strategy, taking their inputs and suggestions will aid in a successful first impression with client</p>
                    <div class="ans-panel"><span class="ans-panel-no">2</span></div>
                </div>
            </div>
            <div class="col-4">
                <div class="priority-heading">Least Important</div>
                <div class="priority-heading_sub">Priority # 3 Detailed insights that may not be required for first meeting.</div>
                <div class="ans-panel-box">
                    <p>Though helpful, insight about your competition and their offerings may not as important before the first meeting</p>
                    <div class="ans-panel"><span class="ans-panel-no">3</span></div>
                </div>
                <div class="ans-panel-box">
                    <p>Personal connect may not be that useful as professional priorities for an individual may differ</p>
                    <div class="ans-panel"><span class="ans-panel-no">6</span></div>
                </div>
            </div>
        </div>--%>



        <div class="text-center mt-3 mb-3" id="btnNext"><a href="#" onclick="fnMyExercise()" id="btnAnchorNext" class="btns btn-submit">Next</a></div>
    </div>
    <!------------ End English------------------>

    <!------------  Indonesia------------------>
    <div id="dvIndonesia">
        <div class="section-title">
            <h3 class="text-center">CONTOH TUGAS</h3>
            <div class="title-line-center"></div>

        </div>
        <p>Anda dijadwalkan untuk bertemu Mustafa untuk memahami kebutuhannya sekaligus membangun hubungan positif dengan beliau. Mustafa memiliki jadwal yang sangat sibuk, sehingga beliau mengharapkan Anda untuk datang dengan persiapan matang sehingga Anda berdua dapat memaksimalkan waktu yang dimiliki.</p>
        <p>Informasi apa yang akan Anda kumpulkan sebelum bertemu Bapak Mustafa di Grup Sunrise? Klasifikasikan pilihan-pilihan berikut sebagai “Paling Penting”, “Cukup Penting”, “Kurang Penting”</p>

        <div class="row ml_2">
            <div class="col-4">
                <div class="ques-panel"><span class="ques-panel-no">1</span>Melihat situs resmi organisasi dan informasi detail mendasar di laporan tahunan</div>
                <div class="ques-panel"><span class="ques-panel-no">4</span>Mencari informasi terkait sektor dan prospek bisnis</div>
            </div>
            <div class="col-4">
                <div class="ques-panel"><span class="ques-panel-no">2</span>Berdiskusi dengan manajer dan kolega Anda, dan bersiap-siap dengan mereka untuk rapat Anda</div>
                <div class="ques-panel"><span class="ques-panel-no">5</span>Mencari profil Bapak Mustafa - CTO</div>
            </div>
            <div class="col-4">
                <div class="ques-panel"><span class="ques-panel-no">3</span>Meneliti penawaran dan portofolio produk dari kompetitor Anda</div>
                <div class="ques-panel">
                    <span class="ques-panel-no">6</span>Berdiskusi dengan seseorang yang mengetahui kapasitas personal Bapak Mustafa
                </div>
            </div>
        </div>
        <h4 class="small-heading mt-3 text-center">Solusi dan Penjelasan</h4>
        <div class="row">
            <div class="col-4">
                <div class="priority-heading">Paling Penting</div>
                <div class="priority-heading_sub">Prioritas #1 Detail latar belakang perusahaan & klien</div>
                <div class="ans-panel-box">
                    <p>Melakukan penelitian sekunder terkait perusahaan akan menjadi sangat penting untuk membangun aliansi strategis dan kemitraan untuk keuntungan bersama, yang dapat dimaksimalkan dalam rapat</p>
                    <div class="ans-panel"><span class="ans-panel-no">1</span></div>
                </div>
                <div class="ans-panel-box">
                    <p>Melakukan penelitian sekunder terkait individu yang akan bertemu dengan Anda akan menjadi sangat penting untuk membangun aliansi strategis dan kemitraan untuk keuntungan bersama, yang dapat dimaksimalkan dalam rapat</p>
                    <div class="ans-panel"><span class="ans-panel-no">5</span></div>
                </div>

            </div>
            <div class="col-4">
                <div class="priority-heading">Cukup Penting</div>
                <div class="priority-heading_sub">Prioritas # 2 Hubungan stakeholder untuk memahami prioritas klien dan prospek bisnis saat ini</div>
                <div class="ans-panel-box">
                    <p>Memantau tren, kesempatan, dan prospek bisnis di pasar secara umum dapat membantu menunjukkan pengetahuan Anda  dan aplikasinya dengan lebih baik</p>
                    <div class="ans-panel"><span class="ans-panel-no">4</span></div>
                </div>
                <div class="ans-panel-box">
                    <p>Bekerja sama dengan kolega/stakeholders internal untuk mendiskusikan pendekatan dan strategi Anda, mendapatkan masukan dan saran akan membantu Anda untuk membuat impresi awal yang baik dengan klien</p>
                    <div class="ans-panel"><span class="ans-panel-no">2</span></div>
                </div>
            </div>
            <div class="col-4">
                <div class="priority-heading">Kurang Penting</div>
                <div class="priority-heading_sub">Prioritas # 3 Informasi detail lainnya yang mungkin tidak diperlukan untuk pertemuan pertama</div>
                <div class="ans-panel-box">
                    <p>Meskipun membantu, pengetahuan mengenai kompetitor dan penawaran mereka mungkin tidak akan terlalu penting sebelum pertemuan pertama</p>
                    <div class="ans-panel"><span class="ans-panel-no">3</span></div>
                </div>
                <div class="ans-panel-box">
                    <p>
                        Koneksi personal mungkin tidak terlalu berguna, mengingat prioritas profesional dan individu dapat berbeda
                    </p>
                    <div class="ans-panel"><span class="ans-panel-no">6</span></div>
                </div>
            </div>
        </div>
        <div class="text-center mt-3"><a href="#" onclick="fnMyExercise()" class="btns btn-submit">Selanjutnya</a></div>
    </div>
    <!------------ End Indonesia------------------>

    <!------------ Sinhala------------------>
    <div id="dvSinhala">
        <div class="section-title">
            <h3 class="text-center">කාර්යයේ උදාහරණය</h3>
            <div class="title-line-center"></div>

        </div>
        <p>මුස්තාපාගේ අවශ්‍යතා අවබෝධ කර ගැනීමටත් ඔහු සමඟ ධනාත්මක සම්බන්ධතාවයක් ගොඩනඟා ගැනීමටත් ඔබ ඔහු හමුවීමට නියමිතය. මුස්තාපාට ඉතා කාර්යබහුල කාලසටහනක් ඇත, එබැවින් ඔබ දෙදෙනාගේ රැස්වීමේ වේලාවෙන් උපරිම ප්‍රයෝජන ගත හැකි වන පරිදි ඔබ රැස්වීමට හොඳින් සූදානම් වනු ඇතැයි ඔහු අපේක්ෂා කරයි.</p>
        <p>සන්රයිස් සමූහයේ මුස්තාපා මහතා හමුවීමට යාමට පෙර ඔබ රැස්කරන තොරතුරු මොනවාද? පහත සඳහන් දෑ “වඩාත්ම වැදගත්” “මධ්‍යස්ථව වැදගත්” “අවම වැදගත්” ලෙස වර්ග කරන්න.</p>

        <div class="row ml_2">
            <div class="col-4">
                <div class="ques-panel"><span class="ques-panel-no">1</span>සමාගමේ වෙබ් අඩවිය සහ වාර්ෂික ප්‍රකාශ වල මූලික තොරතුරු සොයා බලන්න.</div>
                <div class="ques-panel"><span class="ques-panel-no">4</span>ව්‍යාපාර අංශ සහ ව්‍යාපාර දැක්ම පිළිබඳ වැඩි විස්තර ලබා ගන්න.</div>
            </div>
            <div class="col-4">
                <div class="ques-panel"><span class="ques-panel-no">2</span>ඔබේ කළමනාකරු සහ සගයන් සමඟ කතා කර ඔවුන් සමඟ ඔබේ රැස්වීම සඳහා සූදානම් වන්න.</div>
                <div class="ques-panel"><span class="ques-panel-no">5</span>මුස්තාපා මහතාගේ තොරතුරු සොයා බලන්න -සීටීඕ (CTO)</div>
            </div>
            <div class="col-4">
                <div class="ques-panel"><span class="ques-panel-no">3</span>ඔබ තරඟකරුවන්ගේ ඉදිරිපත් කිරීම් [offering] සහ නිෂ්පාදන කළඹ [portfolio] පිළිබඳ පර්යේෂණ කරන්න.</div>
                <div class="ques-panel"><span class="ques-panel-no">6</span>මුස්තාපා මහතා පෞද්ගලිකව දන්නා කෙනෙකු සමඟ කතා කරන්න.</div>
            </div>
        </div>
        <h4 class="small-heading mt-3 text-center">විසඳුම සහ පැහැදිලි කිරීම</h4>
        <div class="row">
            <div class="col-4">
                <div class="priority-heading">වඩාත්ම වැදගත්</div>
                <div class="priority-heading_sub">ප්‍රමුඛතා # 1 සමාගම සහ සේවාලාභී පසුබිම් විස්තර</div>
                <div class="ans-panel-box">
                    <p>උපායමාර්ගික සන්ධාන [strategic alliances] සහ හවුල්කාරිත්වයන් ගොඩනැගීම සඳහා රැස්වීම අතරතුර උත්තේජනය [leveraged] කළ හැකි අන්‍යෝන්‍ය ප්‍රතිලාභ පිළිබද වටහා ගැනිම සඳහා සමාගම පිළිබඳ ද්විතීයික පර්යේෂණ සිදු කිරීම ඉතා වැදගත් වේ.</p>
                    <div class="ans-panel"><span class="ans-panel-no">1</span></div>
                </div>
                <div class="ans-panel-box">
                    <p>උපායමාර්ගික සන්ධාන සහ හවුල්කාරිත්වයන් ගොඩනැගීම සඳහා රැස්වීම අතරතුර උත්තේජනය කළ හැකි අන්‍යෝන්‍ය ප්‍රතිලාභ පිළිබද වටහා ගැනිම සඳහා ඔබ මුණගැසෙන පුද්ගලයා පිළිබඳව ද්විතීයික පර්යේෂණ සිදු කිරීම ඉතා වැදගත් වේ.</p>
                    <div class="ans-panel"><span class="ans-panel-no">5</span></div>
                </div>

            </div>
            <div class="col-4">
                <div class="priority-heading">මධ්‍යස්ථව වැදගත්</div>
                <div class="priority-heading_sub">ප්‍රමුඛතා # 2 සේවාදායකයාගේ ප්‍රමුඛතා සහ වර්තමාන ව්‍යාපාරික දැක්ම අවබෝධ කර ගැනීම සඳහා පාර්ශවකරුවන් සම්බන්ධ කර ගැනිම</div>
                <div class="ans-panel-box">
                    <p>වෙළඳපල ප්‍රවණතා, අවස්ථාවන්, පොදු ව්‍යාපාරික දෘෂ්ටිය [business outlook] අධීක්ෂණය කිරීම ඔබේ දැනුම සහ යෙදුම [application] වඩා හොඳින් ප්‍රදර්ශනය කිරීමට උපකාරී වේ.</p>
                    <div class="ans-panel"><span class="ans-panel-no">4</span></div>
                </div>
                <div class="ans-panel-box">
                    <p>ඔබේ ප්‍රවේශය, උපායමාර්ගය, ඔවුන්ගේ යෙදවුම් [inputs] සහ යෝජනා සාකච්ඡා කිරීම සඳහා අභ්‍යන්තර සගයන්/ පාර්ශවකරුවන් සමඟ සහයෝගයෙන් කටයුතු කිරීම සේවාදායකයා තුල පළමු සාර්ථක හැඟීම ඇති කිරීමට උපකාරී වේ.</p>
                    <div class="ans-panel"><span class="ans-panel-no">2</span></div>
                </div>
            </div>
            <div class="col-4">
                <div class="priority-heading">අවම වැදගත්</div>
                <div class="priority-heading_sub">ප්‍රමුඛතාවය # 3 පළමු රැස්වීම සඳහා අවශ්‍ය නොවන සවිස්තරාත්මක තීක්ෂ්ණ බුද්ධිය [insights].</div>
                <div class="ans-panel-box">
                    <p>ප්‍රයෝජනවත් වුවද, ඔබේ - තරගය [your competition] සහ ඒවායේ පිරිනැමීම් [offerings] පිළිබඳ අවබෝධය පළමු රැස්වීමට පෙර එතරම් වැදගත් නොවනු ඇත.</p>
                    <div class="ans-panel"><span class="ans-panel-no">3</span></div>
                </div>
                <div class="ans-panel-box">
                    <p>පුද්ගලයෙකුගේ වෘත්තීය ප්‍රමුඛතා වෙනස් විය හැකි බැවින් පුද්ගලික සම්බන්ධතාවය එතරම් ප්‍රයෝජනවත් නොවනු ඇත.</p>
                    <div class="ans-panel"><span class="ans-panel-no">6</span></div>
                </div>
            </div>
        </div>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMyExercise()" class="btns btn-submit">ඊළඟ</a></div>
    </div>
    <!------------ End Sinhala------------------>

    <!------------ Tamil------------------>
    <div id="dvTamil">
        <div class="section-title">
            <h3 class="text-center">பணியின் எடுத்துக்காட்டு</h3>
            <div class="title-line-center"></div>

        </div>
        <p>முஸ்தபாவின் தேவைகளைப் புரிந்துகொள்வதற்கும் அவருடன் ஒரு நல்லுறவை உருவாக்குவதற்கும் நீங்கள் சந்திக்க திட்டமிடப்பட்டுள்ளீர்கள். முஸ்தபா மிகவும் பிஸியான கால அட்டவணையைக் கொண்டுள்ளார், எனவே நீங்கள் கூட்டத்திற்கு நன்கு தயாராக வர வேண்டும் என்று அவர் எதிர்பார்க்கிறார், இதனால் நீங்கள் இருவரும் சந்திப்பு நேரத்தை பயனுள்ளதாக பயன்படுத்த முடியும்.</p>
        <p>சன்ரைஸ் குழுமத்தில் திரு முஸ்தபாவைச் சந்திக்கச் செல்வதற்கு முன்பு நீங்கள் என்ன தகவல்களைச் சேகரிப்பீர்கள்? பின்வருவனவற்றை “மிக முக்கியமானவை” “மிதமான முக்கியத்துவம் வாய்ந்தவை” “குறைந்த முக்கியத்துவம் வாய்ந்தவை” என வகைப்படுத்தவும்</p>

        <div class="row ml_2">
            <div class="col-4">
                <div class="ques-panel"><span class="ques-panel-no">1</span>நிறுவனத்தின் வலைத்தளம் மற்றும் அடிப்படை விவரங்களை ஆண்டு அறிக்கைகளில் பாருங்கள்</div>
                <div class="ques-panel"><span class="ques-panel-no">4</span>துறை மற்றும் வணிகக் கண்ணோட்டம் பற்றிய கூடுதல் தகவல்களைப் பெறுங்கள்</div>
            </div>
            <div class="col-4">
                <div class="ques-panel"><span class="ques-panel-no">2</span>உங்கள் மேலாளர் மற்றும் சக ஊழியர்களுடன் பேசுங்கள், அவர்களுடன் உங்கள் சந்திப்புக்குத் தயாராகுங்கள்</div>
                <div class="ques-panel"><span class="ques-panel-no">5</span>திரு முஸ்தபா-சி.டி.ஓவின் சுயவிவரத்தைப் பாருங்கள்</div>
            </div>
            <div class="col-4">
                <div class="ques-panel"><span class="ques-panel-no">3</span>உங்கள் போட்டியாளர்கள்(Competitors) மற்றும் தயாரிப்பு இலாகா பற்றிய ஆராய்ச்சி</div>
                <div class="ques-panel"><span class="ques-panel-no">6</span>திரு. முஸ்தபா தனிப்பட்ட திறன் என்று தெரிந்த ஒருவரிடம் பேசுங்கள்</div>
            </div>
        </div>
        <h4 class="small-heading mt-3 text-center">தீர்வு மற்றும் விளக்கம்</h4>
        <div class="row">
            <div class="col-4">
                <div class="priority-heading">மிக முக்கியம்</div>
                <div class="priority-heading_sub">முன்னுரிமை # 1 நிறுவனம் & வாடிக்கையாளர் பின்னணி விவரங்கள்</div>
                <div class="ans-panel-box">
                    <p>நிறுவனத்தைப் பற்றிய இரண்டாம் நிலை ஆராய்ச்சிகளை மேற்கொள்வது, கூட்டணியின் போது அந்நிய நன்மைக்காக மூலோபாய கூட்டணிகளையும் கூட்டாண்மைகளையும் (strategic alliances and partnerships )உருவாக்குவதற்கு முக்கியமானதாக இருக்கும்</p>
                    <div class="ans-panel"><span class="ans-panel-no">1</span></div>
                </div>
                <div class="ans-panel-box">
                    <p>நீங்கள் சந்திக்கும் நபரைப் பற்றி இரண்டாம் நிலை ஆராய்ச்சி செய்வது பரஸ்பர நன்மைக்காக மூலோபாய கூட்டணிகளையும் கூட்டாண்மைகளையும் (strategic alliances and partnerships உருவாக்குவதற்கு முக்கியமானதாக இருக்கும், இது கூட்டத்தின் போது அந்நியப்படுத்தப்படலாம் (leveraged)</p>
                    <div class="ans-panel"><span class="ans-panel-no">5</span></div>
                </div>

            </div>
            <div class="col-4">
                <div class="priority-heading">மிதமாக முக்கியமானது</div>
                <div class="priority-heading_sub">முன்னுரிமை # 2 வாடிக்கையாளர் முன்னுரிமைகள் மற்றும் தற்போதைய வணிகக் கண்ணோட்டத்தைப் புரிந்துகொள்ள பங்குதாரர் இணைக்கிறார்</div>
                <div class="ans-panel-box">
                    <p>சந்தையின் போக்குகள், வாய்ப்புகள், வணிகக் கண்ணோட்டம் ஆகியவற்றைக் கண்காணிப்பது உங்கள் அறிவையும் பயன்பாட்டையும் சிறப்பாகக் காண்பிக்க உதவும்</p>
                    <div class="ans-panel"><span class="ans-panel-no">4</span></div>
                </div>
                <div class="ans-panel-box">
                    <p>உங்கள் அணுகுமுறை, மூலோபாயம், அவர்களின் உள்ளீடுகள் மற்றும் பரிந்துரைகளை எடுத்துக்கொள்வது குறித்து உள் சகாக்கள் (colleagues) பங்குதாரர்களுடன் ஒத்துழைப்பது வாடிக்கையாளருடன் வெற்றிகரமான முதல் தோற்றத்திற்கு உதவும்</p>
                    <div class="ans-panel"><span class="ans-panel-no">2</span></div>
                </div>
            </div>
            <div class="col-4">
                <div class="priority-heading">குறைந்த முக்கியமானது</div>
                <div class="priority-heading_sub">முன்னுரிமை # 3 முதல் சந்திப்புக்கு தேவைப்படாத விரிவான நுண்ணறிவு.(insights)</div>
                <div class="ans-panel-box">
                    <p>உதவியாக இருந்தாலும், உங்கள் போட்டி மற்றும் அவற்றின் முடிவுபற்றிய நுண்ணறிவு முதல் சந்திப்புக்கு முன்பு  முக்கியமில்லை</p>
                    <div class="ans-panel"><span class="ans-panel-no">3</span></div>
                </div>
                <div class="ans-panel-box">
                    <p>ஒரு நபருக்கான தொழில்முறை முன்னுரிமைகள் வேறுபடலாம் என்பதால் தனிப்பட்ட இணைப்பு பயனுள்ளதாக இருக்காது</p>
                    <div class="ans-panel"><span class="ans-panel-no">6</span></div>
                </div>
            </div>
        </div>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMyExercise()" class="btns btn-submit">அடுத்து</a></div>
    </div>
    <!------------ End Tamil------------------>
    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

