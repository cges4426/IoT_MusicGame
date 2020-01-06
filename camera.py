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
