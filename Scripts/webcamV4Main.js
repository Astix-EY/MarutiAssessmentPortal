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
                video = document.querySelector('video');
                video.src = window.URL.createObjectURL(localMediaStream);
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
function snapshot() {
    debugger;
    canvas = document.getElementById("myCanvas");
    ctx = canvas.getContext('2d');
    // Draws current image from the video element into the canvas
    ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

    var imgData = canvas.toDataURL('image/png');
    imgData = imgData.replace('data:image/png;base64,', '');

    var data = new FormData();
    data.append("ImageData", imgData);

    data.append("FolderName", "Snapshot");

    var rspId = $("#ConatntMatterRight_hdnRspID").val();
    rspId = (rspId == undefined ? 0 : rspId);
    data.append("RspID", rspId);

    var rspExerciseId = $("#ConatntMatterRight_hdnRSPExerciseID").val();
    rspExerciseId = (rspExerciseId == undefined ? 0 : rspExerciseId);
    data.append("RSPExerciseID", rspExerciseId);

    var inLoginid = document.getElementById("ConatntMatterRight_hdnLoginID").value;
    inLoginid = (inLoginid == undefined ? 0 : inLoginid);
    data.append("LoginId", inLoginid);

    data.append("PageLocation", window.location.pathname);

    $.ajax({
        url: "../../../FileUploadHandler.ashx?flgfilefolderid=7",
        type: "POST",
        data: data,
        async: true,
        contentType: false,
        processData: false,
        success: function (result) {
            if (result.split("|")[0] == "1") {
            }
            else {
                //alert("Error : " + result.split("|")[1]);
                //return false;
            }
        },
        error: function (err) {
        //    alert("Error : " + err.statusText);
            //alert(err.statusText)
        }
    });
}

$(document).ready(function () {
    startWebcam();

    setTimeout(function () {
        snapshot();
    }, 5000);

    setInterval(function () {
        if (webcamStream == undefined) {
            startWebcam();
        }
    }, 10000);

    setInterval(function () {
        snapshot();
    }, 300000);
});

