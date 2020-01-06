
var player;
var voice_round_time = [10,56,68];
var photo_round_time = [19,26,36,45,76,85];
var grade_now =0;

function onYouTubeIframeAPIReady() {
        player = new YT.Player('ytplayer', {
          height: '390',
          width: '640',
          videoId: 'opB3NEtnw68', //你的Youtube 影片ID

        }); 
 }
 
function imgChg(){
    
    var number =document.getElementById("num_now").value;
    console.log("imgChg: "+number);
    switch (number) {
      case "1":
      　document.getElementById("status_img").src="/static/assets/images/willy1.png";
      　break;
      case "2":
      　document.getElementById("status_img").src="/static/assets/images/willy2.png";
      　break;
      case "3":
      　document.getElementById("status_img").src="/static/assets/images/willy3.png";
      　break;
      case "4":
      　document.getElementById("status_img").src="/static/assets/images/willy4.png";
      　break;
      case "5":
      　document.getElementById("status_img").src="/static/assets/images/willy5.png";
      　break;
      default:
      　document.getElementById("status_img").src="/static/assets/images/waiting.png";
      }
    
};

function getRandom(){
    var num_now = Math.ceil(Math.random()*5);
    document.getElementById("num_now").value = num_now;
    document.getElementById("mission_msg").value = "Need "+num_now+ " people to take photo!!";
    //~ return num_now;
};

function voice_mission(){
    var voice_round_count =document.getElementById("voice_now").value;    
    console.log(voice_round_count);
    
    if(voice_round_count=="0" || voice_round_count=="00"){
      document.getElementById("voice_word").value = "すすめ";
      document.getElementById("mission_msg").value = "Sing out 『すすめ』 loudly!!";
      document.getElementById("status_img").src="/static/assets/images/go.png";
      
    }else{
      document.getElementById("voice_word").value = "ありがとう";
      document.getElementById("mission_msg").value = "Sing out 『ありがとう』 loudly!!";
      document.getElementById("status_img").src="/static/assets/images/thanks.png";
    }
    
    voice_round_count = voice_round_count+0
    document.getElementById("voice_now").value = voice_round_count;
    //~ return num_now;
};

var currentsecond;
function waiting(countdownfrom){
		currentsecond=countdownfrom+1;
		setTimeout("countredirect()",1000)  ;  
		return ;
}
	 

function countredirect(){    
		if (currentsecond > 2){           
      currentsecond-=1  ;
      document.getElementById("Countdown").disabled=true;  
      document.getElementById("Countdown").value =currentsecond-1; 
      
		}else if(currentsecond==2){
      currentsecond-=1  ;
      document.getElementById("Countdown").disabled=true;  
      document.getElementById("Countdown").value ="GO"; 
      document.getElementById("status_img").src="/static/assets/images/waiting.png";
    }     
		else{           
      document.getElementById("Countdown").value =" "; 
      document.getElementById("Countdown").disabled=false; 

          
      return  ;         
		}           
		setTimeout("countredirect()",1000)  ;  
}    

var c = 0;
var t;
var timer_is_on = 0;
var time_lock = 0;

function timedCount() {
  document.getElementById("time_mark").value = c;
  c = c + 1;
  t = setTimeout(timedCount, 1000);

}

function startCount() {
  if (!timer_is_on) {
    timer_is_on = 1;
    timedCount();
  }
}

function stopCount() {
  clearTimeout(t);
  timer_is_on = 0;
}


function move_forward(){
  document.getElementById("TestBtn").disabled=true;  
  document.getElementById("StartBtn").disabled=true;  
  player.playVideo();
  startCount();
  for (i = 0; i < photo_round_time.length; i++) {
    
    setTimeout("waiting(4)",photo_round_time[i]*1000-4000)  ; 
    setTimeout("getRandom()",photo_round_time[i]*1000-4000)  ; 
    setTimeout("imgChg()",photo_round_time[i]*1000-4000)  ;
    setTimeout("take_photo()",photo_round_time[i]*1000)  ; 

  }
  for (i = 0; i < voice_round_time.length; i++) {
    
    setTimeout("waiting(4)",voice_round_time[i]*1000-3000)  ; 
    setTimeout("voice_mission()",voice_round_time[i]*1000-3000)  ; 
    setTimeout("input_voice()",voice_round_time[i]*1000)  ; 
    
  }
  setTimeout("gameover()",95*1000)  ;
}

function gameover(){
  stopCount();
  c = 0;
  document.getElementById("TestBtn").disabled=false;  
  document.getElementById("StartBtn").disabled=false;  
  document.getElementById("voice_now").value = 0;
  alert("You got "+grade_now+" point.")
  
  }
function take_photo(){
  var count_now = document.getElementById("num_now").value;
  
  $.ajax({
    url:"/go_takephoto_api",
    type:"post",
    data: {'count_now':count_now} ,
    dataType: 'json',
    success:function(data){

      document.getElementById("result_message").value = data.msg;  
      if(data.success=="success")   
        grade_now =grade_now+1000;
        document.getElementById("grade").value = grade_now;


    },
    error:function(e){
      alert("error");
    }
  })
  
}



function input_voice(){
  

  setTimeout("player.setVolume(30)",1800)  ; 
  setTimeout("player.setVolume(60)",4000)  ;
  setTimeout("player.setVolume(100)",4500)  ; 
  
  $.ajax({
    url:"/go_inputvoice_api",
    type:"post",
    data: {'voice_expect':document.getElementById("voice_word").value} ,
    dataType: 'json',
    success:function(data){

      document.getElementById("result_message").value = data.msg; 
      if(data.success=="success")   
        grade_now =grade_now+3000;
        document.getElementById("grade").value = grade_now;

    },
    error:function(e){
      alert("error");
    }
  })
  
}

   
function test_photo(){
  
  var dd = new Date();
  var img_name = dd.getTime().toString();
  $.ajax({
    url:"/test",
    type:"post",
    data: {'img_name':img_name} ,
    dataType: 'json',
    success:function(data){
      document.getElementById("result_message").value = data.msg;  
      features = "top=150,left=450,height=320,width=380, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no"; 
      window.open( "/static/assets/photos/"+img_name+"_out.jpg","",features); 
      

    },
    error:function(e){
      alert("error");
    }
  })

}

