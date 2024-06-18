<%@ Page Title="" Language="VB" MasterPageFile="../MasterPage/Panel.master" AutoEventWireup="false" CodeFile="GtcProducts.aspx.vb" Inherits="Data_Information_GtcProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "ChangingIndustry.aspx";
        }

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
    </script>

    <script type="text/javascript">
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
        $(document).ready(function () {

            if ($("#hdnFlagPageToOpen").val() == "3") {
                f1();
            }
            else {
                $("#theTime").hide();

            }
            fnChangeDataBasedOnLanguage(1)
        });
        function f1() {

            //function FnUpdateTimer() {
            if (IsUpdateTimer == 0) { return; }
            SecondCounter = parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value);
            if (SecondCounter <= 0) {
                IsUpdateTimer = 0;

                $("#theTime").addClass("blinkmsg");

                $('.blinkmsg').blink({
                    delay: "1500"
                });


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
    <time id="theTime" class="fst-color">Reading Time Left  00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English--------------->
    <div id="dvEnglish">
        <div class="section-title">
            <h3 class="text-center">GTC PRODUCTS</h3>
            <div class="title-line-center"></div>
        </div>
        <h4 class="small-heading">GTC’s growing leadership presence in the Education industry</h4>
        <p>GTC has built on its network operations credibility and won more than 15 contracts with educational institutions in the last 3-4 months. Increasingly these contracts are now extending from just network operations to the larger domain of Information & Communication Technology (ICT) services. Investment in ICT education could have a big economic payoff for Malaysia.</p>
        <p>GTC has diversified its product portfolio to provide customized and more relevant offerings to the education industry clients:</p>
        <p><strong>1. Zero-rating</strong></p>
        <p>GTC has designated that data related to specific educational web sites or applications will be charged a zero tariff, i.e., that no data charges will apply when these resources are accessed.</p>
        <p><strong>2. Lifting data caps</strong></p>
        <p>GTC is lifting data caps on educational connectivity programs. E.g. A student used to be able to use 4GB a month for free; now she can use 8GB</p>
        <p><strong>3. Distributing devices in communities</strong></p>
        <p>Ministry of education is working with GTC to help get more devices into the hands of learners and teachers in a variety of ways, including not only procuring and delivering new devices, but also in inventorying, preparing and distributing devices from schools for home use.</p>
        <p><strong>4. Public hotspots, and lighting up old services and devices</strong></p>
        <p>GTC is setting up free public Wi-Fi access points in partnership with Govt of Malaysia for students to walk to and upload/download data.</p>
        <p><strong>5. SMS campaigns and call center support</strong></p>
        <p>Ministry of education is working with GTC to support awareness-raising campaigns in support of online learning via SMS and quickly setting up call centre helpdesks to support remotely located teachers, learners and their families.</p>
        <p><strong>6. Free SIM cards</strong></p>
        <p>GTC is making available free SIM cards for use by teachers and students, with expedited registration procedures, coupled with special data plans.</p>
        <%--<p>GTC has built on its network operations credibility and won more than 50 Managed Services contracts since it introduced this service into the market in 2012. Increasingly these contracts are now extending from just network operations to the larger domain of Information & Communication Technology (ICT) services. GTC is today a One Stop Centre for fully managed connectivity solutions. </p>
        <p class="font-weight-bold">GTC is planning to impact client delivery by: Reducing CAPEX/OPEX, Enhancing the quality of experience (QoE) and Enabling Business Transformation through a service-centric approach</p>
        <div class="row">
            <div class="col-md-6 pr-0">
                <p>GTC Managed Services delivery model brings:</p>
                <ul>
                    <li><span class="font-weight-bold">Best-in-class methodologies and execution</span> - A best practices database and knowledge across all facets of the network helps GTC address client needs throughout the project lifecycle</li>
                    <li><span class="font-weight-bold">Field proven tools and platforms</span> - With multi-vendor, multi-technology capabilities supporting more than 1500 products from more than 490 vendors, GTC is able to meet the precise needs of clients across a range of technologies and applications</li>
                    <li><span class="font-weight-bold">Experience and Maturity</span> - With employees who have more than a decade of experience in the Managed Services industry, GTC has the knowledge and perspective to help clients evolve from legacy to converged services </li>
                    <li><span class="font-weight-bold">Expertise and credentials</span> - With more than 50 customer networks supporting more than 100 million subscribers worldwide, GTC knows how to help clients meet their service delivery goals</li>
                </ul>
            </div>
            <div class="col-md-6">
                <div class="presence-photo">
                    <img src="../../Images/BI-tabc.png" />
                    <div class="overlay-text">
                        <p>Making this kind of change a reality requires nothing less than business transformation both for clients and service providers. Clients must embrace new ways of working to adopt the next gen service-centric models (such as Managed Services) offered by the market. For service providers internally, it means a fundamental shift in the way they approach the market and sell their propositions and solutions through a more consultative and solution-centric mindset as against the traditional sales approach.</p>
                        <span class="text-right d-block">Source: Gartner Dec 2019</span>
                    </div>
                </div>
            </div>
        </div>--%>

        <div class="text-center mb-3"><a href="#" onclick="fnMenu(4, this)" class="btns btn-submit">Next</a></div>
    </div>
    <!------------ End English--------------->

    <!------------ Indonesia--------------->
    <div id="dvIndonesia" style="display: none">
        <div class="section-title">
            <h3 class="text-center">KEUNGGULAN GTC YANG BERKEMBANG  DALAM LAYANAN (MANAGED SERVICES)</h3>
            <div class="title-line-center"></div>
        </div>
        <p>GTC telah membangun kredibilitas atas operasi jaringannya dan telah menjalin lebih dari 50 kontrak Layanan Pengelolaan Lengkap (Managed Services) sejak memperkenalkan layanan ini ke pasar pada tahun 2012. Setelah itu, kontrak-kontrak tersebut kini berkembang mulai dari hanya operasi jaringan biasa hingga ke domain yang lebih besar pada layanan ICT. Saat ini, GTC merupakan One Stop Center untuk solusi konektivitas yang dikelola sepenuhnya. </p>
        <p class="font-weight-bold">GTC memiliki strategi terhadap client delivery, antara lain dengan: mengurangi CAPEX / OPEX, meningkatkan Quality of Experience (QoE) dan mendukung Transformasi Bisnis melalui pendekatan layanan terpusat</p>
        <div class="row">
            <div class="col-md-6 pr-0">
                <p>Hasil dari Model Managed Services delivery yang dimiliki GTC adalah sebagai berikut:</p>
                <ul>
                    <li><span class="font-weight-bold">Metodologi dan eksekusi terbaik</span> - Praktik terbaik terkait basis data dan pengetahuan di seluruh aspek jaringan yang membantu GTC menangani kebutuhan klien sepanjang siklus proyek</li>
                    <li><span class="font-weight-bold">Tools dan platform yang telah teruji</span> - Dengan kehadiran multi-vendor, kapabilitas multi-teknologi mendukung lebih dari 1500 produk dari lebih dari 490 vendor, GTC mampu memenuhi kebutuhan klien di berbagai jenis teknologi dan aplikasi dengan tepat </li>
                    <li><span class="font-weight-bold">Pengalaman dan Kematangan</span> - Dengan kehadiran tenaga kerja yang memiliki berbagai pengalaman di industri Layanan Pengelolaan Lengkap, GTC memiliki pengetahuan dan perspektif untuk membantu klien berevolusi menuju ke layanan konvergensi (converged services)</li>
                    <li><span class="font-weight-bold">Keahlian dan Kredensial</span> - Dengan lebih dari 50 jaringan pelanggan yang mendukung lebih dari 100 juta pelanggan (subscribers) di seluruh dunia, GTC memahami bagaimana cara membantu klien untuk mencapai tujuan antar layanan (service delivery) mereka</li>
                </ul>
            </div>
            <div class="col-md-6">
                <div class="presence-photo">
                    <img src="../../Images/BI-tabc.png" />
                    <div class="overlay-text">
                        <p>Memunculkan perubahan semacam ini menjadi nyata membutuhkan transformasi bisnis baik untuk klien maupun penyedia layanan. Klien harus memiliki cara-cara baru dalam bekerja untuk mengadopsi model layanan-sentris gen berikutnya (seperti managed services) yang ditawarkan oleh pasar. Untuk penyedia layanan secara internal, hal ini berarti terdapat perubahan mendasar dalam pendekatan pasar dan penjualan proposisi serta solusi mereka melalui pola pikir yang lebih konsultatif dan berpusat pada solusi dibandingkan dengan pendekatan penjualan tradisional. </p>
                        <span class="text-right d-block">Sumber: Gartner Desember 2019</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mb-3"><a href="#" onclick="fnMenu(4, this)" class="btns btn-submit">Selanjutnya</a></div>

    </div>
    <!------------ End Indonesia--------------->

    <!------------ Sinhala--------------->
    <div id="dvSinhala" style="display: none">
        <div class="section-title">
            <h3 class="text-center">කළමනාකරණ සේවා තුල GTC හි වර්ධනය වන නායකත්වය (GTC’s GROWING LEADERSHIP PRESENCE IN MANAGED SERVICES)</h3>
            <div class="title-line-center"></div>
        </div>
        <p>
            GTC ආයතනය සිය ජාල මෙහෙයුම්, විශ්වසනීයත්වය මත ගොඩනගා ඇති අතර , 2012 දී මෙම සේවාව වෙළඳපොළට හඳුන්වා දුන් දින සිට කළමනාකරණ සේවා කොන්ත්‍රාත්තු 50 කට වැඩි ප්‍රමාණයක් දිනා ගෙන ඇත. මෙම කොන්ත්‍රාත්තු මේ වන විට ජාල මෙහෙයුම්වල සිට තොරතුරු හා සන්නිවේදන තාක්‍ෂණ  සේවාවන්හි (ICT) විශාල වසම් (Domain) දක්වා ව්‍යාප්ත වෙමින් පවතී. අද වන විට GTC ආයතනය සම්පුර්ණයෙන් කළමනාකරණය කළ සම්බන්ධතා විසඳුම් (Fully managed connectivity solutions) සඳහා එක් නැවතුම් මධ්‍යස්ථානයකි (One Stop Centre).
        </p>
        <p class="font-weight-bold">
            GTC ආයතනය විසින් සේවාදායකයින්ට ලබා දීමට සැලසුම් කර ඇත්තේ: CAPEX / OPEX අඩු කිරීම, අත්දැකීම්වල ගුණාත්මකභාවය වැඩි දියුණු කිරීම (QoE) සහ සේවා කේන්ද්‍රීය ප්‍රවේශයක් තුළින් ව්‍යාපාර පරිවර්තනය (Transformation through a service-centric approach) සක්‍රිය කිරීමයි.
        </p>
        <div class="row">
            <div class="col-md-6 pr-0">
                <p>GTC  කළමනාකරණ සේවා දීයත් කිරීමේ ආකෘතිය ගෙන එනු ලබන්නේ:</p>
                <ul>
                    <li><span class="font-weight-bold">හොඳම පන්තියේ ක්‍රමවේදයන් සහ ක්‍රියාත්මක කිරීම්: </span>ජාලයේ සෑම අංශයකින්ම පවතින ඉහළ පරිච දත්ත ගබඩාව සහ දැනුම තුලින් ව්‍යාපෘති ජීවන චක්‍රය පුරා GTC ආයතනයේ හී සේවාදායකයින්ගේ අවශ්‍යතා සපුරාලීමට හැකි වේ.</li>
                    <li><span class="font-weight-bold">ක්ෂේත්‍ර-සහතික  කළ උපකරණ සහ වේදිකා: </span>වෙළදුන් 490 කට වැඩි සංඛ්‍යාවක නිෂ්පාදන 1500 කට වැඩි ගණනකට සහාය දක්වන බහු-විකුණුම්, බහු-තාක්‍ෂණික හැකියාවන්ගෙන් යුත් GTC හට විවිධ තාක්‍ෂණයන් හා යෙදුම් හරහා ගනුදෙනුකරුවන්ගේ නිශ්චිත අවශ්‍යතා සපුරාලීමට හැකි වේ.</li>
                    <li><span class="font-weight-bold">පළපුරුද්ද සහ පරිණතභාවය :</span> කළමනාකරණ සේවා ක්ෂ්‍රේතයේ දශකයකට වැඩි පළපුරුද්දක් සහිත සේවකයින් සමඟ, සේවාදායකයින්ට සාම්ප්‍රදායික සේවාවන් වල සිට නුතන සේවාවන් දක්වා විකාශනය වීමට උපකාර කිරීමට GTC ආයතනයට දැනුම හා දැක්මක් ඇත.  </li>
                    <li><span class="font-weight-bold">ප්‍රවීණත්වය සහ අක්තපත්‍</span>ලොව පුරා මිලියන 100 කට අධික ග්‍රාහකයින්ට සහය දක්වන පාරිභෝගික ජාල 50 කට වැඩි සංඛ්‍යාවක් සමඟින්, සේවාදායකයින්ට ඔවුන්ගේ සේවා සැපයුම් ඉලක්ක සපුරා ගැනීමට සහය දක්වනූ ලබන්නේ කෙසේදැයි යන්න පිලිබද GTC ආයතනය දැනුවත්ව ඇත.</li>
                </ul>
            </div>
            <div class="col-md-6">
                <div class="presence-photo">
                    <img src="../../Images/BI-tabc.png" />
                    <div class="overlay-text" style="font-size: .735rem;">
                        <p>මේ ආකාරයේ වෙනසක් යථාර්ථයක් බවට පත් කිරීම සඳහා ගනුදෙනුකරුවන් සහ සේවා සපයන්නන් යන දෙපාර්ශවයට ව්‍යාපාර පරිවර්තනයකට වඩා දෙයක් අවශ්‍ය නොවේ. වෙළඳපල විසින් පිරිනමනු ලබන මීළඟ පරම්පරාවේ (Next gen) සේවා කේන්ද්‍රීය ආකෘති (කළමනාකරණ සේවා වැනි) යොදා ගැනිම සඳහා සේවාදායකයින් නව වැඩ කිරීමේ ක්‍රම අනුගමනය කළ යුතුය. අභ්‍යන්තරව සේවා සපයන්නන් සඳහා, එයින් අදහස් කරන්නේ ඔවුන් වෙළඳපල වෙත ළඟා වන ආකාරය සාම්ප්‍රදායික විකුණුම් ප්‍රවේශයට වඩා උපදේශාත්මක හා විසඳුම් කේන්ද්‍රීය මානසිකත්වයක් තුළින් ඔවුන්ගේ යෝජනා සහ විසඳුම් අලෙවි කරන ආකාරයෙහි මූලික වෙනසක් යන්නයි.</p>
                        <span class="text-right d-block">මුලාශ්‍රය: ගාට්නර් දෙසැම්බර් 2019</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mb-3"><a href="#" onclick="fnMenu(4, this)" class="btns btn-submit">ඊළඟ</a></div>
    </div>
    <!------------ End Sinhala--------------->

    <!------------ Tamil--------------->
    <div id="dvTamil">
        <div class="section-title">
            <h3 class="text-center">நிர்வகிக்கப்பட்ட சேவைகளில் ஜி.டி.சியின் வளர்ந்து வரும் தலைமைத்துவ முன்னுரிமை</h3>
            <div class="title-line-center"></div>
        </div>
        <p>
            ஜி.டி.சி அதன் வலைப்பின்னல்(network) செயல்பாட்டு நம்பகத்தன்மையை உருவாக்கியதன் ஊடாக 2012 ஆம் ஆண்டில் இந்த சேவையை சந்தையில் அறிமுகப்படுத்தியதிலிருந்து 50 க்கும் மேற்பட்ட நிர்வகிக்கப்பட்ட சேவை ஒப்பந்தங்களை வென்றுள்ளது. இந்த ஒப்பந்தங்கள் இப்போது  வலைப்பின்னல் செயல்பாடுகளிலிருந்து தகவல் மற்றும் தொடர்பு தொழில்நுட்ப (ICT) சேவைகளின் பெரிய களத்திற்கு விரிவடைந்து வருகின்றன. ஜி.டி.சி இன்று முழுமையாக நிர்வகிக்கப்படும் இணைப்பு தீர்வுகளுக்கான ஒரு மையமாக உள்ளது.
        </p>
        <p class="font-weight-bold">
            வாடிக்கையாளர் விநியோகத்தில் மூலதன செலவுகள் (CAPEX) / இயக்க செலவுகள் (OPEX) குறைத்தல், அனுபவத்தின் தரத்தை மேம்படுத்துதல் (QoE) மற்றும் சேவை மைய அணுகுமுறையின் மூலம் வணிக மாற்றத்தை இயக்குதல் மூலம் தாக்கத்தை ஏற்படுத்த ஜி.டி.சி திட்டமிட்டுள்ளது:.
        </p>
        <p>ஜிடிசி நிர்வகிக்கப்பட்ட சேவைகள் விநியோக மாதிரியின் சிறப்பம்சங்கள்</p>
        <div class="presence-photo pull-right" style="max-width: 445px; margin-left: 15px; margin-right: -20px;">
            <img src="../../Images/BI-tabc.png" />
            <div class="overlay-text" style="font-size: .735rem;">
                <p>இந்த வகையான மாற்றத்தை ஒரு யதார்த்தமாக்குவதற்கு வாடிக்கையாளர்களுக்கும் சேவை வழங்குனர்களுக்கும் வணிக மாற்றத்தை விட எதுவும் தேவையில்லை. சந்தையில் வழங்கப்படும் புதிய சேவை மைய மாதிரிகள் (நிர்வகிக்கப்பட்ட சேவைகள் போன்றவை) பின்பற்ற வாடிக்கையாளர்கள் புதிய வேலை வழிகளைத் தழுவ வேண்டும். உள்ளக சேவை வழங்குனர்களைப் பொறுத்தவரை, அவர்கள் சந்தையை அணுகும் முறையிலும், அவர்களின் முன்மொழிவுகளையும் தீர்வுகளையும் பாரம்பரிய விற்பனை அணுகுமுறைக்கு மாறாக மிகவும் ஆலோசனை மற்றும் தீர்வு மையமாகக் கொண்ட மனநிலையின் மூலம் விற்கும் விதத்தில் ஒரு அடிப்படை மாற்றத்தைக் குறிக்கிறது. </p>
                <span class="text-right d-block">ஆவணம்: கார்ட்னர் டிசம்பர் 2019</span>
            </div>
        </div>
        <ul>
            <li><span class="font-weight-bold">சிறந்த முறைகள் மற்றும் செயல்படுத்தல்</span> - வலைப்பின்னலின் அனைத்து அம்சங்களிலும் சிறந்த      தரவுத்தள நடைமுறைகள் மற்றும் அறிவினை கொண்டிருப்பது, ஜி.டி.சிக்கு வாடிக்கையாளர் தேவைகளை கண்டறிய உதவுகிறது.</li>
            <li><span class="font-weight-bold">புலம் நிரூபிக்கப்பட் கருவிகள் மற்றும் தளங்கள்</span> - 490 க்கும் மேற்பட்ட விற்பனையாளர்களிடமிருந்து 1500 க்கும் மேற்பட்ட தயாரிப்புகளை ஆதரிக்கும் பல விற்பனையாளர் (Multi vendor), பல தொழில்நுட்ப (multi technology) திறன்கள் மூலம், ஜி.டி.சி வாடிக்கையாளர்களின் பல்வேறு தொழில்நுட்பங்கள் மற்றும் செயலிகளின் துல்லியமான தேவைகளை பூர்த்தி செய்ய முடிகிறது.</li>
            <li><span class="font-weight-bold">அனுபவம் மற்றும் முதிர்ச்சி</span> - நிர்வகிக்கப்பட்ட சேவைகள் துறையில் ஒரு தசாப்தத்திற்கும் மேலான அனுபவமுள்ள ஊழியர்களுடன்,  வாடிக்கையாளர்களுக்கு தொடர்ச்சியாக ஒருங்கிணைந்த சேவைகளுக்குப் பரிணமிக்க உதவும் அறிவும் முன்னோக்கு சிந்தனையும் ஜி.டி.சியிடம் உள்ளது.</li>
            <li><span class="font-weight-bold">நிபுணத்துவம் மற்றும் நற்சான்றிதழ்கள்</span> - உலகெங்கிலும் 100 மில்லியனுக்கும் அதிகமான சந்தாதாரர்களை 50 க்கும் மேற்பட்ட வாடிக்கையாளர் வலைப்பின்னல்களை(network) ஆதரிப்பதால், வாடிக்கையாளர்களுக்கு அவர்களின் சேவை வழங்கல் இலக்குகளை பூர்த்தி செய்ய உதவுவது எப்படி என்பதை ஜி.டி.சி அறியும்.</li>
        </ul>

        <div class="text-center mb-3"><a href="#" onclick="fnMenu(4, this)" class="btns btn-submit">அடுத்து</a></div>
    </div>
    <!------------ End Tamil--------------->

    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

