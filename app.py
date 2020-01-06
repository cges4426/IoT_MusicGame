
from flask import Flask, render_template,request,redirect,url_for,jsonify
from camera import take
from microphone import Voice_To_Text
from openvino_fd_myriad import detection
import json 
from flask_socketio import SocketIO

app = Flask(__name__)
socketio = SocketIO(app)

@app.route('/',methods=['POST','GET'])
def index():  
    return render_template('index.html')


@app.route('/go_takephoto_api',methods=['POST','GET'])
def go_takephoto_api():
    if request.method == "POST":
          count_need=request.values['count_now']
    print("count_need: "+count_need)
    take("photo_now")
    count = detection("photo_now")
       
    if (count==int(count_need)):
        msg = "Success!! We need "+str(count_need)+" people and here is/are "+str(count)+" people in the photo."
        return jsonify({"success": "success", "msg": msg})        
    elif(count!=int(count_need)):
        msg = "Failed!! We need "+str(count_need)+" people and here is/are "+str(count)+" people in the photo."
        return jsonify({"success": "Failed", "msg": msg})
    else:
        return jsonify({"error": 1001, "msg": "error"})


@app.route('/go_inputvoice_api',methods=['POST','GET'])
def go_inputvoice_api():
    # Read Sensors Status
    if request.method == "POST":
          voice_expect=request.values['voice_expect']
    Text = Voice_To_Text()
   
    if (Text==voice_expect):
        msg = "Success!! We need "+voice_expect+" and here is "+Text+"."
        return jsonify({"success": "success", "msg": msg})        
    elif(Text!=voice_expect):
        msg = "Failed!! We need "+voice_expect+" and here is "+Text +"."
        return jsonify({"success": "Failed", "msg": msg})
    else:
        return jsonify({"error": 1001, "msg": "error"})

@app.route('/test',methods=['POST','GET'])
def test():
    if request.method == "POST":
          img_name = voice_expect=request.values['img_name']
    take(img_name)
    count = detection(img_name)
    if(count>=0):
        msg = "Here is/are "+str(count)+" people. If not right, please check again."
        return jsonify({"success": "success", "msg": msg})        
    else:
        return jsonify({"error": 1001, "msg": "error"})

   

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0' )
    
