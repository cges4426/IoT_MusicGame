#首先 import 這幾個套件 
import speech_recognition as sr
import time
import os

# 將聲音轉成文字的fun 只需要這一小段code 
def Voice_To_Text():
    try:
        r = sr.Recognizer()
        with sr.Microphone() as source: 
                                    
            # 函數調整麥克風的噪音:
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