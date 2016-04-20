# Doorman script will send a chat message to a rocket chat channel when a door was opened

### Requirements

- Raspberry Pi
- Reed Switch
- 1x 10k ohm resistor
- Channel ID of the channel your bot is going to post the message

### STEPS

##### Connect the Reed switch to the Raspberry Pi

Connect the reed switch acording to these schematics:

[![diagram](https://www.pictshare.net/300/8c24794483.jpg)]((https://www.pictshare.net/store/8c24794483.jpg))

##### Install php and the "gpio" command

```bash
apt-get install wiringpi php5-cli
echo 'w1-gpio' >> /etc/modules
modprobe w1-gpio
```

##### The script 


```php
//Bot settings
define('BOT_USERNAME','bot');
define('BOT_PASSWORD','secretbotpassword');
define('BOT_CHANNEL','GENERAL');

$laststate = 1;
$lastpost = 0;
$lastopen = 0;

while(1)
{
  //read the door status from the GPIO Pin
  $val = trim(@shell_exec("/usr/bin/gpio read 0"));
  if($val!=$laststate)
  {
    $laststate = $val;
    $lastpost = time();
    $status = ($val?'closed':'open');
    echo time().';'.$val.';'.$status."\n";

    if($val==1 && $lastopen!=0)
      $duration = time()-$lastopen;
    else $duration = -1;

    $message = 'The door is now *'.$status.'*. '.($duration!=-1?'Was open for `'.$duration.' seconds.`':'');

    sendRocket($message);
    
     if($val==0)
       $lastopen = time();
  }

  //wait 1 second to check the door status again
  sleep(1);
}


function sendRocket($message)
{
    $login = makeRequest('https://rocket.haschek.at/api/login',array('password' => BOT_USERNAME, 'user' => BOT_USERNAME));
    $token = $login['data']['authToken'];
    $user = $login['data']['userId'];

    //$rooms = makeRequest('https://rocket.haschek.at/api/publicRooms',array(),array('X-Auth-Token: '.$token,'X-User-Id: '.$user),false);

    //join room
    makeRequest('https://rocket.haschek.at/api/rooms/'.BOT_CHANNEL.'/join',array(),array('X-Auth-Token: '.$token,'X-User-Id: '.$user));

    //send message
    makeRequest('https://rocket.haschek.at/api/rooms/'.BOT_CHANNEL.'/send',array('msg'=>$message),array('X-Auth-Token: '.$token,'X-User-Id: '.$user));
}

function makeRequest($url,$data,$headers=false,$post=true)
{
    $headers[] = 'Content-type: application/x-www-form-urlencoded';
    $options = array(
        'http' => array(
            'header'  => $headers,
            'method'  => $post?'POST':'GET',
            'content' => http_build_query($data)
        )
    );
    $context  = stream_context_create($options);
    $result = file_get_contents($url, false, $context);
    if ($result === FALSE) { /* Handle error */ }
    
    return json_decode($result,true);
}

```

#### Run script on startup

```crontab -e```

insert this at the end of the file

```@reboot php /path/to/your/doorbot.php >> /var/log/doorbot.log```