# IoT Final Project - Music Game

## 實體環境
![](https://i.imgur.com/7cNB94N.jpg)

## Usage scenario

When user's mobile phone or computer enters the website, users can start to play the game. It is recommend for 5 people to play at the same time.

Just have fun with the interactive music game!!

![](https://i.imgur.com/qR6IVWv.png)



## Tools
* Raspberry pi3
* Intel - Neural Compute Stick 2
* USB Microphone
* Camera
* Speaker

## How to do
### Step 1	Setup raspberry pi
* 參考檔案 [How to backup a raspberry pi3.doc](https://github.com/cges4426/IoT_MusicGame/blob/master/Internet%20of%20Things%20Practical%201%262.docx)
* Build another sudoer
    * 官方文件	https://www.raspberrypi.org/documentation/linux/usage/users.md
    * `sudo adduser [username]`
    * setting for the user
    * 給予sudoer權限	
        * `sudo visudo`
        * under the line `root    ALL=(ALL:ALL) ALL`
            *  add `[username] ALL=(ALL) NOPASSWD: ALL`
    * change to the user
        * `su - [username]`


### Step 2	Build a flask website
* 官方文件
    *  https://projects.raspberrypi.org/en/projects/python-web-server-with-flask
* Check for python package
    * `pip3 list`
    * If there is no "flask"
        * `pip3 install flask` 
* Start to build
    * 建立網站資料夾 `mkdir [project_name] & cd [project_name] `
    * build the main python file
        * [app.py](https://github.com/cges4426/IoT_MusicGame/blob/master/app.py)
        * ``` 
            from flask import Flask

            app = Flask(__name__)

            @app.route('/')
            def index():
                return 'Hello world'

            if __name__ == '__main__':
                app.run(debug=True, host='0.0.0.0')
            ```
        * 後續也是利用該檔案串接其他API
    * Add other files for the websites
        * templates/index.html 前端頁面
        * static/ 存放JS與CSS等檔案
    * We can get the project structure
        * ```
            [project_name]/
              app.py
                ...
              templates/
                index.html
                ...
              static/
                style.css
                scripts.js
                assets/
                  images/
                  photos/
            ```

### Step 2	Test for Picamera
* 接上鏡頭 (接任何設備前請先關閉樹梅派電源)
* Pi Setting: 開啟攝影機
* Taking photos: [camera.py](https://github.com/cges4426/IoT_MusicGame/blob/master/camera.py)

![](https://i.imgur.com/tMSA4Yg.png)

### Step 3	Install OpenVINO™ toolkit for Raspbian
* 官方文件 https://docs.openvinotoolkit.org/latest/_docs_install_guides_installing_openvino_raspbian.html
* Face Detection: openvino_fd_myriad.py

### Step 4 Test for Speech Recognition
* 確認語音輸入裝置運作
* https://chtseng.wordpress.com/2016/06/22/%e5%8d%b3%e6%99%82%e5%8f%a3%e8%ad%af%e6%a9%9f%e5%99%a8%e4%ba%badiy%ef%bc%88%e4%b8%80%ef%bc%89/
* `pip3 install SpeechRecognition`
* `pip3 install pyaudio`
* Code reference:	http://yhhuang1966.blogspot.com/2017/08/google-api.html
* Speech Recognition with microphone: microphone.py
* 給予user使用audio的權限
    * `sudo adduser [username] audio` 
    * 可能遇到flac的錯誤
        * `apt-get install flac`

### Step 5 Get all things together
* 以Flask為網站後端，串接PY API
* flask主程式: app.py
* 前端：
    * templates/[index.html](https://github.com/cges4426/IoT_MusicGame/blob/master/templates/index.html)
    * static/[scripts.js](https://github.com/cges4426/IoT_MusicGame/blob/master/static/scripts.js)
    * static/[style.css](https://github.com/cges4426/IoT_MusicGame/blob/master/static/style.css)
* PY API:
    * [camera.py](https://github.com/cges4426/IoT_MusicGame/blob/master/camera.py)
    * [microphone.py](https://github.com/cges4426/IoT_MusicGame/blob/master/microphone.py)
    * [openvino_fd_myriad.py](https://github.com/cges4426/IoT_MusicGame/blob/master/openvino_fd_myriad.py)

## Links
* [DEMO video](https://youtu.be/_YB645ao-5U)
* [Github](https://github.com/cges4426/IoT_MusicGame)

##  Reference
* https://www.raspberrypi.org/documentation/linux/usage/users.md
* https://projects.raspberrypi.org/en/projects/python-web-server-with-flask
* https://docs.openvinotoolkit.org/latest/_docs_install_guides_installing_openvino_raspbian.html
* https://chtseng.wordpress.com/2016/06/22/%e5%8d%b3%e6%99%82%e5%8f%a3%e8%ad%af%e6%a9%9f%e5%99%a8%e4%ba%badiy%ef%bc%88%e4%b8%80%ef%bc%89/
* http://yhhuang1966.blogspot.com/2017/08/google-api.html


###### tags: `raspberry pi`
