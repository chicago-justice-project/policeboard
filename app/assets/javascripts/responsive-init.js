$().ready(function () {

	//this script relies on responsive.js
	var _Responsive = Responsive ||
		// ensure no js errors if not included
		{ init: function () { alert('Method not implemented; please include responsive.js script in page head!'); } },


	//flags
	_menu_created,
	_menu_open,


	//method to create the custom sidebar menu for smaller window sizes
	_createMenu = function () {
		if ($("#nav").size() == 0) return;

		var nav = $("#nav").html();
		
		$("body").append("<div id='menu'><ul>" + nav + "</ul></div>");
		$("#header .content").prepend("<a id='nav-toggle' href='#'><i class='fa fa-bars'></i> Menu</a>");
		$("#menu .fa-home").after(" Home");
		
		$("#menu").height($(window).height());
		$("#nav").hide();

		$("#nav-toggle").click(function (event) {
			$("#menu").show().animate({ right: "0" }, 150);
			$("#wrapper").css({ position: "fixed", top: 0, width: $("#wrapper").width() }).animate({ right: "250px" }, 150);
			_menu_open = true;
			event.stopPropagation();
			return false;
		});

		$("#nav-toggle").click(function (event) {
            $("#menu").show().animate({ right: "0" }, 150);
            $("#wrapper").css({ position: "fixed", top: 0, width: $("#wrapper").width() }).animate({ right: "250px" }, 150);
            _menu_open = true;
            event.stopPropagation();
            return false;
        });

        $("html").on("click touchstart", function (e) {
            if (_menu_open && $("#menu").has(e.target).length === 0) {
                $("#menu").animate({ right: "-400px" }, 150, function () {
                    $(this).hide();
                });
                $("#wrapper").animate({ right: 0 }, 150, function () {
                    $(this).css({ position: "static", top: "auto", width: "auto" });
                });
                _menu_open = false;
                e.stopPropagation();
                return false;
            }
        });
	},

	//method to remove the custom sidebar menu
	_removeMenu = function () {
        $("#menu, #nav-toggle").remove();
        $("#wrapper").css({ position: "static", top: "auto", width: "auto" });
        $("#nav").show();
    };


	// initialize responsive layouts
	_Responsive.init({
		layouts: {
			MEDIUM: { maxWidth: 900, stylesheet: false },
			NARROW: { maxWidth: 400, stylesheet: false }
		},
		//listen for responsive layout change; will also be fired once on page load
		onLayoutChange: function (layout) {
			if (layout == _Responsive.LayoutType.MEDIUM || layout == _Responsive.LayoutType.NARROW) {
				if (!_menu_created)
					_createMenu();
				_menu_created = true;
			}
			else {
				if (_menu_created)
					_removeMenu();
				_menu_created = false;
			}
		}
	});

});
