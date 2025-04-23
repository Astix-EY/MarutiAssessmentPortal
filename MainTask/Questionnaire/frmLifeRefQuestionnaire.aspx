<%@ Page Title="" Language="C#" MasterPageFile="~/MainTask/MasterPage/Panel_Task3.master" AutoEventWireup="true" CodeFile="frmLifeRefQuestionnaire.aspx.cs" Inherits="CommonData_Questionnaire_frmLifeRefQuestionnaire" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../../Scripts/jquery-ui.js"></script>
    <script src="../../Scripts/webcamV9Main.js"></script>



    <style type="text/css">
        div.clsloader {
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            height: 100%;
            z-index: 200;
            background-color: white;
            opacity: 0.2;
        }

        .droppable-hover {
            background-color: #fff8b7 !important;
        }

        .section-title {
            margin-bottom: 5px !important;
        }

        .content-wrapper {
            margin-left: 30px !important;
        }

        .box {
            width: 33.33333333%;
            float: left;
            position: relative;
            min-height: 1px;
            padding: 0 8px;
            margin: 5px 0;
        }

            .box > .box-header {
                background: #194597;
                padding: 10px 15px;
                color: #FFF;
                font-weight: 600;
                text-transform: uppercase;
                text-align: center;
                border-radius: 6px 6px 0 0;
            }

            .box > .box-body {
                background-color: rgba(86,61,124,.1);
                border: 1px solid #194597;
                min-height: 150px;
                padding: 0 5px 0 2px;
                position: relative;
                border-radius: 0 0 6px 6px;
                -moz-border-radius: 0 0 6px 6px;
                -webkit-border-radius: 0 0 6px 6px;
                max-height: 150px;
                overflow-y: auto;
            }

        .boxLeft {
            width: 49%;
            float: left;
            position: relative;
            min-height: 1px;
            padding: 0 8px;
            margin-left: 10px;
        }

            .boxLeft > .box-header {
                background: #194597;
                padding: 10px 15px;
                color: #FFF;
                font-weight: 600;
                text-transform: uppercase;
                text-align: center;
                border-radius: 6px 6px 0 0;
            }

            .boxLeft > .box-body {
                background-color: rgba(86,61,124,.1);
                border: 1px solid #194597;
                min-height: 340px;
                max-height: 340px;
                overflow-y: auto;
                padding: 4px 5px 0 2px;
                position: relative;
                border-radius: 0 0 6px 6px;
                -moz-border-radius: 0 0 6px 6px;
                -webkit-border-radius: 0 0 6px 6px;
                overflow-x: hidden;
            }

        .clsOptionContainer, .clsOptionContainerSolution, .clsOptionContainerOutcome {
            border: 1px solid #194597;
            min-height: 150px;
            /*counter-reset: step;*/
            padding: 2px;
            border-radius: 6px;
            -moz-border-radius: 6px;
            -webkit-border-radius: 6px;
            max-height: 150px;
            overflow-y: auto
        }



        .ques-panel-no {
            position: absolute;
            top: 0;
            left: -12px;
            margin-top: 2px;
        }

        .ques-panel-no, .ans-panel-no {
            display: inline-block;
            width: 24px;
            height: 24px;
            line-height: 24px;
            border-radius: 50%;
            background: #00A3AE;
            color: #FFF;
            font-weight: 600;
            text-align: center;
        }

        .clsdivdraggable {
            width: 47.8%;
            float: left;
            cursor: pointer;
            position: relative;
            margin-bottom: 3px;
            margin-left: 10px;
            margin-right: 10px;
            border: 1px solid #AAA;
            padding: 2px;
            padding-left: 15px !important;
            font-size: .75rem;
            background: #dee9ff;
            min-height: 42px;
        }

        .clsdivdraggableSolution, .clsdivdraggableOutcome {
            width: 46%;
            float: left;
            cursor: pointer;
            position: relative;
            margin-bottom: 3px;
            margin-left: 10px;
            margin-right: 10px;
            border: 1px solid #AAA;
            padding: 2px;
            padding-left: 15px !important;
            font-size: .75rem;
            background: #dee9ff;
            min-height: 40px;
        }

        .divsort {
            width: 98%;
            float: left;
            cursor: pointer;
            position: relative;
            margin-bottom: 3px;
            margin-left: 10px;
            margin-right: 10px;
            border: 1px solid #AAA;
            padding: 5px;
            padding-left: 15px !important;
            font-size: .75rem;
            background: #dee9ff;
        }


        .clsOptionContainerLeft {
            width: 100%;
            min-height: 340px;
            /*counter-reset: step;*/
            padding: 4px;
            max-height: 340px;
            overflow-y: auto
        }

            .clsOptionContainerLeft > .clsdivdraggable {
                width: 98%;
                float: left;
                cursor: pointer;
                position: relative;
                margin-bottom: 3px;
                margin-left: 8px;
                margin-right: 8px;
                border: 1px solid #AAA;
                padding: 2px;
                font-size: .75rem;
                background: #dee9ff;
            }

        .clsOptionContainerLeftHeader {
            float: left;
            width: 49%;
            border: 1px solid #194597;
            border-radius: 6px;
            -moz-border-radius: 6px;
            -webkit-border-radius: 6px;
        }

            .clsOptionContainerLeftHeader > .box-header {
                background: #194597;
                padding: 10px 15px;
                color: #FFF;
                font-weight: 600;
                text-transform: uppercase;
                text-align: center;
                border-radius: 6px 6px 0 0;
            }

        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            margin-bottom: .0rem !important;
            line-height: 1.0 !important;
        }
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
        .clsImgTitle {
            display: inline-block;
            width: 41px;
            position: absolute;
            background: #fff;
            border: 1px solid #194597;
        }

        span.spn {
            width: 22px;
            height: 22px;
            line-height: 22px;
            border-radius: 50%;
            background: #194597;
            color: #FFF;
            display: inline-block;
            text-align: center;
            margin-left: -25px;
            margin-right: 4px;
        }

        .clsdivBlock {
            width: auto;
            display: inline-block;
            position: relative;
            margin-bottom: 5px;
            margin-left: 30px;
            margin-right: 4px;
            border: 1px solid #AAA;
            padding: 2px;
            font-size: .75rem;
            background: #dee9ff;
        }
    </style>
    <script>


        $(function () {
            $("#liLanguage").hide();
            if ($("#ConatntMatterRight_hdnExerciseStatus").val() != 2) {
                fnBindDragAndDrop();
            } else {
                $("#btnBackToMain").show();
            }
            $("#main_sidebar").hide();
            if ($("#ConatntMatterRight_divMainContainer").find("div[IsHeShe=1]").length > 0) {
                for (var i = 0; i < $("div.clsdivdroppable").length; i++) {
                    if ($("div.clsdivdroppable").eq(i).find("div.clsdivdraggable").length == 0) {
                        $("div.clsdivdroppable").eq(i).droppable('disable');
                    } else {
                        $("div.clsdivdroppable").eq(i).prev().find("input:checkbox").prop("checked", true);
                    }
                }
                if ($("#ConatntMatterRight_hdnExerciseStatus").val() == 2) {
                    $("#ConatntMatterRight_divMainContainer").find("input:checkbox").prop("disabled", true);
                }
            }
        });
        function fnDraggableDivs() {
            $(".clsdivdraggable,.clsdivdraggableSolution,.clsdivdraggableOutcome").draggable({
                start: function (event, ui) {
                    if ($(ui.helper).is("[title]") == true) {
                        var spnText = $(ui.helper).find("span").text();
                        $(ui.helper).html("<span  class='ques-panel-no'>" + spnText + "</span>" + $(ui.helper).attr("title"));
                        $(ui.helper).removeAttr("title");
                    }
                    $(ui.helper).css({ width: "330px", "height": "auto", "border": "1px solid #194597", "background-color": "#e2efd9", "padding": "2px", cursor: "move", "font-size": ".75rem" });
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
        }
        function fnBindDragAndDrop() {
            fnDraggableDivs();
            $(".clsdivdroppable").sortable();

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
                    if ($(ui.draggable).hasClass("ui-draggable")) {
                        var spnText = $(ui.draggable).find("span").text();
                        $(ui.draggable).find("span").remove("span")
                        var text = $(ui.draggable).html();

                        if ($(ui.draggable).is("[title]") == false) {
                            $(ui.draggable).attr("title", text);
                        }
                        var QstnTypeID = $(ui.draggable).attr("QstnTypeID");
                        var IsSequencing = $(ui.draggable).attr("IsSequencing");

                        if (QstnTypeID == 7 || QstnTypeID == 10) {
                            text = text.length > 55 ? text.substr(0, 54) + "..." : text;
                            $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                            $(ui.draggable).css({ "width": "98%", "min-height": "20px" }).appendTo(this);
                        } else if (QstnTypeID == 8) {
                            $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                            if (IsSequencing == 0) {
                                $(ui.draggable).css({ "width": "98%" }).appendTo(this);
                            } else {
                                var id = $(ui.draggable)[0].id;
                                $(ui.draggable).remove();
                                $(this).append($('<div id=' + id + ' qstntypeid="8">').html("<span  class='ques-panel-no'>" + spnText + "</span>" + text).addClass("divsort"));
                                $('.clsdivdroppable div.divsort').dblclick(function (evt) {
                                    $(this).removeAttr("style").removeClass("divsort").addClass("clsdivdraggable").appendTo($(".clsOptionContainerLeft"));
                                    fnDraggableDivs();
                                });
                            }
                        } else {
                            $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                            $(ui.draggable).appendTo(this);
                        }
                    }
                }
            });


            $(".clsdivdroppableSolution").droppable({
                accept: ".clsdivdraggableSolution",
                activeClass: 'droppable-active',
                hoverClass: 'droppable-hover',
                over: function (event, ui) {
                    //var $this = $(this);
                },
                drop: function (event, ui) {
                    if ($(this).children().length == $(this).data("max")) {
                        return false;
                    }
                    if ($(ui.draggable).hasClass("ui-draggable")) {
                        var spnText = $(ui.draggable).find("span").text();
                        $(ui.draggable).find("span").remove("span")
                        var text = $(ui.draggable).html();

                        if ($(ui.draggable).is("[title]") == false) {
                            $(ui.draggable).attr("title", text);
                        }
                        var QstnTypeID = $(ui.draggable).attr("QstnTypeID");
                        var IsSequencing = $(ui.draggable).attr("IsSequencing");

                        if (QstnTypeID == 7 || QstnTypeID == 10) {
                            text = text.length > 55 ? text.substr(0, 54) + "..." : text;
                            $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                            $(ui.draggable).css({ "width": "97%", "min-height": "30px" }).appendTo(this);
                        } else if (QstnTypeID == 8) {
                            $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                            if (IsSequencing == 0) {
                                $(ui.draggable).css({ "width": "98%" }).appendTo(this);
                            } else {
                                var id = $(ui.draggable)[0].id;
                                $(ui.draggable).remove();
                                $(this).append($('<div id=' + id + ' qstntypeid="8">').html("<span  class='ques-panel-no'>" + spnText + "</span>" + text).addClass("divsort"));
                                $('.clsdivdroppable div.divsort').dblclick(function (evt) {
                                    $(this).removeAttr("style").removeClass("divsort").addClass("clsdivdraggable").appendTo($(".clsOptionContainerLeft"));
                                    fnDraggableDivs();
                                });
                            }
                        } else {
                            $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                            $(ui.draggable).appendTo(this);
                        }
                    }
                }
            });

            $(".clsdivdroppableOutcome").droppable({
                accept: ".clsdivdraggableOutcome",
                activeClass: 'droppable-active',
                hoverClass: 'droppable-hover',
                over: function (event, ui) {
                    //var $this = $(this);
                },
                drop: function (event, ui) {
                    if ($(this).children().length == $(this).data("max")) {
                        return false;
                    }
                    if ($(ui.draggable).hasClass("ui-draggable")) {
                        var spnText = $(ui.draggable).find("span").text();
                        $(ui.draggable).find("span").remove("span")
                        var text = $(ui.draggable).html();

                        if ($(ui.draggable).is("[title]") == false) {
                            $(ui.draggable).attr("title", text);
                        }
                        var QstnTypeID = $(ui.draggable).attr("QstnTypeID");
                        var IsSequencing = $(ui.draggable).attr("IsSequencing");

                        if (QstnTypeID == 7 || QstnTypeID == 10) {
                            text = text.length > 55 ? text.substr(0, 54) + "..." : text;
                            $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                            $(ui.draggable).css({ "width": "97%", "min-height": "30px" }).appendTo(this);
                        } else if (QstnTypeID == 8) {
                            $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                            if (IsSequencing == 0) {
                                $(ui.draggable).css({ "width": "98%" }).appendTo(this);
                            } else {
                                var id = $(ui.draggable)[0].id;
                                $(ui.draggable).remove();
                                $(this).append($('<div id=' + id + ' qstntypeid="8">').html("<span  class='ques-panel-no'>" + spnText + "</span>" + text).addClass("divsort"));
                                $('.clsdivdroppable div.divsort').dblclick(function (evt) {
                                    $(this).removeAttr("style").removeClass("divsort").addClass("clsdivdraggable").appendTo($(".clsOptionContainerLeft"));
                                    fnDraggableDivs();
                                });
                            }
                        } else {
                            $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                            $(ui.draggable).appendTo(this);
                        }
                    }
                }
            });

            $(".clsOptionContainerSolution").droppable({
                accept: ".clsdivdraggableSolution",
                activeClass: 'droppable-active',
                hoverClass: 'droppable-hover',
                over: function (event, ui) {
                    //var $this = $(this);
                },
                drop: function (event, ui) {
                    if ($(ui.draggable).is("[title]") == true) {
                        var spnText = $(ui.draggable).find("span").text();
                        $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + $(ui.draggable).attr("title"));
                        $(ui.draggable).removeAttr("title");
                    }
                    //var text = $(ui.draggable).attr("title");
                    //var spnText = $(ui.draggable).find("span").text();
                    //$(ui.draggable).find("span").remove("span");
                    //$(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                    //$(ui.draggable).removeAttr("title");
                    $(ui.draggable).removeAttr("style").appendTo(this);
                }
            });

            $(".clsOptionContainerOutcome").droppable({
                accept: ".clsdivdraggableOutcome",
                activeClass: 'droppable-active',
                hoverClass: 'droppable-hover',
                over: function (event, ui) {
                    //var $this = $(this);
                },
                drop: function (event, ui) {
                    if ($(ui.draggable).is("[title]") == true) {
                        var spnText = $(ui.draggable).find("span").text();
                        $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + $(ui.draggable).attr("title"));
                        $(ui.draggable).removeAttr("title");
                    }
                    //var text = $(ui.draggable).attr("title");
                    //var spnText = $(ui.draggable).find("span").text();
                    //$(ui.draggable).find("span").remove("span");
                    //$(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                    //$(ui.draggable).removeAttr("title");
                    $(ui.draggable).removeAttr("style").appendTo(this);
                }
            });
            $(".clsOptionContainer").droppable({
                activeClass: 'droppable-active',
                hoverClass: 'droppable-hover',
                over: function (event, ui) {
                    //var $this = $(this);
                },
                drop: function (event, ui) {
                    if ($(ui.draggable).is("[title]") == true) {
                        var spnText = $(ui.draggable).find("span").text();
                        $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + $(ui.draggable).attr("title"));
                        $(ui.draggable).removeAttr("title");
                    }
                    //var text = $(ui.draggable).attr("title");
                    //var spnText = $(ui.draggable).find("span").text();
                    //$(ui.draggable).find("span").remove("span");
                    //$(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                    //$(ui.draggable).removeAttr("title");
                    $(ui.draggable).removeAttr("style").appendTo(this);
                }
            });

            $(".clsOptionContainerLeft").droppable({
                activeClass: 'droppable-active',
                hoverClass: 'droppable-hover',
                over: function (event, ui) {
                    //var $this = $(this);
                },
                drop: function (event, ui) {
                    if ($(ui.draggable).is("[title]") == true) {
                        var spnText = $(ui.draggable).find("span").text();
                        $(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + $(ui.draggable).attr("title"));
                        $(ui.draggable).removeAttr("title");
                    }
                    //var text = $(ui.draggable).attr("title");
                    //var spnText = $(ui.draggable).find("span").text();
                    //$(ui.draggable).find("span").remove("span");
                    //$(ui.draggable).html("<span  class='ques-panel-no'>" + spnText + "</span>" + text);
                    //$(ui.draggable).removeAttr("title");
                    $(ui.draggable).removeAttr("style").appendTo(this);

                }
            });


            $('.clsdivdroppable div.divsort').dblclick(function (evt) {
                $(this).removeAttr("style").removeClass("divsort").addClass("clsdivdraggable").appendTo($(".clsOptionContainerLeft"));
                fnDraggableDivs();
            });

        }

        function fnMyExercise() {
            window.location.href = "../../CommonData/Exercise/ExerciseMain.aspx";
        }

    </script>
    <script type="text/javascript">

        function fnMakeStringForSave() {

            var RspDetID = "";
            var objDetail = [];

            var RspexerciseId = document.getElementById("ConatntMatterRight_hdnRSPExerciseID").value;
            for (var i = 0; i < $("div[flg='idenQuestionContain']").length; i++) {
                var quesId = $("div[flg='idenQuestionContain']").eq(i).attr("questId");
                var rspDetId = $("div[flg='idenQuestionContain']").eq(i).attr("RspDetID");
                var selValues = "";
                $("div[flg='idenQuestionContain']").eq(i).find('input[type=radio]:checked').each(function () {
                    // myArray[i] = $(this).val();
                    selValues += ($(this).val());
                });
                $("div[flg='idenQuestionContain']").eq(i).find('input[type=checkbox]:checked').each(function () {
                    // myArray[i] = $(this).val();
                    if (selValues == "") {
                        selValues += ($(this).val());
                    } else {
                        selValues += "|" + ($(this).val());
                    }
                });

                $("div[flg='idenQuestionContain']").eq(i).find('textarea').each(function () {
                    // myArray[i] = $(this).val();
                    if (selValues == "") {
                        selValues += $(this).val().replace('^', '');
                    } else {
                        selValues += "|" + $(this).val().replace('^', '');
                    }
                });
                $("div[flg='idenQuestionContain']").eq(i).find("input[type='text']").each(function () {
                    // myArray[i] = $(this).val();
                    if (selValues == "") {
                        selValues += $(this).val().replace('^', '');
                    } else {
                        selValues += "|" + $(this).val().replace('^', '');
                    }
                });

                $("div[flg='idenQuestionContain']").eq(i).find("select").each(function () {
                    if ($(this).val() != 0) {
                        if (selValues == "") {
                            selValues += $(this).val().replace('^', '');
                        } else {
                            selValues += "|" + $(this).val().replace('^', '');
                        }
                    }
                });

                if (selValues != "") {
                    selValues = "-1^" + selValues;
                    var dataArray = new Array();
                    dataArray = [{
                        RspDetID: rspDetId, QstId: quesId, RspexerciseId: RspexerciseId, ActualAnswer: selValues
                    }];
                    objDetail.push(dataArray[0]);
                }
            }
            // alert(selValues)
            return objDetail;
        }
        //$("input[type='radio']").on("change", function () {
        //    //fnshowDependentQstn(this);
        //    $("input[type='radio']").removeClass("RadioBackgrouncolor");

        //});
        //$("input[type='checkbox']").on("change", function () {
        //    //fnshowDependentQstn(this);
        //    $("input[type='checkbox']").removeClass("RadioBackgrouncolor");

        //});
        function fnCheckValidationForRadio() {
            var chkRadioFlag = true;
            $("input:radio").each(function () {
                var name = $(this).attr("name");
                //alert("name=" + name)
                var $checked = $("input:radio[name=" + name + "]:checked").length;
                //   alert($checked)
                if ($checked == 0) {
                    alert("Please select one option.")
                    $("input:radio[name=" + name + "]").eq(0).focus();
                    $("input:radio[name=" + name + "]").eq(0).addClass("RadioBackgrouncolor");
                    document.getElementById("btnNext").disabled = false;
                    chkRadioFlag = false;
                    return false;
                }

            });


            return chkRadioFlag;

        }
        function fnCheckValidationForCheckbox() {
            var chkCheckboxFlag = true;
            $("input:checkbox").each(function () {
                var name = $(this).attr("name");
                var MaxQstnSelected = $(this).attr("MaxQstnSelected");
                // alert("MaxQstnSelected=" + MaxQstnSelected)
                var $checked = $("input:checkbox[name=" + name + "]:checked").length;
                // alert($checked)
                if ($checked == 0) {
                    alert("Please select the options.")
                    $("input:checkbox[name=" + name + "]").eq(0).focus();
                    $("input:checkbox[name=" + name + "]").eq(0).addClass("RadioBackgrouncolor");
                    document.getElementById("btnNext").disabled = false;
                    chkCheckboxFlag = false;
                    return false;
                }
                if (($checked < MaxQstnSelected) || ($checked > MaxQstnSelected)) {
                    alert("Please select " + MaxQstnSelected + " options.")
                    $("input:checkbox[name=" + name + "]").eq(0).focus();
                    document.getElementById("btnNext").disabled = false;
                    chkCheckboxFlag = false;
                    return false;
                }

            });
            return chkCheckboxFlag;

        }

        function fnCheckValidationForTextArea() {
            var chkRadioFlag = true;

            $('textarea').each(function () {
                //var selValues = $(this).val().replace('^', '');
                var selValues = $(this).val().replace('^', '');
                var flgalloptioncompulsory = $(this).attr("flgalloptioncompulsory");
                //  if (selValues == "") {
                if (selValues.trim() === "" && flgalloptioncompulsory == 1) {
                    chkRadioFlag = false;
                    $(this).addClass("RadioBackgrouncolor");
                    $(this).focus();
                    return false;
                }
                else {
                    $(this).removeClass("RadioBackgrouncolor");
                }
            });
            if (chkRadioFlag == false) {
                alert("Please enter the response")

                document.getElementById("btnNext").disabled = false;
            }
            return chkRadioFlag;
        }

        function fnCheckValidationForTextBox() {
            var chkRadioFlag = true;

            $("input[type='text']").each(function () {
                //var selValues = $(this).val().replace('^', '');
                var selValues = $(this).val().replace('^', '');
                var flgalloptioncompulsory = $(this).attr("flgalloptioncompulsory");
                //  if (selValues == "") {
                if (selValues.trim() === "" && flgalloptioncompulsory == 1 && $(this).prop("disabled") == false) {
                    chkRadioFlag = false;
                    $(this).addClass("RadioBackgrouncolor");
                    $(this).focus();
                    return false;
                }
                else {
                    $(this).removeClass("RadioBackgrouncolor");
                }
            });
            if (chkRadioFlag == false) {
                alert("Please enter the response")

                document.getElementById("btnNext").disabled = false;
            }
            return chkRadioFlag;
        }

        function fnCheckValidationForDropDown() {
            var chkRadioFlag = true;

            $("select").each(function () {
                //var selValues = $(this).val().replace('^', '');
                var selValues = $(this).val().replace('^', '');
                var flgalloptioncompulsory = $(this).attr("flgalloptioncompulsory");
                //  if (selValues == "") {
                if (selValues.trim() === "0" && flgalloptioncompulsory == 1 && $(this).prop("disabled") == false) {
                    chkRadioFlag = false;
                    $(this).addClass("RadioBackgrouncolor");
                    $(this).focus();
                    return false;
                }
                else {
                    $(this).removeClass("RadioBackgrouncolor");
                }
            });
            if (chkRadioFlag == false) {
                alert("Please select the response")
                document.getElementById("btnNext").disabled = false;
            }
            return chkRadioFlag;
        }

        function fnSave(Status, Direction) {
            if (Direction == 2) {

                if (fnCheckValidationForTextBox() == false) {
                    return false;
                }

                if (fnCheckValidationForTextArea() == false) {
                    return false;
                }
                if (fnCheckValidationForDropDown() == false) {
                    return false;
                }

            }
            var strRet = fnMakeStringForSave();

            fnSaveData(Status, strRet, 0, Direction);

        }
        $(document).ready(function () {
            //$("#ConatntMatterRight_hdnExerciseStatus").hide();
            if ($("#ConatntMatterRight_hdnExerciseStatus").val() != 2) {
                setInterval(function () {
                    var strRet = fnMakeStringForSave();
                    var LoginID = document.getElementById("ConatntMatterRight_hdnLoginID").value;
                    var RspexerciseId = document.getElementById("ConatntMatterRight_hdnRSPExerciseID").value;
                    PageMethods.fnUpdateUserExerciseResponses(RspexerciseId, strRet, 1, 0, LoginID, function (result) {});
                }, 5000);
            }
        });

        function fnNext() {
            Status = 1;
            Direction = 2;

            if ($("#ConatntMatterRight_hdnExerciseStatus").val() != 2) {
                if (isTimeFinished == 0) {
                    if (parseInt(document.getElementById("ConatntMatterRight_hdnPageNmbr").value) == parseInt(document.getElementById("ConatntMatterRight_hdnTotQstn").value)) {
                        Status = 2
                        if (!window.confirm("If you have completed this task click OK. If you would like to go back to any question of this task, click Cancel. Once you click OK, your responses would be submitted and you cannot come back to this task.")) {
                            return false;
                        }
                    }
                } else {
                    Status = 2;
                }

                fnSave(Status, Direction);
            }
            else {

                if (parseInt(document.getElementById("ConatntMatterRight_hdnPageNmbr").value) > parseInt(document.getElementById("ConatntMatterRight_hdnTotQstn").value)) {
                    document.getElementById("ConatntMatterRight_hdnPageNmbr").value = "1";
                }
                var PgNmbr = document.getElementById("ConatntMatterRight_hdnPageNmbr").value;
                if (Direction == 2) {
                    PgNmbr = parseInt(PgNmbr, 10) + 1
                }
                else {
                    PgNmbr = parseInt(PgNmbr, 10) - 1
                    PgNmbr = PgNmbr <= 0 ? 1 : PgNmbr;
                }
                document.getElementById("ConatntMatterRight_hdnPageNmbr").value = PgNmbr;
                fnGetQstnDetail();
            }

        }
        function fnPrevious() {
            Status = 1;
            Direction = 1;

            if ($("#ConatntMatterRight_hdnExerciseStatus").val() != 2) {
                fnSave(Status, Direction);
            } else {
                var PgNmbr = document.getElementById("ConatntMatterRight_hdnPageNmbr").value;
                if (Direction == 2) {
                    PgNmbr = parseInt(PgNmbr, 10) + 1
                }
                else {
                    PgNmbr = parseInt(PgNmbr, 10) - 1
                    PgNmbr = PgNmbr <= 0 ? 1 : PgNmbr;
                }
                document.getElementById("ConatntMatterRight_hdnPageNmbr").value = PgNmbr;
                if (parseInt(document.getElementById("ConatntMatterRight_hdnPageNmbr").value) <= 0) {
                    document.getElementById("ConatntMatterRight_hdnPageNmbr").value = document.getElementById("ConatntMatterRight_hdnTotQstn").value;
                }
                fnGetQstnDetail();
            }
        }

        function fnChangeDependentQstn(sender, QstID) {
            if ($(sender).find("option:selected").text() == "Yes") {
                $(".clsDepedent_" + QstID).prop("disabled", false);
            }
            else {
                $(".clsDepedent_" + QstID).prop("disabled", true);
                $(".clsDepedent_" + QstID).val("0");
                var QstID1 = $(".clsDepedent_" + QstID).attr("QstID");
                if ($(".clsDepedent_" + QstID).length > 1) {
                    $(".clsDepedent_" + QstID).eq(1).val("");
                }
                $(".clsDepedent_" + QstID1).val("");
                $(".clsDepedent_" + QstID1).prop("disabled", true);
            }

        }

        function fnSaveData(Status, strResult, flgTimeOver, Direction) {
            //alert("Saving");
            //alert(Status);
            //alert(strResult);
            //Direction = 2;
            var LoginID = document.getElementById("ConatntMatterRight_hdnLoginID").value;
            var RspexerciseId = document.getElementById("ConatntMatterRight_hdnRSPExerciseID").value;
            if (Status == 2) {
                $("#loader").show();
            }
            //alert(LoginID);
            //alert(RspexerciseId);
            //alert(strResult);
            //alert(Status);
            //alert(flgTimeOver);
            //alert(LoginID);
            //alert(Direction);
            //alert(Status);
            PageMethods.fnUpdateUserExerciseResponses(RspexerciseId, strResult, Status, flgTimeOver, LoginID, fnUpdateResponsesForCAseStudy, fnUpdateResponsesForCAseStudyFailed, Direction + "^" + Status);
        }

        function fnSaveData_Timer(Status, strResult, flgTimeOver) {
            var LoginID = document.getElementById("ConatntMatterRight_hdnLoginID").value;
            var RspexerciseId = document.getElementById("ConatntMatterRight_hdnRSPExerciseID").value;
            var PgNmbr = document.getElementById("ConatntMatterRight_hdnPageNmbr").value;
            PageMethods.fnUpdateUserExerciseResponses(RspexerciseId, strResult, Status, PgNmbr, flgTimeOver, LoginID, Direction, function (Result) { }, function (Result) { });
        }

        function fnUpdateResponsesForCAseStudy(result, strRep) {
            if (result.split("^")[0] == "1") {
                // alert("Success")
                //window.location.href=""
                var ExerciseID = document.getElementById("ConatntMatterRight_hdnExerciseID").value;
                var RspexerciseId = document.getElementById("ConatntMatterRight_hdnRSPExerciseID").value;
                var PgNmbr = document.getElementById("ConatntMatterRight_hdnPageNmbr").value
                var ToolID = document.getElementById("ConatntMatterRight_hdnToolID").value;
                var Direction = strRep.split("^")[0]
                var Status = strRep.split("^")[1]
                if (Status == 2 && Direction == 2) {
                    window.location.href = "../Exercise/ExerciseMain.aspx?MenuID=8&ToolID=" + ToolID;
                    return false;
                }
                var PgNmbr = document.getElementById("ConatntMatterRight_hdnPageNmbr").value;
                if (Direction == 2) {
                    PgNmbr = parseInt(PgNmbr, 10) + 1
                }
                else {
                    PgNmbr = parseInt(PgNmbr, 10) - 1
                    PgNmbr = PgNmbr <= 0 ? 1 : PgNmbr;
                }
                document.getElementById("ConatntMatterRight_hdnPageNmbr").value = PgNmbr;

                fnGetQstnDetail();
            }
        }
        function fnUpdateResponsesForCAseStudyFailed(result) {

        }
        function fnDisableEnableDroppable(sender) {
            if ($(sender).is(":checked")) {
                $(sender).closest("div").next("div.clsdivdroppable").droppable('enable');
            } else {
                $(sender).closest("div").next("div.clsdivdroppable").droppable('disable');
                $(sender).closest("div").next("div.clsdivdroppable").find("div.clsdivdraggable").removeAttr("title");
                $(sender).closest("div").next("div.clsdivdroppable").find("div.clsdivdraggable").removeAttr("style").appendTo($(".clsOptionContainer"));
            }
        }
        function fnGetQstnDetail() {
            var ExerciseID = document.getElementById("ConatntMatterRight_hdnExerciseID").value;
            var RspexerciseId = document.getElementById("ConatntMatterRight_hdnRSPExerciseID").value;
            var TotQstn = document.getElementById("ConatntMatterRight_hdnTotQstn").value;
            var PgNmbr = document.getElementById("ConatntMatterRight_hdnPageNmbr").value;
            var LanguageId = document.getElementById("ConatntMatterRight_hdnLanguageId").value;
            $("#loader").show();
            PageMethods.fnGetQuestionDetails(PgNmbr, ExerciseID, RspexerciseId, TotQstn, LanguageId,
                function (result) {

                    $("#ConatntMatterRight_divMainContainer")[0].innerHTML = result;
                    if ($("#ConatntMatterRight_hdnExerciseStatus").val() == 2) {
                        if (document.getElementById("ConatntMatterRight_hdnPageNmbr").value == document.getElementById("ConatntMatterRight_hdnTotQstn").value) {
                            $("#btnNext").hide();
                        }
                    }

                    $("#loader").hide();

                    if ($("#ConatntMatterRight_hdnExerciseStatus").val() != 2) {
                        fnBindDragAndDrop();
                    }
                    if ($("#ConatntMatterRight_divMainContainer").find("div[IsHeShe=1]").length > 0) {
                        for (var i = 0; i < $("div.clsdivdroppable").length; i++) {
                            if ($("div.clsdivdroppable").eq(i).find("div.clsdivdraggable").length == 0) {
                                if ($("#ConatntMatterRight_hdnExerciseStatus").val() != 2) {
                                    $("div.clsdivdroppable").eq(i).droppable('disable');
                                }
                            } else {
                                $("div.clsdivdroppable").eq(i).prev().find("input:checkbox").prop("checked", true);
                            }
                        }
                    }
                    if ($("#ConatntMatterRight_hdnExerciseStatus").val() == 2) {
                        $("#ConatntMatterRight_divMainContainer").find("input:checkbox,input:radio,button").prop("disabled", true);
                    }
                },
                function (result) {
                    $("#loader").hide();
                    if (Direction == 2) {
                        PgNmbr = parseInt(PgNmbr, 10) - 1
                        PgNmbr = PgNmbr <= 0 ? 1 : PgNmbr;
                    }
                    else {
                        PgNmbr = parseInt(PgNmbr, 10) + 1

                    }
                })
        }
        function fnFillBucketLbl(sender) {
            var BucketNo = $(sender)[0].id.split("_")[1];
            $("#ConatntMatterRight_divMainContainer").find("div.box-header").html($(sender).html());
            $("#ConatntMatterRight_divMainContainer").find("div.box").attr("BucketNo", parseInt(BucketNo) - 1);
            $(sender).closest("div").find("button.active").removeClass("active");
            $(sender).addClass("active");
        }
        function getIdsOfImages() {
            var values = [];
            $(".boxLeft > .box-body > .clsdivdraggable").each(function (index) {
                //values.push($(this).attr("id").replace("imageNo", ""));
            });
            //alert($(".boxLeft > .box-body > .clsdivdraggable").length)
        }
    </script>

    <script type="text/javascript">
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
        var TimerText = "Time Left : ";
        var isTimeFinished = 0;
        //$(document).ready(function () {
        //    if ($("#ConatntMatterRight_hdnExerciseStatus").val() != 2) {
        //        f1();
        //        eventStartMeetingTimer = setInterval("fnStartMeetingTimer()", 5000);
        //    }
        //});
        //hdnCounterRunTime
        function f1() {
            $(document).ready(function () {
                var LngID = $("#hdnLngID").val();
                if (IsUpdateTimer == 0) { return; }
                SecondCounter = parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value);
                if (SecondCounter <= 0) {
                    IsUpdateTimer = 0;
                }
                SecondCounter = SecondCounter - 1;
                SecondCounter = SecondCounter < 0 ? 0 : SecondCounter;
                hours = Math.floor(SecondCounter / 3600);
                Minutes = Math.floor((SecondCounter - (hours * 3600)) / 60);
                Seconds = SecondCounter - (hours * 3600) - (Minutes * 60);

                if (Seconds < 10 && Minutes < 10) {
                    document.getElementById("theTime").innerHTML = TimerText + ":0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds;
                }
                else if (Seconds < 10 && Minutes > 9) {
                    document.getElementById("theTime").innerHTML = TimerText + ":0" + hours + ":" + Minutes + ":" + "0" + Seconds;
                }
                else if (Seconds > 9 && Minutes < 10) {
                    document.getElementById("theTime").innerHTML = TimerText + ":0" + hours + ":" + "0" + Minutes + ":" + Seconds;
                }
                else if (Seconds > 9 && Minutes > 9) {
                    document.getElementById("theTime").innerHTML = TimerText + ":0" + hours + ":" + Minutes + ":" + Seconds;
                }
                document.getElementById("ConatntMatterRight_hdnCounter").value = SecondCounter;
                if (((hours * 60) + Minutes) == 5 && Seconds == 0) {
                    //  alert("hi")
                    $("#dvDialog")[0].innerHTML = "<center>Your Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " .</center>";
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
                }
                counter++;
                if (counter == 5) {//Auto Time Update
                    counter = 0;
                    fnUpdateElapsedTime();
                    var RspDetID = $("#ConatntMatterRight_divMainContainer").find("p[iden='qstn']").attr("RspDetID");
                    var strRet = fnMakeStringForSave();
                    fnSaveData_Timer(1, strRet, 0);

                }

                if (SecondCounter == 0) {
                    if (parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value) == 0) {
                        TimerText = "Time Left : ";
                        document.getElementById("theTime").innerHTML = TimerText + ":00:00:00";
                        IsUpdateTimer = 0;
                        fnUpdateElapsedTime();
                        isTimeFinished = 1;
                        alert("Your time is over now,so you will be redirected from this page after this current question.");
                        var LanguageId = document.getElementById("ConatntMatterRight_hdnLanguageId").value;
                        if (LanguageId == 1) {
                            $("#divNext div.divbtncls").html("<a href=\"###\" onclick=\"fnNext()\" id=\"btnNext\" class=\"btns btn-submit\">சமர்ப்பிக்கவும்</a>");
                        }
                        else if (LanguageId == 2) {
                            $("#divNext div.divbtncls").html("<a href=\"###\" onclick=\"fnNext()\" id=\"btnNext\" class=\"btns btn-submit\">Kirimkan</a>");
                        }
                        else if (LanguageId == 3) {
                            $("#divNext div.divbtncls").html("<a href=\"###\" onclick=\"fnNext()\" id=\"btnNext\" class=\"btns btn-submit\">ඉදිරිපත් කරන්න</a>");
                        }
                        else {
                            $("#divNext div.divbtncls").html("<a href=\"###\" onclick=\"fnNext()\" id=\"btnNext\" class=\"btns btn-submit\">Submit</a>");
                        }
                        counter = 0;
                        return false;
                    }
                    else {
                        IsUpdateTimer = 0;
                        counter = 0;
                        fnUpdateElapsedTime();
                        return false;
                    }
                }
                sClearTime = setTimeout("f1()", 1000);
            });
        }
        var sClearTime;
        function fnUpdateElapsedTime() {
            var RspexerciseId = document.getElementById("ConatntMatterRight_hdnRSPExerciseID").value;
            var TotTimeElapsedSec = document.getElementById("ConatntMatterRight_hdnTimeElapsedSec").value
            PageMethods.fnUpdateTime(RspexerciseId, TotTimeElapsedSec, fnUpdateElapsedTimeSuccess, fnUpdateElapsedTimeFailed);
        }
        function fnUpdateElapsedTimeSuccess(result) {

        }
        function fnUpdateElapsedTimeFailed(result) {
            //    alert(result._message);
        }


        var eventStartMeetingTimer; var flgOpenGotoMeeting = 0; var flgFirst = 0;
        function fnStartMeetingTimer() {

            //$("#loader").show();
            //if (flgOpenGotoMeeting == 0) {
            var RspExerciseID = $("#ConatntMatterRight_hdnRSPExerciseID").val();
            var MeetingDefaultTime = $("#ConatntMatterRight_hdnMeetingDefaultTime").val();
            PageMethods.fnStartMeetingTimer(RspExerciseID, MeetingDefaultTime, function (result) {
                $("#loader").hide();
                if (result.split("|")[0] == "1") {
                    //alert("Error-" + result.split("|")[1]);
                } else {
                    var IsMeetingStartTimer = result.split("|")[1];
                    var MeetingRemainingTime = result.split("|")[2];
                    var PrepRemainingTime = result.split("|")[3];
                    //window.clearInterval(sClearTime);
                    //clearTimeout(sClearTime);
                    if (IsMeetingStartTimer == 1) {
                        flgOpenGotoMeeting = 1;
                        // window.clearInterval(eventStartMeetingTimer);
                        //clearTimeout(eventStartMeetingTimer);
                        document.getElementById("ConatntMatterRight_hdnCounter").value = MeetingRemainingTime;
                        if (MeetingRemainingTime > 0) {
                            IsUpdateTimer = 1;
                            if (flgFirst == 0) {
                                flgFirst = 1;
                                f1();
                            }
                        }
                    } else {
                        document.getElementById("ConatntMatterRight_hdnCounter").value = PrepRemainingTime;
                    }
                }
            }, function (result) {
                $("#loader").hide();
                //alert("Error-" + result._message);
            });
            //} else {
            //    window.clearInterval(eventStartMeetingTimer);
            //    clearTimeout(eventStartMeetingTimer);
            //}
        }
        // document.onload = fnPageLoad();
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
    <%-- <time id="theTime" class="fst-color mr-5">Time Left 00: 00: 00</time>--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <div class="section-title ">
        <h3 class="text-center" id="ExerciseName" runat="server">TASK</h3>
        <div class="title-line-center"></div>
    </div>

    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExerciseTotalTime" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTimeElapsedMin" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTimeElapsedSec" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTimeLeft" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRSPExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRSPDetID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspIDStr" runat="server" Value="0" />
    <asp:HiddenField ID="hdnQstnCntr" runat="server" Value="0" />
    <input id="hdnSaveType" type="hidden" size="2" name="hdnSaveType" runat="server" />
    <input id="hdnPageNmbr" type="hidden" size="2" name="hdnPageNmbr" value="0" runat="server" />
    <input id="hdnDirection" type="hidden" size="2" name="hdnDirection" runat="server" />
    <input id="hdnResult" type="hidden" name="hdnResult" runat="server" />
    <input id="hdnStatusValue" type="hidden" name="hdnStatusValue" runat="server" />

    <asp:HiddenField ID="hdnExerciseStatus" runat="server" Value="0" />

    <asp:HiddenField ID="hdnPrepStatus" runat="server" Value="0" />
    <asp:HiddenField ID="hdnMeetingStatus" runat="server" Value="0" />
    <asp:HiddenField ID="hdnMeetingDefaultTime" runat="server" Value="0" />
    <asp:HiddenField ID="hdnCounterRunTime" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTotQstn" runat="server" Value="0" />

    <asp:HiddenField ID="hdnLanguageId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToolID" runat="server" Value="0" />



    <div id="dvDialog" style="display: none"></div>

    <div id="loader" class="clsloader" style="display: none">
        <div class="loader"></div>
    </div>
    <div id="divMainContainer" runat="server"></div>
</asp:Content>

