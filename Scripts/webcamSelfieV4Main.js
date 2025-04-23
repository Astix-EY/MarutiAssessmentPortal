//--------------------
// GET USER MEDIA CODE
//--------------------
navigator.getUserMedia = (navigator.getUserMedia ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia ||
    navigator.msGetUserMedia);

var video;
var webcamStream;

function startWebcam() {
    if (navigator.getUserMedia) {
        navigator.getUserMedia(

            // constraints
            {
                video: true,
                audio: false
            },

            // successCallback
            function (localMediaStream) {
                //const mediaSource = new MediaSource();
                video = document.querySelector('video');
                // Older browsers may not have srcObject

                try {
                    video.srcObject = localMediaStream;
                } catch (error) {
                    video.src = window.URL.createObjectURL(localMediaStream);
                }
                video.play();
                webcamStream = localMediaStream;
            },

            // errorCallback
            function (err) {
                if (err.toString().indexOf('NotAllowedError') > -1) {
                    alert("Please enable camera.");
                }
                else {
                    alert("The following error occured: " + err);
                }

                webcamStream = undefined;
            }
        );
    } else {
        console.log("getUserMedia not supported");
    }
}

function stopWebcam() {
    webcamStream.stop();
}

//---------------------
// TAKE A SNAPSHOT CODE
//---------------------
var canvas, ctx;
function snapshot(canvasid) {
    canvas = document.getElementById(canvasid);
    ctx = canvas.getContext('2d');
    // Draws current image from the video element into the canvas
    ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

}
var NoOfSelfie = 0;
function fnSaveSelfie() {

    // var imgData = canvas.toDataURL();
    //imgData = imgData.replace('data:image/jpg;', '');
    if (canvas == undefined) {
        alert("Kindly Take Selfie First!");
        return false;
    }
    var imgData = canvas.toDataURL("image/jpeg");
    imgData = imgData.replace('data:image/jpeg;base64,', '');

    if (confirm("Are you sure to save selfie?") == false) {
        return false;
    }
    var data = new FormData();
    data.append("ImageData", imgData);

    data.append("FolderName", "Snapshot");

    var rspId = 0;// $("#ConatntMatter_hdnRspID").val();
    rspId = (rspId == undefined ? 0 : rspId);
    data.append("RspID", rspId);

    var rspExerciseId = 0;// $("#ConatntMatter_hdnRSPExerciseID").val();
    rspExerciseId = (rspExerciseId == undefined ? 0 : rspExerciseId);
    data.append("RSPExerciseID", rspExerciseId);

    var inLoginid = document.getElementById("ConatntMatter_hdnLoginID").value;
    inLoginid = (inLoginid == undefined ? 0 : inLoginid);
    data.append("LoginId", inLoginid);
alert(inLoginid);
    data.append("PageLocation", window.location.pathname);
    if (inLoginid > 0) {
        $("#pageload").show();
        $.ajax({
            url: "../../../FileSelfieUploadHandler.ashx?flgfilefolderid=7",
            type: "POST",
            data: data,
            async: true,
            contentType: false,
            processData: false,
            success: function (result) {
                $("#pageload").hide();
                if (result.split("|")[0] == "1") {

                    NoOfSelfie++;
                    if (NoOfSelfie >= 3) {
                        var rem = 3 - NoOfSelfie;
                        if (confirm("Selfie saved successfully and you have been taken selfies as per the minimum requirement. \n Do you want to continue?") == false) {
                            return false;
                        } else {
                            var BandId = $("#ConatntMatter_hdnBandId").val();
                            var PageName = $("#ConatntMatter_hdnFolderName").val();
                            window.location.href = "../../" + PageName + "/Information/Welcome.aspx?intLoginID=" + inLoginid
                        }
                    } else {
                        alert("Selfie Saved Successfully");
                    }


                }
                else {
                    alert("Error : " + result.split("|")[1]);
                    return false;
                }
            },
            error: function (err) {
                $("#pageload").hide();
                alert("Error : " + err.statusText);
                //alert(err.statusText)
            }
        });
    }
}
function fnSaveContinue() {


    var BandId = $("#ConatntMatter_hdnBandId").val();
    var PageName = $("#ConatntMatter_hdnFolderName").val();
    var inLoginid = document.getElementById("ConatntMatter_hdnLoginID").value;
    inLoginid = (inLoginid == undefined ? 0 : inLoginid);

    var data = new FormData();
    var canvas1 = document.getElementById("myCanvas1");
    var imgData1 = canvas1.toDataURL("image/jpeg");
    imgData1 = imgData1.replace('data:image/jpeg;base64,', '');
    if (imgData1.length < 3000) {
        alert("Kindly Take Selfie of Front View First!");
        return false;
    }

    data.append("ImageData1", imgData1);

    var canvas2 = document.getElementById("myCanvas2");
    var imgData2 = canvas2.toDataURL("image/jpeg");

    imgData2 = imgData2.replace('data:image/jpeg;base64,', '');

    if (imgData2.length < 3000) {
        alert("Kindly Take Selfie of Left View First!");
        return false;
    }
    data.append("ImageData2", imgData2);

    var canvas3 = document.getElementById("myCanvas3");
    var imgData3 = canvas3.toDataURL("image/jpeg");
    imgData3 = imgData3.replace('data:image/jpeg;base64,', '');
    if (imgData3.length < 3000) {
        alert("Kindly Take Selfie of Right View First!");
        return false;
    }
    data.append("ImageData3", imgData3);



    data.append("FolderName", "Snapshot");

    if (confirm("Are you sure to Save & Continue?") == false) {
        return false;
    }

    var rspId = 0;// $("#ConatntMatter_hdnRspID").val();
    rspId = (rspId == undefined ? 0 : rspId);
    data.append("RspID", rspId);

    var rspExerciseId = 0;// $("#ConatntMatter_hdnRSPExerciseID").val();
    rspExerciseId = (rspExerciseId == undefined ? 0 : rspExerciseId);
    data.append("RSPExerciseID", rspExerciseId);

    var inLoginid = document.getElementById("ConatntMatter_hdnLoginID").value;
    inLoginid = (inLoginid == undefined ? 0 : inLoginid);
    data.append("LoginId", inLoginid);
    data.append("PageLocation", window.location.pathname);

    if (inLoginid > 0) {
        $("#pageload").show();
        $.ajax({
            url: "../../FileSelfieUploadHandler.ashx?flgfilefolderid=7",
            type: "POST",
            data: data,
            async: true,
            contentType: false,
            processData: false,
            success: function (result) {
                $("#pageload").hide();
                if (result.split("|")[0] == "1") {
                    var BandId = $("#ConatntMatter_hdnBandId").val();
                    var PageName = $("#ConatntMatter_hdnFolderName").val();
                    window.location.href = "../../" + PageName + "/Main/ExerciseMain.aspx?intLoginID=" + inLoginid
                }
                else {
                    alert("Error : " + result.split("|")[1]);
                    return false;
                }
            },
            error: function (err) {
                $("#pageload").hide();
                alert("Error : " + err.statusText);
                //alert(err.statusText)
            }
        });
    }
}
$(document).ready(function () {
    startWebcam();



    setInterval(function () {
        if (webcamStream == undefined) {
            startWebcam();
        }
    }, 10000);

});

