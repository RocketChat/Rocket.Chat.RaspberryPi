var express = require('express');
var app = express();
var sys = require('sys');
var shortid = require('shortid');
var exec = require('child_process').exec;
var child;

var port = process.env.PORT || 9000;

var router = express.Router();

var lastPicTime = 0;
var timeBetweenPics = 30000;

var picfilename = '';

var baseURL = 'https://rocketchat.pagekite.me/pix/';
var fileEXT = '.jpg'; 
var basePATH = '/home/pi/public_html/';
var takingpix = false;
var pixCMD = 'raspistill -n -vf -w 320 -h 240 -o ';

var takepic = function(picname) {
 // make sure the time to take a pix is >> timeBetweenPics !!
 if (!takingpix) {
   takingpix = true;
   child = exec(pixCMD  + basePATH +  picname, 
    function(error, stdout, stderr) {
       console.log('stdout: ' + stdout);
       console.log('stderr: ' + stderr);
       if (error !== null) {
    		console.log('exec error: ' + error);
  	} else {
            console.log('at ' + Date.now() + ' successful capture to ' + picname);
    		picfilename = picname;
  	}
        takingpix = false; 
        lastPicTime = Date.now();   
     });

  }

};
router.get('/', function(req, res) {
  var timenow = Date.now();
  if ((timenow - lastPicTime) > timeBetweenPics) {
     console.log("ask to take a pix");
     takepic(shortid.generate() + fileEXT);
   } else {
     console.log("not yet time, use old pix");
   }
 
  res.json({data: { image_original_url: baseURL + picfilename}});
});


app.use('/api', router);

// take initial pix
takepic(shortid.generate() + fileEXT);

app.listen(port);
console.log('listening at port ' + port);

