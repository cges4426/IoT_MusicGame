
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
    count =0 
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
