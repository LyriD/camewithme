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
//= require jquery_ujs
//= require private_pub
//= require bootstrap
//= require bootstrap/scrollspy
//= require bootstrap/modal
//= require bootstrap/dropdown
//= require ion.sound.min
//= require jquery.zclip.min
//= require_tree .

$.ionSound({
    sounds: [
        'branch_break',
        'button_click',
        'button_tiny',
        'door_bump',
        'glass',
        'pop_cork',
        'snap',
        'staple_gun',
        'tap',
        'water_droplet',
        'water_droplet_2',
        'water_droplet_3',
    ] ,
    path: './sounds/',
    multiPlay: true,
    volume: '0.3'
});

var sound = 'branch_break:0.5';