<%@ Page Title="" Language="VB" MasterPageFile="~/DataB/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="CaseProbing.aspx.vb" Inherits="L3DirectSales_Task2_CaseProbing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
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
            var navbar = ($("nav.navbar").outerHeight());
            $('.main-box').css({
                "min-height": $(window).height() - (navbar + 22),
                'margin-top': navbar
            });
            $('.main-sidebar').css({
                "height": "100%" //$('.main-box').outerHeight()
            });

            var LngID = $("#hdnLngID").val();

            if (X == 2) {
                var LngID = $("#ddlLanguage").val();
                $("#hdnLngID").val(LngID);
            }

            fnChangeDataOnPanelPage()

            if (LngID == "2") {

                $("#dvIndonesia").show();
                $("#dvEnglish").hide();
                $("#dvSinhala").hide();
                $("#dvTamil").hide();
            }
            else if (LngID == "3") {

                $("#dvSinhala").show();
                $("#dvIndonesia").hide();
                $("#dvEnglish").hide();
                $("#dvTamil").hide();
            }
            else if (LngID == "1") {
                $("#dvTamil").show();
                $("#dvSinhala").hide();
                $("#dvIndonesia").hide();
                $("#dvEnglish").hide();
            }

            else {
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

        function fnUpdateSessionSuccess(result) {

        }
        function fnUpdateSessionFailed(result) {
            //    alert(result._message);
        }

        function fnCaseProbing(flg) {
            var ids = "";
            if (flg == 1) {
                var LngID = $("#hdnLngID").val();
                titles = "ICT Deployment Models"
                if (LngID == "2") {
                    ids = "DeploymentModels_INDO";
                }
                else if (LngID == "3") {

                    ids = "DeploymentModels_SIN";
                }
                else if (LngID == "1") {
                    ids = "DeploymentModels_TAMIL";
                }
                else {
                    ids = "DeploymentModels_ENG";
                }

                $("#" + ids).dialog({
                    title: titles,
                    width: "75%",
                    height: "480",
                    modal: true,
                    draggable: false,
                    resizable: false,
                });
            }
            else if (flg == 2) {
                var LngID = $("#hdnLngID").val();
                titles = "Cost Benefit Analysis"
                if (LngID == "2") {
                    ids = "BenefitAnalysis_INDO";
                }
                else if (LngID == "3") {

                    ids = "BenefitAnalysis_SIN";
                }
                else if (LngID == "1") {
                    ids = "BenefitAnalysis_TAMIL";
                }
                else {
                    ids = "BenefitAnalysis_ENG";
                }
                $("#" + ids).dialog({
                    title: titles,
                    width: "75%",
                    height: "480",
                    modal: true,
                    draggable: false,
                    resizable: false,
                });

            }
            else if (flg == 3) {
                var LngID = $("#hdnLngID").val();
                titles = "Parent & Student Feedback"
                if (LngID == "2") {
                    ids = "ParentStudentFeedback_INDO";
                }
                else if (LngID == "3") {

                    ids = "ParentStudentFeedback_SIN";
                }
                else if (LngID == "1") {
                    ids = "ParentStudentFeedback_TAMIL";
                }
                else {
                    ids = "ParentStudentFeedback_ENG";
                }
                $("#" + ids).dialog({
                    title: titles,
                    width: "75%",
                    height: "480",
                    modal: true,
                    draggable: false,
                    resizable: false,
                });
            }

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
            fnChangeDataBasedOnLanguage(1);
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English------------------>
    <div id="dvEnglish">
<%--        <div class="section-title">
            <h3 class="text-center">Case Probing</h3>
            <div class="title-line-center"></div>
        </div>
        <p><strong><u>Current Situation<br />
        </u></strong>Genesis has recently acquired XYZ Manufacturing, a company based out of Germany specializing in production of wind turbines. XYZ Manufacturing has created a niche for itself with strong R&amp;D&nbsp; and an innovative product line. The acquisition is in line with Genesis's plan for enhancing their presence in sustainable energy solutions</p>
        <p><strong><u>Problem Statement:<br />
        </u></strong>Post-acquisition, Genesis faces significant challenges in integrating XYZ Manufacturing into its existing corporate structure. These challenges include cultural misalignment, different employment laws, and systems incompatibility, which could potentially lead to loss of key talent, employee dissatisfaction and operational inefficiencies.&nbsp;&nbsp;</p>

        <p><strong><u>Note:<br /> </u></strong>Genesis has acquired XYZ while the above scenarios and challenges prevail at the organization during integration.&nbsp; &nbsp;</p>

        <p><strong><u>Your Role:</u></strong><br /> You are the CHRO of Genesis and have joined the company 6 months back. You are still in the process of familiarizing yourself with the current practices and now are also expected to manage the integration of Genesis and XYZ in a seamless manner.</p>

        <p><strong><u>Your Task:<br /> </u></strong>In your role, you are supposed to think through the scanarios and select the best possible options.</p>--%>

        <%-- <div class="text-center mb-3">
            <a href="#" onclick="fnCaseProbing(1)" class="btns btn-submit">ICT Deployment Models</a>
            <a href="#" onclick="fnCaseProbing(2)" class="btns btn-submit">Cost Benefit Analysis</a>
            <a href="#" onclick="fnCaseProbing(3)" class="btns btn-submit">Parent & Student Feedback</a>
        </div>--%>
         <div class="section-title" >
        <div class="text-center mb-3" style="padding-top:40px;">
            <asp:Button runat="server" ID="btnStartENG" Enabled="true" Text="Start Questions" CssClass="btns btn-submit" />
        </div>
             </div>
        <div id="DeploymentModels_ENG" style="display: none;">
            <p><strong>Model 1:</strong> Teacher/Admin ICT features</p>
            <ul>
                <li>Not used by students</li>
                <li>Used for administrative purposes  (digitise attendance, report cards etc.) and resource planning (lesson  planning, scheduling of classes etc.) </li>
            </ul>
            <p><strong>Model 2:</strong> Teacher/Admin ICT Features  &amp; pre-recorded teaching aid</p>
            <ul>
                <li>All features of Model 1</li>
                <li>All teachers are provided with  devices to connect with students virtually through live sessions or can record  their lessons</li>
                <li>Only 40% of  students having their own smart ICT devices, will be able to connect for live  classes &amp; virtual parent teacher meeting ; rest 60% of students can only  access recorded lectures</li>
                <li>No provision for parents to track  students&rsquo; learning progress</li>
            </ul>
            <p><strong>Model 3:</strong> Teacher/Admin ICT Features,  live teaching aid &amp; provision of smart ICT devices to all</p>
            <ul>
                <li>All features of Model 1</li>
                <li>All teachers are provided with  devices to connect with students virtually through live sessions or can record  their lessons</li>
                <li>All of the students (100%) will be  provided smart ICT devices which will enable them to connect for live classes,  virtual parent teacher meeting and access recorded lectures</li>
                <li>App feature is included using which  parents can track students&rsquo; learning progress</li>
            </ul>
            <p><strong>Model 4:</strong> – Teacher/Admin ICT  Features, live teaching aid &amp; provision of subsidised smart ICT  devices  </p>
            <ul>
                <li>All features of Model 1</li>
                <li>All teachers are provided with  devices to connect with students virtually through live sessions or can record  their lessons</li>
                <li>All students (60% - who do not have  their own smart ICT devices) will be provided as part of subsidy support from  government which will enable them to connect for live classes, virtual parent  teacher meeting and access recorded lectures</li>
                <li>No provision for parents to track  students&rsquo; learning progress</li>
            </ul>
        </div>
        <div id="BenefitAnalysis_ENG" style="display: none;">
            <table class="table table-bordered table-sm">
                <thead>
                    <tr>
                        <th style="width: 10%;">&nbsp;</th>
                        <th>Total initial cost</th>
                        <th>Availability of ICT for teachers for admin or teaching purposes </th>
                        <th>Availability of ICTs classroom session for students</th>
                        <th>ICT availability for parents to track students&rsquo; learning progress</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Model 1</td>
                        <td>X</td>
                        <td>Admin purposes only</td>
                        <td>No</td>
                        <td>No</td>
                    </tr>
                    <tr>
                        <td>Model 2</td>
                        <td>2X</td>
                        <td>Teaching &amp; Admin purposes</td>
                        <td>Only students with their own smart ICT devices can access live classes </td>
                        <td>No</td>
                    </tr>
                    <tr>
                        <td>Model 3</td>
                        <td>8X </td>
                        <td>Teaching &amp; Admin purposes</td>
                        <td>Yes, all students are provided smart ICT devices (100%)</td>
                        <td>Yes</td>
                    </tr>
                    <tr>
                        <td>Model 4</td>
                        <td>4X</td>
                        <td>Teaching &amp; Admin purposes</td>
                        <td>Yes, smart ICT devices will be provided for those students who do not have their own (60%)</td>
                        <td>No</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div id="ParentStudentFeedback_ENG" style="display: none;">
            <div class="text-center">
                <img src="../../Images/L3-direct-ParentStudentFeedback.JPG" class="img-thumbnail" />
            </div>
        </div>
    </div>
    <!------------ End English------------------>

    <!------------  Indonesia------------------>
    <div id="dvIndonesia" style="display: none;">
        <div class="section-title">
            <h3 class="text-center">Pemeriksaan Kasus</h3>
            <div class="title-line-center"></div>
        </div>
        <p>Anda telah menyelesaikan diskusi level pertama dengan Mustafa dan memahami persyaratannya. Langkah selanjutnya adalah untuk menyesuaikan dengan tim Anda dan stakeholders internal terkait apa yang diharapkan klien dan membuat proposal solusi yang baik, dengan mempertimbangkan semua faktor.</p>
        <div class="text-center mb-3">
            <a href="#" onclick="fnCaseProbing(1)" class="btns btn-submit">Model Deployment TIK</a>
            <a href="#" onclick="fnCaseProbing(2)" class="btns btn-submit">Analisa Biaya dan Manfaat</a>
            <a href="#" onclick="fnCaseProbing(3)" class="btns btn-submit mt-2">Umpan Balik Orang tua & Siswa</a>
        </div>
        <div class="text-center mb-3">
            <asp:Button runat="server" ID="btnStartINDO" Enabled="true" Text="Mulai Pertanyaan" CssClass="btns btn-submit" />
        </div>
        <div id="DeploymentModels_INDO" style="display: none;">
            <p><strong>Model 1:</strong> Fitur TIK Pengajar/Admin</p>
            <ul>
                <li>Tidak digunakan oleh siswa</li>
                <li>Digunakan untuk kepentingan administratif (digitalisasi daftar kehadiran, buku laporan, dll.) dan perencanaan sumber daya (perencanaan materi pengajaran, penjadwalan kelas, dll.)</li>
            </ul>
            <p><strong>Model 2:</strong> Fitur TIK Pengajar/Admin &amp; alat bantu mengajar yang direkam sebelumnya (pre-recorded teaching aid)</p>
            <ul>
                <li>Semua fitur dari Model 1</li>
                <li>Semua tenaga pengajar diberikan perangkat untuk terhubung secara virtual dengan siswa melalui sesi live atau dapat merekam sesi mereka</li>
                <li>Hanya 40% siswa memiliki perangkat TIK pintar mereka sendiri, yang akan dapat terhubung untuk kelas live dan pertemuan orang tua-guru virtual; 60% sisanya hanya dapat mengakses kelas yang direkam</li>
                <li>Tidak ada fitur pengawasan orang tua untuk memantau progres pembelajaran siswa</li>
            </ul>
            <p><strong>Model 3:</strong> Fitur TIK Pengajar/Admin, alat bantu mengajar live &amp; pengawasan perangkat TIK pintar untuk semua</p>
            <ul>
                <li>Semua fitur Model 1</li>
                <li>Semua tenaga pengajar diberikan perangkat untuk terhubung secara virtual dengan siswa melalui sesi live atau dapat merekam sesi mereka</li>
                <li>Semua siswa (100%) akan diberikan perangkat TIK pintar mereka sendiri, yang dapat terhubung untuk kelas live, pertemuan orang tua-guru virtual, dan digunakan untuk mengakses kelas yang direkam</li>
                <li>Termasuk fitur aplikasi, yang dapat digunakan orang tua untuk memantau perkembangan belajar siswa</li>
            </ul>
            <p><strong>Model 4:</strong> – Fitur TIK Pengajar/Admin, alat bantu mengajar live & penyediaan perangkat TIK pintar bersubsidi  </p>
            <ul>
                <li>Semua fitur Model 1</li>
                <li>Semua tenaga pengajar diberikan perangkat untuk terhubung secara virtual dengan siswa melalui sesi live atau dapat merekam sesi mereka</li>
                <li>Semua siswa (60% - yang tidak memiliki perangkat TIK pintar mereka sendiri) akan diberikan perangkat TIK pintar sebagai bagian dari dukungan subsidi pemerintah, yang dapat terhubung untuk kelas live, pertemuan orang tua-guru virtual, dan digunakan untuk mengakses kelas yang direkam</li>
                <li>Tidak ada fitur pengawasan orang tua untuk memantau perkembangan pembelajaran siswa</li>
            </ul>
        </div>
        <div id="BenefitAnalysis_INDO" style="display: none;">
            <table class="table table-bordered table-sm">
                <thead>
                    <tr>
                        <th style="width: 10%;">&nbsp;</th>
                        <th>Total biaya permulaan</th>
                        <th>Ketersediaan TIK untuk tenaga pengajar, admin, atau kepentingan mengajar</th>
                        <th>Ketersediaan sesi kelas TIK untuk siswa</th>
                        <th>Ketersediaan  TIK untuk orang tua untuk memantau perkembangan belajar siswa</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Model 1</td>
                        <td>X</td>
                        <td>Kepentingan administrasi saja</td>
                        <td>Tidak tersedia</td>
                        <td>Tidak</td>
                    </tr>
                    <tr>
                        <td>Model 2</td>
                        <td>2X</td>
                        <td>Kepentingan pengajaran dan administrasi</td>
                        <td>Hanya untuk siswa dengan perangkat TIK pintar mereka sendiri yang dapat mengakses kelas live</td>
                        <td>Tidak</td>
                    </tr>
                    <tr>
                        <td>Model 3</td>
                        <td>8X </td>
                        <td>Kepentingan pengajaran dan administrasi</td>
                        <td>Ya, semua siswa disediakan perangkat TIK pintar (100%)</td>
                        <td>Ya</td>
                    </tr>
                    <tr>
                        <td>Model 4</td>
                        <td>4X</td>
                        <td>Kepentingan pengajaran dan administrasi</td>
                        <td>Ya, perangkat TIK pintar akan diberikan untuk siswa yang tidak memilikinya (60%)</td>
                        <td>Tidak</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div id="ParentStudentFeedback_INDO" style="display: none;">
            <div class="text-center">
                <img src="../../Images/L3-direct-ParentStudentFeedback-indonesian.JPG" class="img-thumbnail" />
            </div>
        </div>
    </div>
    <!------------ End Indonesia------------------>

    <!------------ Sinhala------------------>
    <div id="dvSinhala" style="display: none;">
        <div class="section-title">
            <h3 class="text-center">සිද්ධි විමර්ශනය</h3>
            <div class="title-line-center"></div>
        </div>
        <p>ඔබ මුස්තාපා සමඟ පළමු මට්ටමේ සාකච්ඡාව සාර්ථකව අවසන් කර ඇති අතර ඔහුගේ අවශ්‍යතා තේරුම් ගෙන ඇත. මීලඟ පියවර වන්නේ සේවාදායකයා අපේක්ෂා කරන දේ පිළිබඳව ඔබේ කණ්ඩායම හා අභ්‍යන්තර පාර්ශවකරුවන් සමඟ පෙළගැස්වීම සහ සියලු කරුණු සැලකිල්ලට ගනිමින් ශක්තිමත් විසඳුම් යෝජනාවක් නිර්මාණය කිරීමයි</p>
        <div class="text-center mb-3">
            <a href="#" onclick="fnCaseProbing(1)" class="btns btn-submit">තොරතුරු හා සන්නිවේදන තාක්ෂණ යෙදවුම් ආකෘති</a>
            <a href="#" onclick="fnCaseProbing(2)" class="btns btn-submit">පිරිවැය ප්‍රතිලාභ විශ්ලේෂණය</a>
            <a href="#" onclick="fnCaseProbing(3)" class="btns btn-submit mt-2">දෙමාපියන්ගේ සහ ශිෂ්‍යයන්ගේ ප්‍රතිපෝෂණය</a>
        </div>
        <div class="text-center mb-3">
            <asp:Button runat="server" ID="btnStartSIN" Enabled="true" Text="ප්‍රශ්න ආරම්භ කරන්න" CssClass="btns btn-submit" />
        </div>
        <div id="DeploymentModels_SIN" style="display: none;">
            <p><strong>ආකෘතිය 1 :</strong> ගුරු / පරිපාලන තොරතුරු හා සන්නිවේදන තාක්ෂණ විශේෂාංග</p>
            <ul>
                <li>සිසුන් විසින් භාවිතා නොකෙරේ.</li>
                <li>පරිපාලනමය අරමුණු සඳහා භාවිතා කිරීම. (පැමිණීම ඩිජිටල්කරණය, වාර්තා කාඩ්පත් ආදිය) සහ සම්පත් සැලසුම් කිරීම (පාඩම් සැලසුම් කිරීම, පන්ති උපලේඛනගත කිරීම ආදිය)</li>
            </ul>
            <p><strong>ආකෘතිය 2:</strong> ගුරු / පරිපාලන තොරතුරු හා සන්නිවේදන තාක්ෂණ විශේෂාංග සහ කලින් පටිගත කරන ලද ඉගැන්වීම් ආධාර</p>
            <ul>
                <li>ආකෘතිය 1 හි සියලුම අංග</li>
                <li>සියලුම ගුරුවරුන්ට සජීවී සැසි හරහා සිසුන් සමඟ සම්බන්ධ වීමට හෝ ඔවුන්ගේ පාඩම් පටිගත කිරීමට උපකරණ ලබා දී ඇත.</li>
                <li>තමන්ගේම ස්මාර්ට් තොරතුරු සන්නිවේදන තාක්ෂණ උපාංග ඇති සිසුන්ගෙන් 40% කට පමණක් සජීවී පන්ති සහ දෙමාපිය ගුරු රැස්වීම සඳහා සම්බන්ධ විය හැකිය; ඉතිරි 60% කට ප්‍රවේශ විය හැක්කේ වාර්තාගත දේශනවලට පමණි.</li>
                <li>සිසුන්ගේ ඉගෙනීමේ ප්‍රගතිය නිරීක්ෂණය කිරීමට දෙමාපියන්ට ප්‍රතිපාදන නොමැත.</li>
            </ul>
            <p><strong>ආකෘතිය 3:</strong>ගුරු / පරිපාලන තොරතුරු හා සන්නිවේදන තාක්ෂණ විශේෂාංග, සජීවී ඉගැන්වීම් ආධාර සහ සැමට ස්මාර්ට් තොරතුරු සන්නිවේදන තාක්ෂණ උපාංග සැපයීම</p>
            <ul>
                <li>ආකෘතිය 1 හි සියලුම අංග</li>
                <li>සියලුම ගුරුවරුන්ට සජීවී සැසි හරහා සිසුන් සමඟ සම්බන්ධ වීමට හෝ ඔවුන්ගේ පාඩම් පටිගත කිරීමට උපකරණ ලබා දී ඇත.</li>
                <li>සියළුම සිසුන්ට (100%) ස්මාර්ට් තොරතුරු සන්නිවේදන තාක්ෂණ උපකරණ ලබා දෙන අතර එමඟින් සජීවී පන්ති, දෙමාපිය ගුරු රැස්වීම සහ පටිගත කරන ලද දේශන සඳහා සම්බන්ධ වීමට හැකි වේ.</li>
                <li>සිසුන්ගේ ඉගෙනීමේ ප්‍රගතිය නිරීක්ෂණය කළ හැකි දෙමාපියන්ට යෙදුම් (App) විශේෂාංගය ඇතුළත් වේ.</li>
            </ul>
            <p><strong>ආකෘතිය 4:</strong> ගුරු / පරිපාලන තොරතුරු හා සන්නිවේදන තාක්ෂණ විශේෂාංග, සජීවී ඉගැන්වීම් ආධාර සහ සහන මිලට ස්මාර්ට් තොරතුරු සන්නිවේදන තාක්ෂණ උපාංග සැපයීම </p>
            <ul>
                <li>ආකෘතිය 1 හි සියලුම අංග</li>
                <li>සියලුම ගුරුවරුන්ට සජීවී සැසි හරහා සිසුන් සමඟ සම්බන්ධ වීමට හෝ ඔවුන්ගේ පාඩම් පටිගත කිරීමට උපකරණ ලබා දී ඇත.</li>
                <li>සියළුම සිසුන්ට (60% - තමන්ගේම ස්මාර්ට් තොරතුරු සන්නිවේදන තාක්ෂණ උපකරණ නොමැති) රජයෙන් ලැබෙන සහනාධාරයේ කොටසක් ලෙස ලබා දෙන අතර එමඟින් සජීවී පන්ති, දෙමාපිය ගුරු රැස්වීම සහ පටිගත කරන ලද දේශන සඳහා සම්බන්ධ වීමට ඔවුන්ට හැකි වේ.</li>
                <li>සිසුන්ගේ ඉගෙනීමේ ප්‍රගතිය නිරීක්ෂණය කිරීමට දෙමාපියන්ට ප්‍රතිපාදන නොමැත.</li>
            </ul>
        </div>
        <div id="BenefitAnalysis_SIN" style="display: none;">
            <table class="table table-bordered table-sm">
                <thead>
                    <tr>
                        <th style="width: 10%;">&nbsp;</th>
                        <th>මුළු ආරම්භක පිරිවැය</th>
                        <th>පරිපාලක හෝ ඉගැන්වීම් කටයුතු සඳහා සිටින ගුරුවරුන් සඳහා තොරතුරු හා සන්නිවේදන තාක්ෂණය ලබා ගත හැකි බව.</th>
                        <th>සිසුන් සඳහා තොරතුරු හා සන්නිවේදන තාක්ෂණ පන්ති කාමර සැසි ලබා ගැනීම.</th>
                        <th>සිසුන්ගේ ඉගෙනීමේ ප්‍රගතිය නිරීක්ෂණය කිරීම සඳහා දෙමාපියන්ට තොරතුරු හා සන්නිවේදන තාක්ෂණ පහසුකම් ලබා ගැනීම.</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>ආකෘතිය 1</td>
                        <td>X</td>
                        <td>පරිපාලක කටයුතු සඳහා පමණි</td>
                        <td>නැත</td>
                        <td>නැත</td>
                    </tr>
                    <tr>
                        <td>ආකෘතිය 2</td>
                        <td>2X</td>
                        <td>ඉගැන්වීම් සහ පරිපාලක කටයුතු සඳහා පමණි</td>
                        <td>සජීවී පන්ති වලට ප්‍රවේශ විය හැක්කේ ඔවුන්ගේම ස්මාර්ට් තොරතුරු සන්නිවේදන තාක්ෂණ උපාංග ඇති සිසුන්ට පමණි.</td>
                        <td>නැත</td>
                    </tr>
                    <tr>
                        <td>ආකෘතිය 3</td>
                        <td>8X </td>
                        <td>ඉගැන්වීම් සහ පරිපාලක කටයුතු සඳහා පමණි</td>
                        <td>ඔව්, සියලුම සිසුන්ට ස්මාර්ට් තොරතුරු සන්නිවේදන තාක්ෂණ උපාංග ලබා දී ඇත. (100%)</td>
                        <td>ඔව්</td>
                    </tr>
                    <tr>
                        <td>ආකෘතිය 4</td>
                        <td>4X</td>
                        <td>ඉගැන්වීම් සහ පරිපාලක කටයුතු සඳහා පමණි</td>
                        <td>ඔව්, තමන්ගේම ස්මාර්ට් තොරතුරු සන්නිවේදන තාක්ෂණ උපාංග නොමැති සිසුන් සඳහා ලබා දෙනු ඇත.(60%)</td>
                        <td>නැත</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div id="ParentStudentFeedback_SIN" style="display: none;">
            <div class="text-center">
                <img src="../../Images/L3-direct-ParentStudentFeedback-sinhala.JPG" class="img-thumbnail" />
            </div>
        </div>
    </div>
    <!------------ End Sinhala------------------>

    <!------------ Tamil------------------>
    <div id="dvTamil" style="display: none;">
        <div class="section-title">
            <h3 class="text-center">வழக்கு ஆய்வு</h3>
            <div class="title-line-center"></div>
        </div>
        <p>முஸ்தபாவுடனான உங்கள் முதல் நிலை கலந்துரையாடல் வெற்றிகரமாக முடித்துவிட்டீர்கள், அவருடைய தேவைகளைப் புரிந்து கொண்டீர்கள். அடுத்த கட்டம் என்னவென்றால், வாடிக்கையாளர் எதிர்பார்ப்பது குறித்து உங்கள் குழு மற்றும் உள் பங்குதாரர்களுடன் ஒன்றிணைந்து, அனைத்து கருத்துகளையும் மனதில் வைத்து ஒரு வலுவான தீர்வு திட்டத்தை உருவாக்குதல்</p>
        <div class="text-center mb-3">
            <a href="#" onclick="fnCaseProbing(1)" class="btns btn-submit">ஐ.சி.டி வரிசைப்படுத்தல் மாதிரிகள்</a>
            <a href="#" onclick="fnCaseProbing(2)" class="btns btn-submit">செலவு பயன் பகுப்பாய்வு</a>
            <a href="#" onclick="fnCaseProbing(3)" class="btns btn-submit mt-2">பெற்றோர் மற்றும் மாணவர் கருத்து</a>
        </div>
        <div class="text-center mb-3">
            <asp:Button runat="server" ID="btnStartTAMIL" Enabled="true" Text="கேள்விகளைத் தொடங்குங்கள்" CssClass="btns btn-submit" />
        </div>
        <div id="DeploymentModels_TAMIL" style="display: none;">
            <p><strong>மாதிரி 1:</strong> ஆசிரியர் / நிர்வாக ஐ.சி.டி அம்சங்கள் </p>
            <ul>
                <li>மாணவர் பயன்பாட்டிற்கு அல்ல</li>
                <li>நிர்வாக நோக்கங்களுக்காக பயன்படுத்தப்படுகின்றது (வருகையை மயமாக்குதல், அறிக்கை அட்டைகள் போன்றவை) மற்றும் வள திட்டமிடல் பாடம் திட்டமிடல், வகுப்புகளின் திட்டமிடல் போன்றவை) </li>
            </ul>
            <p><strong>மாதிரி 2:</strong> ஆசிரியர் / நிர்வாக ஐ.சி.டி அம்சங்கள் மற்றும் முன் பதிவு செய்யப்பட்ட கற்பித்தல் உதவி </p>
            <ul>
                <li>மாதிரி1 இன் அனைத்து அம்சங்களும் உள்ளன</li>
                <li>அனைத்து ஆசிரியர்களுக்கும் நேரடி அமர்வுகள் மூலம் மாணவர்களுடன் இணைக்க சாதனங்கள் வழங்கப்படுகின்றன அல்லது அவர்களின் பாடங்களை பதிவு செய்யலாம் </li>
                <li>40% மாணவர்கள் மட்டுமே தங்கள் சொந்த ஸ்மார்ட் ஐ.சி.டி சாதனங்களைக் கொண்டுள்ளனர், நேரடி வகுப்புகள் மற்றும் மெய்நிகர் பெற்றோர் ஆசிரியர் சந்திப்புக்கு இணைக்க முடியும்; மீதமுள்ள 60% மாணவர்கள் பதிவு செய்யப்பட்ட விரிவுரைகளை மட்டுமே அணுக முடியும்</li>
                <li>மாணவர்களின் கற்றல் முன்னேற்றத்தைக் கண்காணிக்க பெற்றோருக்கு எந்த ஏற்பாடும் இல்லை.</li>
            </ul>
            <p><strong>மாதிரி 3:</strong> ஆசிரியர் / நிர்வாக ஐ.சி.டி அம்சங்கள், நேரடி கற்பித்தல் உதவி மற்றும் அனைவருக்கும் ஸ்மார்ட் ஐ.சி.டி சாதனங்களை வழங்குதல் </p>
            <ul>
                <li>மாடல் 1 இன் அனைத்து அம்சங்களும் உள்ளன</li>
                <li>அனைத்து ஆசிரியர்களுக்கும் அமர்வுகள் மூலம் மாணவர்களுடன் இணைக்க சாதனங்கள் வழங்கப்படுகின்றன அல்லது அவர்களின் பாடங்களை பதிவு செய்யலாம் </li>
                <li>அனைத்து மாணவர்களுக்கும் (100%) ஸ்மார்ட் ஐ.சி.டி சாதனங்கள் வழங்கப்படும், இது நேரடி வகுப்புகள், மெய்நிகர் பெற்றோர் ஆசிரியர் சந்திப்பு மற்றும் பதிவுசெய்யப்பட்ட விரிவுரையாளர்களை இணைக்க உதவும்.</li>
                <li>மாணவர்களின் கற்றல் முன்னேற்றத்தை எந்த பெற்றோர்களும் கண்காணிக்க முடியும் அம்சம் சேர்க்கப்பட்டுள்ளது</li>
            </ul>
            <p><strong>மாதிரி 4:</strong>ஆசிரியர் / நிர்வாக ஐ.சி.டி அம்சங்கள், நேரடி கற்பித்தல் உதவி மற்றும் மானியமிக்க ஸ்மார்ட் ஐ.சி.டி சாதனங்களை வழங்குதல் </p>
            <ul>
                <li>மாடல் 1 இன் அனைத்து அம்சங்களும் </li>
                <li>அனைத்து ஆசிரியர்களுக்கும் நேரடி அமர்வுகள் மூலம் மாணவர்களுடன் இணைக்க சாதனங்கள் வழங்கப்படுகின்றன அல்லது அவர்களின் பாடங்களை பதிவு செய்யலாம் </li>
                <li>அனைத்து மாணவர்களுக்கும் (60% - சொந்த ஸ்மார்ட் ஐ.சி.டி சாதனங்கள் இல்லாதவர்களுக்கு) அரசாங்கத்தின ஆதரவின் ஒரு பகுதியாக வழங்கப்படும், இது அவர்களுக்கு நேரடி வகுப்புகள், மெய்நிகர் பெற்றோர் ஆசிரியர் சந்திப்பு மற்றும் பதிவுசெய்யப்பட்ட விரிவுரைகளை இணைக்க உதவும். </li>
                <li>மாணவர்களின் கற்றல் முன்னேற்றத்தைக் கண்காணிக்க பெற்றோருக்கு எந்த ஏற்பாடும் இல்லை.</li>
            </ul>
        </div>
        <div id="BenefitAnalysis_TAMIL" style="display: none;">
            <table class="table table-bordered table-sm">
                <thead>
                    <tr>
                        <th style="width: 10%;">&nbsp;</th>
                        <th>மொத்த ஆரம்ப செலவு</th>
                        <th>நிர்வாகி அல்லது கற்பித்தல் நோக்கங்களுக்காக ஆசிரியர்களுக்கான ஐ.சி.டி</th>
                        <th>மாணவர்களுக்கு ஐ.சி.டி வகுப்பறை அமர்வு கிடைக்கும்</th>
                        <th>மாணவர்களின் கற்றல் முன்னேற்றத்தைக் கண்காணிக்க பெற்றோருக்கு ஐ.சி.டி</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>மாதிரி 1</td>
                        <td>X</td>
                        <td>நிர்வாக நோக்கங்களுக்காக மட்டுமே</td>
                        <td>இல்லை</td>
                        <td>இல்லை</td>
                    </tr>
                    <tr>
                        <td>மாதிரி 2</td>
                        <td>2X</td>
                        <td>கற்பித்தல் மற்றும் நிர்வாக நோக்கங்கள்</td>
                        <td>தங்கள் சொந்த ஸ்மார்ட் ஐ.சி.டி சாதனங்களைக் கொண்ட மாணவர்கள் மட்டுமே நேரடி வகுப்புகளை அணுக முடியும்</td>
                        <td>இல்லை</td>
                    </tr>
                    <tr>
                        <td>மாதிரி 3</td>
                        <td>8X </td>
                        <td>கற்பித்தல் மற்றும் நிர்வாக நோக்கங்கள்</td>
                        <td>ஆம், அனைத்து மாணவர்களுக்கும் ஸ்மார்ட் ஐ.சி.டி சாதனங்கள் வழங்கப்படுகின்றன (100%)</td>
                        <td>ஆம்</td>
                    </tr>
                    <tr>
                        <td>மாதிரி 4</td>
                        <td>4X</td>
                        <td>கற்பித்தல் மற்றும் நிர்வாக நோக்கங்கள்</td>
                        <td>ஆம், சொந்தமாக இல்லாத மாணவர்களுக்கு ஸ்மார்ட் ஐ.சி.டி சாதனங்கள் வழங்கப்படும் (60%)</td>
                        <td>இல்லை</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div id="ParentStudentFeedback_TAMIL" style="display: none;">
            <div class="text-center">
                <img src="../../Images/L3-direct-ParentStudentFeedback-tamil.JPG" class="img-thumbnail" />
            </div>
        </div>
    </div>
    <!------------ End Tamil------------------>

    <asp:HiddenField ID="hdnExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToolID" runat="server" Value="0" />
</asp:Content>

