/*-----------------------------------------------+
 | Site: Chicago Police Board Information Center |
 | Part: Common Javascript Methods               |
 +-----------------------------------------------*/
import $ from 'jquery';
$(function() {
    if ($("#notice").val()) {
        displayNotification("success", $("#notice").val());
    }
    else if ($("#alert").val()) {
        displayNotification("error", $("#alert").val());
    }
});

 function displayNotification (notificationType, message) {
    if (notificationType == "success") {
        iziToast.success({ 
            title: 'Success', 
            message: message,
            progressBar: false,
            position: "topLeft"
        });
    }
    else if (notificationType == "error") {
        iziToast.error({ 
            title: 'Error', 
            message: message,
            progressBar: false,
            position: "topLeft"
        });
    }
 }