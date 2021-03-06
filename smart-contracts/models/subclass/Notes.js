// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License
"use strict";


if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

define (["../loan/Notes"], function(Notes) {
    function SubClass() {
	Notes.call(this);
    }
    SubClass.prototype = Object.create(Notes.prototype);
    return SubClass;
});
