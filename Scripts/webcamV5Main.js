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
if (webcamStream != undefined) {
    webcamStream.stop();
}
}

//---------------------
// TAKE A SNAPSHOT CODE
//---------------------
var canvas, ctx;
function snapshot() {
    var Phase1Status = document.getElementById("ConatntMatter_hdnPhase1Status").value;
    
    if (Phase1Status == 0) {
        canvas = document.getElementById("myCanvas");
        ctx = canvas.getContext('2d');
        // Draws current image from the video element into the canvas
        ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

        var imgData = canvas.toDataURL("image/jpeg");
        imgData = imgData.replace('data:image/jpeg;base64,', '');

        var data = new FormData();
        data.append("ImageData", imgData);

        data.append("FolderName", "Snapshot");

        var rspId = $("#ConatntMatter_hdnRspID").val();
        rspId = (rspId == undefined ? 0 : rspId);
        data.append("RspID", rspId);

        var rspExerciseId = $("#ConatntMatter_hdnRSPExerciseID").val();
        rspExerciseId = (rspExerciseId == undefined ? 0 : rspExerciseId);
        data.append("RSPExerciseID", rspExerciseId);

        var inLoginid = document.getElementById("ConatntMatter_hdnLoginID").value;
        inLoginid = (inLoginid == undefined ? 0 : inLoginid);
        data.append("LoginId", inLoginid);

        data.append("PageLocation", window.location.pathname);
        if (inLoginid > 0) {
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
                    //alert("Error : " + err.statusText);
                    //alert(err.statusText)
                }
            });
        }
    }
}

$(document).ready(function () {
    var Phase1Status = document.getElementById("ConatntMatter_hdnPhase1Status").value;
    //alert(Phase1Status);
    if (Phase1Status == 0) {
        startWebcam();

        setTimeout(function () {
            snapshot();
        }, 5000);

        setInterval(function () {
            if (webcamStream == undefined) {
                startWebcam();
            }
            if (Phase1Status == 1) {
                stopWebcam();
            }
        }, 10000);


        setInterval(function () {
            snapshot();
        }, 30000);
    } else {
        if (webcamStream != undefined) {
            stopWebcam();
        }
    }
});

