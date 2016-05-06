# pixbot takes pictures and posts to channel

Build pixbot!   

You send it a `/pix` command, and it takes a picture with the Raspberry Pi camera and posts it into the channel.

### Pre-requisites

* raspberry pi camera installed and working
* raspbian jessie or later with camera enabled
* `raspistill` tested working on command line
* Rocket.Chat server installed
* web server or reverse proxy, such as nginx, installed

### Operations

pixbot consists of two components:

* outgoing webhook integration from Rocket.Chat
* a node.js web service, similar to giphy that displays a captured image

you also need:

* a directory to hold the captured pictures - assumed to be `/home/pi/public_html` in the code
* a web server (such as nginx) that will serve files in the above directory at a known URL - assumed to be `https://<your host>/pix` in the code

#### Code of outgoing webook integration

Based loosely on [Finndrop Studio's GifRocket](https://github.com/FinndropStudios/GifRocket) integration.

```
const config = {
    color: '#225159'
};

class Script {
    /**
     * @params {object} request
     */
    prepare_outgoing_request({ request }) {
        const trigger = request.data.trigger_word.toLowerCase() + ' ';
        phrase = request.data.text.toLowerCase().replace(trigger, '').replace(/ /g, '+');
        let u = request.url;
         console.log(u);
        return {
            url: u,
            headers: request.headers,
            method: 'GET'
        };
    }

    process_outgoing_response({ request, response }) {
        let gif = '';
        if(response.content.data.length !== 0) {
            if(Array.isArray(response.content.data)) {
                const count = response.content.data.length - 1;
                const i = Math.floor((Math.random() * count));
                gif = response.content.data[i].images.original.url;
            } else {
                gif = response.content.data.image_original_url;
            }
            return {
                content: {
                    attachments: [
                        {
                            image_url: gif,
                            color: ((config['color'] != '') ? '#' + config['color'].replace('#', '') : '#225159')
                        }
                    ]
                }
            };
        } else {
            return {
                content: {
                    text: 'nice try, but I haven\'t found anything :cold_sweat:'
                }
            };
        }
    }
}
```
