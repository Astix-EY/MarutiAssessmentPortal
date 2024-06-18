<%@ Page Title="" Language="VB" MasterPageFile="~/DataA/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="MarketOverview.aspx.vb" Inherits="Data_Information_MarketOverview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "CompanyOverview.aspx";
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
            <h3 class="text-center">Market Presence</h3>
            <div class="title-line-center"></div>
        </div>
        <%--   <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>--%>

        <img src="../../Images/Market.jpg" class="img-thumb pull-right" />
        <p>It has established a robust network of distribution channels, which are enhanced by digital sales platforms, ensuring a seamless and efficient customer purchasing experience across the domestic market. Additionally, it is working towards broadening its customer base by targeting tech-savvy consumers and eco-conscious enterprises, by catering to their specific needs and preferences.&nbsp;</p>
        <p>An active player in the global market, its international operations span across energy projects, logistics hubs, and technology ventures, contributing to economic development and social progress worldwide.</p>
        <p>The company's diverse portfolio spans several key sectors, each featuring state-of-the-art products and solutions:</p>
        <p><strong>Automotive Components:</strong> It specializes in advanced engine and electronic systems designed for next-generation vehicles, setting new standards in automotive innovation and performance.</p>
        <p><strong>Consumer Electronics:</strong> The range includes smart appliances and devices equipped with Internet of Things (IoT) capabilities, offering consumers enhanced connectivity and convenience.</p>
        <p><strong>Industrial Machinery:</strong> These solutions provide automated machinery that comes with predictive maintenance features, optimizing operational efficiency and reducing downtime in industrial settings.</p>
        <p><strong>Infrastructure: </strong>This division is engaging with Government agencies for building critical infrastructure assets such as roads and urban development projects, contributing to economic growth and connectivity.</p>
        <p><strong>Renewable Energy:</strong> This division offers high-efficiency components for solar and wind energy generation, which are seamlessly integrated with smart grid technology to support sustainable power solutions.</p>
        <p><strong>Technology Division:</strong> The technology division is at the cutting edge, utilizing artificial intelligence, IoT, and blockchain to create innovative solutions that addresses the evolving needs of businesses and society.</p>

        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(3, this)" class="btns btn-submit">Next</a></div>
    </div>
    <!------------ End English------------------>

    <!------------  Indonesia------------------>
    <div id="dvIndonesia" style="display: none">
        <div class="section-title">
            <h3 class="text-center">GAMBARAN UMUM PASAR</h3>
            <div class="title-line-center"></div>
        </div>
        <p>Dengan dukungan pemerintah terkait agenda transformasi digital, pemain di industri telekomunikasi saat ini tengah mengambil langkah untuk lebih memperhatikan pasar UKM.</p>
        <p>Para pemain di bidang Teknologi Informasi dan Komunikasi/TIK (Information and Communications Technology/ICT) saat ini sedang bertransformasi secara digital terhadap status quo pada lingkungan bisnis di Malaysia. Di Malaysia, transformasi ini menjadi nyata dengan adanya implementasi jaringan 5G. Dengan tingkat kecepatan mencapai 1 GB per detik, kapasitas jaringan yang lebih tinggi yang membuat perangkat terhubung lebih dari 100 kali per kilometer persegi, dan latensi sebesar 1ms, 5G menciptakan babak baru dalam konektivitas untuk individu, bisnis, dan entitas pemerintah. </p>
        <p>Pandemi COVID belakangan ini semakin menambah momentum terkait hal ini. Salah satu industri utama yang terdampak oleh pandemi COVID adalah pendidikan, dimana sebagian besar diantaranya berada dalam segmen UKM, sebagaimana yang dikategorikan secara internal oleh GTC.</p>
        <p>Dengan dilarangnya institusi pendidikan untuk dapat berfungsi secara normal melalui program kelas reguler di Malaysia dan di berbagai belahan dunia lainnya sebagai dampak dari pandemi coronavirus, banyak negara saat ini berupaya untuk mempromosikan dan mendukung pembelajaran online untuk pelajar dari rumah. Namun demikian, terdapat tantangan utama terkait dengan akses ke pendidikan online yang cepat dan mudah. Banyak institusi sekarang bekerja sama dengan operator seluler, penyedia jasa telekomunikasi, penyedia layanan internet (ISP), dan organisasi lainnya untuk meningkatkan akses terhadap sumber daya digital walaupun mereka terpaksa tetap menutup institusinya. Meskipun perubahan ini terlihat sebagai akibat dari pandemi, perubahan-perubahan ini bersifat menetap dan menyebabkan transformasi terhadap bagaimana pendidikan disampaikan di Malaysia maupun seluruh dunia.</p>
        <div class="text-center mt-3"><a href="#" onclick="fnMenu(3, this)" class="btns btn-submit">Selanjutnya</a></div>
    </div>
    <!------------ End Indonesia------------------>

    <!------------ Sinhala------------------>
    <div id="dvSinhala" style="display: none">
        <div class="section-title">
            <h3 class="text-center">උප ටැබ්- වෙලඳපොල පිළිබඳ දළ විශ්ලේෂණය</h3>
            <div class="title-line-center"></div>
        </div>
        <p>ඩිජිටල් පරිවර්තන න්‍යාය පත්‍රයට රජයේ සහාය ඇතිව, ටෙලිකොම් කර්මාන්තයේ නියැලෙන්නන් දැන් සුළු හා මධ්‍ය පරිමාණ ව්‍යාපාර වෙළඳපොළ දෙස සමීප බැල්මක් හෙළමින් සිටිති.</p>
        <p>තොරතුරු හා සන්නිවේදන තාක්ෂණ [ICT -information and communications technology] කර්මාන්තයේ නියැලෙන්නන් මැලේසියාව පුරා ව්‍යාපාරික පරිසරවල තත්වය ඩිජිටල් තත්වයට [digitally transforming] පරිවර්තනය කරමින් සිටී. මැලේසියාවේ, 5G ජාලයන් හි ආගමනයත් සමඟ මෙම පරිවර්තනය ජීවයට පැමිණේ. 1 Gbps දක්වා වේගවත් වේගයකින් [faster speeds], ඉහළ ජාල ධාරිතාවයකින් සහ 1 MS ප්‍රමාදයකින් වර්ග කිලෝමීටරයකට 100 ගුණයකින් වැඩි සම්බන්ධිත උපාංගයන් සම්බන්ධ කර ගැනිමේ හැකියාව, 5G මගින් පුද්ගලයින්, ව්‍යාපාර සහ රජයේ ආයතන සඳහා සම්බන්ධතාවයන් හි නව පරිච්ඡේදයක් නිර්මාණය කරයි.</p>
        <p>මෑත කාලීන COVID වසංගතය මේ සියල්ල වටා ගම්‍යතාවයට එක් කර ඇත. COVID වසංගතය හේතුවෙන් බලපෑමට ලක් වූ ප්‍රධාන කර්මාන්තයක් වන්නේ අධ්‍යාපනයයි. ඒවායින් බොහොමයක් දැනට GTC ආයතනය විසින් අභ්‍යන්තරව වර්ගීකරණය කර ඇති පරිදි සුළු හා මධ්‍ය පරිමාණ ව්‍යාපාරයට අයත් වේ. </p>
        <p>Covid19 වසංගතයේ ප්‍රතිඵලයක් ලෙස මැලේසියාවේ සහ ලොව පුරා අධ්‍යාපන ආයතන වලට පන්ති කාමර ප්‍රමුඛ වැඩසටහන් සාමාන්‍ය පරිදි ක්‍රියාත්මක කිරිමට ඉඩ නොදීම නිසා, බොහෝ රටවල් නිවසේ සිටින සිසුන් සඳහා Online ඉගෙනීම ප්‍රවර්ධනය කිරීම සදහා සහාය දීමට උත්සාහ කරති. කෙසේ වෙතත්, online අධ්‍යාපනයට පහසුවෙන් හා ඉක්මනින් ප්‍රවේශ වීම සම්බන්ධයෙන් නිරන්තර අභියෝගයක් පවතී. බොහෝ ආයතන ජංගම දුරකථන ක්‍රියාකරුවන්, ටෙලිකොම් සපයන්නන්, අයිඑස්පී (ISP) සහ වෙනත් සමාගම් සමඟ ඩිජිටල් සම්පත් සඳහා ප්‍රවේශය වැඩි කිරීමට කටයුතු කරන අතර ඒවා වසා දමා සිටීමට බල කෙරෙයි.  මෙම වෙනස්කම් වසංගතයෙන් ආගමන වු බවක් පෙනෙන්නට තිබුණද, මෙම වෙනස්කම් ලොවෙහි රැඳී ඇති අතර එම නිසා අධ්‍යාපනය ලබා දෙන ආකාරය මැලේසියාව පුරා පමණක් නොව මුළු ලෝකය පුරාම පරිවර්තනය වේ.</p>

        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(3, this)" class="btns btn-submit">ඊළඟ</a></div>
    </div>
    <!------------ End Sinhala------------------>

    <!------------ Tamil------------------>
    <div id="dvTamil">
        <div class="section-title">
            <h3 class="text-center">சந்தை மேற்பார்வை</h3>
            <div class="title-line-center"></div>
        </div>
        <p>அரசாங்கத்தின் ஆதரவுடன் டிஜிட்டல் (Digital) உருமாற்ற நிகழ்ச்சி நிரலில் (Digital transformation agenda), தொலைத் தொடர்புத் துறை வீரர்கள் (players) இப்போது SME சந்தையை உன்னிப்பாக கவனித்து வருகின்றனர்.</p>
        <p>ஐ.சி.டி (தகவல் மற்றும் தகவல் தொடர்பு தொழில்நுட்பம்) (information and communications technology)  வீரர்கள் (players)  மலேசியா முழுவதும் வணிகச் சூழல்களின் நிலையை டிஜிட்டல் (Digital) முறையில் மாற்றியமைக்கின்றனர். மலேசியாவில், இந்த மாற்றம் 5 ஜி நெட்வொர்க்குகளின் (5G networks) வெளியீட்டைக் கொண்டு வருகிறது. 1 ஜி.பி.பி.எஸ் (1 Gbps) வரை வேகம், சதுர கிலோமீட்டருக்கு 100 மடங்கு அதிக நெட்வொர்க் திறன் சதுர கிலோமீட்டருக்கு 100 சாதனங்களை இயக்கும்.மற்றும் 1 எம்.எஸ் தாமதத்துடன் (1 ms latency), 5 ஜி (5G) தனிநபர்கள், வணிகங்கள் மற்றும் அரசாங்க நிறுவனங்களுக்கான இணைப்பில் ஒரு புதிய அத்தியாயத்தை உருவாக்குகிறது.</p>
        <p>சமீபத்திய COVID தொற்றுநோய் இவை அனைத்தையும் சுற்றி இயங்குவதற்கான தூண்டுதலைக் கொண்டுள்ளது. COVID தொற்றுநோயால் பாதிக்கப்பட்டுள்ள ஒரு முக்கிய துறை கல்வி, அவற்றில் பெரும்பாலானவை தற்போது SME பிரிவின் கீழ் வருகின்றன, அவை ஜி.டி.சில்  சேர்க்கப்பட்டுள்ளது.</p>
        <p>கொரோனா வைரஸ் தொற்றுநோயின் விளைவாக மலேசியாவிலும் உலகெங்கிலும் உள்ள வழக்கமான வகுப்பறை திட்டங்கள் மூலமான கல்வி நிறுவனங்கள் சாதாரணமாக செயல்பட அனுமதிக்கப்படாத நிலையில், பல நாடுகள் வீட்டில் மாணவர்களுக்கு ஆன்லைன் கற்றலை ஊக்குவிக்கவும் ஆதரிக்கவும் முயல்கின்றன. இருப்பினும், ஆன்லைன் கல்வியை விரைவாகவும் எளிதாகவும் அணுகுவது தொடர்பான நிலையான சவால் உள்ளது. பல நிறுவனங்கள் மொபைல் ஆபரேட்டர்கள், தொலைத் தொடர்பு வழங்குநர்கள், ஐ.எஸ்.பி மற்றும் பிற நிறுவனங்களுடன் இணைந்து டிஜிட்டல் வளங்களுக்கான அணுகலை அதிகரிக்கின்றன,. இந்த மாற்றங்கள் தொற்றுநோயால் தூண்டப்பட்டதாகத் தோன்றினாலும், இந்த மாற்றங்கள் இங்கு தொடர்ந்து இருக்கின்றன, எனவே மலேசியா முழுவதும் மட்டுமல்ல, உலகம் முழுவதும் கல்வி எவ்வாறு வழங்கப்படுகிறது என்பதை மாற்றியமைக்கிறது.</p>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(3, this)" class="btns btn-submit">அடுத்து</a></div>
    </div>
    <!------------ End Tamil------------------>
    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToolID" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

