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

![](https://i.imgur.com/tMSA4Yg.png)
* 語法參數說明 https://www.raspberrypi.org/documentation/usage/camera/raspicam/raspistill.md
    * 測試拍照 `raspistill -o image.png`
    * 等待時間2秒(2000毫秒)`raspistill -t 2000 -o image.jpg`
    * 決定相片尺寸 `raspistill -o image.jpg -w 640 -h 480`
    * 旋轉180度 `raspistill -o a.jpg -rot 180 ` 
* Taking photos: [camera.py](https://github.com/cges4426/IoT_MusicGame/blob/master/camera.py)
```
from picamera import PiCamera
from time import sleep

camera = PiCamera()

def take(name):
    
    img_route = './static/assets/photos/'
    camera.rotation = 180
    camera.resolution = (380, 320)
    camera.start_preview()
    sleep(1)
    camera.capture(img_route +name+'.jpg')
    camera.stop_preview()


if __name__ == '__main__':
    take('123')

```

### Step 3	Install OpenVINO™ toolkit for Raspbian
* 官方文件 https://docs.openvinotoolkit.org/latest/_docs_install_guides_installing_openvino_raspbian.html
* 下載安裝檔
    * Downloaded the OpenVINO toolkit for Raspbian* OS
    * 建立解壓縮的資料夾`sudo mkdir -p /opt/intel/openvino`
    * 移動到儲存壓縮檔目錄 `cd ~/Downloads/`
    * 解壓縮 `sudo tar -xf  l_openvino_toolkit_runtime_raspbian_p_<version>.tgz --strip 1 -C /opt/intel/openvino`
* 安裝cmake
    * `sudo apt install cmake`
* 設置環境變數
    * 於新建立的user (sudoer) 進行設置
    * `source /opt/intel/openvino/bin/setupvars.sh`
    * `echo "source /opt/intel/openvino/bin/setupvars.sh" >> ~/.bashrc`
    * 設定後，每次啟動terminal轉至該user時將顯示
        * `[setupvars.sh] OpenVINO environment initialized`
* Add USB Rules
    * 在該user的環境下
        * `sudo usermod -a -G users "$(whoami)"`
    * 再次確認環境變數
        * `source /opt/intel/openvino/bin/setupvars.sh`
    * 安裝Stick的連接
        * `sh /opt/intel/openvino/install_dependencies/install_NCS_udev_rules.sh`
    * 將Intel - Neural Compute Stick 2插上樹梅派
* 建立人臉辨識Sample
    * 建立資料夾 `mkdir build && cd build`
    * 建立Object Detection Sample 
        * `cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-march=armv7-a" /opt/intel/openvino/deployment_tools/inference_engine/samples`
        * `make -j2 object_detection_sample_ssd`
    * 下載預訓練好的人臉辨識model
        * wget --no-check-certificate https://download.01.org/opencv/2019/open_model_zoo/R1/models_bin/face-detection-adas-0001/FP16/face-detection-adas-0001.bin
        * wget --no-check-certificate https://download.01.org/opencv/2019/open_model_zoo/R1/models_bin/face-detection-adas-0001/FP16/face-detection-adas-0001.xml
    * 測試model
        * `./armv7l/Release/object_detection_sample_ssd -m face-detection-adas-0001.xml -d MYRIAD -i <path_to_image>`
* Face Detection: openvino_fd_myriad.py
    ```
    import cv2 as cv
    import time

    def detection(name):
        img_route = './static/assets/photos/'
        tStart = time.time()
        # Load the model.
        net = cv.dnn.readNet('./build/face-detection-adas-0001.xml',
                             './build/face-detection-adas-0001.bin')
                             
        # Specify target device.
        net.setPreferableTarget(cv.dnn.DNN_TARGET_MYRIAD)
        # Read an image.
        frame = cv.imread(img_route + name+'.jpg')
        if frame is None:
            raise Exception('Image not found!')
        # Prepare input blob and perform an inference.
        blob = cv.dnn.blobFromImage(frame, size=(380, 320), ddepth=cv.CV_8U)
        net.setInput(blob)
        out = net.forward()
        #print(len(out.reshape(-1, 7)))
        count =0 #count for the face
        # Draw detected faces on the frame.
        for detection in out.reshape(-1, 7):
            confidence = float(detection[2])
            xmin = int(detection[3] * frame.shape[1])
            ymin = int(detection[4] * frame.shape[0])
            xmax = int(detection[5] * frame.shape[1])
            ymax = int(detection[6] * frame.shape[0])
            if confidence > 0.5:
                count = count+1
                cv.rectangle(frame, (xmin, ymin), (xmax, ymax), color=(0, 255, 0))
        # Save the frame to an image file.
        cv.imwrite(img_route+name+'_out.jpg', frame)
    #    print(count)
        tEnd = time.time()
        print ("It cost %f sec" % (tEnd - tStart))

        return count

    if __name__ == '__main__':
        detection("123")

    ```

### Step 4 Test for Speech Recognition
* 確認語音輸入裝置運作
    * https://chtseng.wordpress.com/2016/06/22/%e5%8d%b3%e6%99%82%e5%8f%a3%e8%ad%af%e6%a9%9f%e5%99%a8%e4%ba%badiy%ef%bc%88%e4%b8%80%ef%bc%89/
* 安裝所需套件
    * `pip3 install SpeechRecognition`
    * `pip3 install pyaudio`
* 給予user使用audio的權限
    *  `sudo adduser [username] audio` 
* 可能遇到flac的錯誤 
    * `apt-get install flac`
* Code reference:
    * http://yhhuang1966.blogspot.com/2017/08/google-api.html
* Speech Recognition with microphone: [microphone.py](https://github.com/cges4426/IoT_MusicGame/blob/master/microphone.py)
 
    ```
    import speech_recognition as sr
    import time
  

    # 將聲音轉成文字
    def Voice_To_Text():
        try:
            r = sr.Recognizer()
            with sr.Microphone() as source: 

                # 調整麥克風的噪音:
                r.adjust_for_ambient_noise(source, duration=0.5)     
                print("請開始說話:")
                tStart = time.time()
                audio = r.listen(source, timeout=3)

            Text = r.recognize_google(audio, language="ja-JP")     

        except sr.WaitTimeoutError as e:
            Text = "Timeout,無法翻譯"

        except sr.UnknownValueError:
            print("Google Speech Recognition could not understand audio")
            Text = "無法翻譯"
        except sr.RequestError as e:
            print("Could not request results from Google Speech Recognition service; {0}".format(e))        
            Text = "無法翻譯"

        return Text


    if __name__ == '__main__':
        Text = Voice_To_Text()
        print(Text)

    ```


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
