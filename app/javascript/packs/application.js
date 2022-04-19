// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

// rails
//= require jquery

// app
//= require jquery.readyselector
//= require jquery.sparkline.min
//= require responsive.min
//= require responsive-init
//= require search
//= require table-scroll
//= require policeboard
//= require tinymce
//= require iziToast



require("trix")
require("@rails/actiontext")
require('react')
require('react-bootstrap')
require('react-vega')
require('bootstrap')


// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);


