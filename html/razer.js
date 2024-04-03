

$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }



    display(false)


    window.addEventListener('message', function(event) {
        $("#bal1").html("You Bank Money " + event.data.balance + "")

        if (event.data.type === "ui") {
            if (event.data.status == true) {
                display(true)
            } else {
                display(false)
            }
        } 

        
    })
    
    
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://razer_jobs/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('http://razer_jobs/exit', JSON.stringify({}));
        return
    })
    $("#close2").click(function () {
        $.post('http://razer_jobs/exit', JSON.stringify({}));
        return
    })
    $("#buy3").click(function () {
        $.post('http://razer_jobs/exit', JSON.stringify({}));
        $.post('http://razer_jobs/buy3', JSON.stringify({}));
        return
    })
    $("#submit").click(function () {
        $.post('http://razer_jobs/exit', JSON.stringify({}));
        $.post('http://razer_jobs/buy2', JSON.stringify({}));
        return
    })
    $("#buypickaxe").click(function () {
        $.post('http://razer_jobs/exit', JSON.stringify({}));
        $.post('http://razer_jobs/buypickaxe', JSON.stringify({}));
        return
    })
    $("#submit").click(function () {
        $.post('http://razer_jobs/exit', JSON.stringify({}));
        $.post('http://razer_jobs/buywashpan', JSON.stringify({}));
        return
    })


    
})