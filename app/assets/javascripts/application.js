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
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require froala_editor.min.js
//= require plugins/lists.min.js
//= require plugins/font_size.min.js
//= require plugins/link.min.js
//= require plugins/paragraph_format.min.js
//= require plugins/align.min.js
//= require plugins/colors.min.js
//= require plugins/font_family.min.js
//= require plugins/image.min.js
//= require_tree .

NProgress.configure({
    showSpinner: false,
    trickleRate: 0.04,
    trickleSpeed: 700,
    easing: "ease"
});