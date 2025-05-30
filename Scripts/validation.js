﻿$(document).ready(function () {
    AccessClipboardData();

    $(document).keydown(function (evtobj) {
        if (evtobj.altKey || evtobj.ctrlKey || (evtobj.which || evtobj.keyCode) == 116) {
            return false;
        }
    });

    $(document).keypress(function (evtobj) {
        /* 
       48-57 - (0-9)Numbers
       65-90 - (A-Z)
       97-122 - (a-z)
       8 - (backspace)
       32 - (space)
   */
        // Not allow special characters
        var keyCode = (evtobj.which) ? evtobj.which : event.keyCode

       // alert(keyCode)
        if (!((keyCode >= 48 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122)) && keyCode != 44 && keyCode != 45 && keyCode != 8 && keyCode != 32 && keyCode != 13 && keyCode != 188 && keyCode != 93 && keyCode != 91 && keyCode != 92 && keyCode != 46 && keyCode != 47 && keyCode != 59 && keyCode != 39) {
       
            return false;
        }
    })

    $(document).keyup(function (evtobj)
    {
        var keyCode = (evtobj.which) ? evtobj.which : event.keyCode

        if (evtobj.ctrlKey && keyCode == 44) {        // For Disable PrintScreen
            return false;
        }
        if (keyCode == 44) {        // For Disable PrintScreen
            return false;
        }

    
    })
    $("body").on("contextmenu", function (e) {
        return false;
    });

    
});


document.addEventListener("keyup", function (e) {
    var keyCode = e.keyCode ? e.keyCode : e.which;
    if (keyCode == 44) {
        stopPrntScr();
    }
});
document.addEventListener("keydown", function (e) {
    var keyCode = e.keyCode ? e.keyCode : e.which;
    if (keyCode == 44) {
        stopPrntScr();
    }
});
function stopPrntScr() {

    var inpFld = document.createElement("input");
    inpFld.setAttribute("value", ".");
    inpFld.setAttribute("width", "0");
    inpFld.style.height = "0px";
    inpFld.style.width = "0px";
    inpFld.style.border = "0px";
    document.body.appendChild(inpFld);
    inpFld.select();
    document.execCommand("copy");
    inpFld.remove(inpFld);
}
function AccessClipboardData() {
    try {
        window.clipboardData.setData('text', "Access   Restricted");
    } catch (err) {
    }
}
setInterval("AccessClipboardData()", 100);


function replaceAll(str, find, replace) {
    while (str.indexOf(find) > -1) {
        str = str.replace(find, replace);
    }
    return str;
}

