<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>	
	<title>XJTU-ME</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	<%@ page contentType="text/html; charset=gbk"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	 <script LANGUAGE="JavaScript">
		 var months = new Array("一", "二", "三","四", "五", "六", "七", "八", "九","十", "十一", "十二");
		 var daysInMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31,30, 31, 30, 31);
		 var days = new Array("日","一", "二", "三","四", "五", "六");
		 var classTemp;
		 var today=new getToday();
		 var year=today.year;
		 var month=today.month;
		 var newCal; 
		
		 function getDays(month, year) {
		  if (1 == month) return ((0 == year % 4)  &&  (0 != (year % 100))) ||(0 == year % 400) ? 29 : 28;
		  else return daysInMonth[month];
		 }
		
		 function getToday() {
		  this.now = new Date();
		  this.year = this.now.getFullYear();
		  this.month = this.now.getMonth();
		  this.day = this.now.getDate();
		 }
		
		 function Calendar() {
		  newCal = new Date(year,month,1);
		  today = new getToday();   
		  var day = -1;
		  var startDay = newCal.getDay();
		  var endDay=getDays(newCal.getMonth(), newCal.getFullYear());
		  var daily = 0;
		  if ((today.year == newCal.getFullYear())  && (today.month == newCal.getMonth()))
		  {
		   day = today.day;
		  }
		  var caltable = document.all.caltable.tBodies.calendar;
		  var intDaysInMonth =getDays(newCal.getMonth(), newCal.getFullYear());
		
		  for (var intWeek = 0; intWeek < caltable.rows.length;intWeek++)
		   for (var intDay = 0;intDay < caltable.rows[intWeek].cells.length;intDay++)
		   {
		    var cell = caltable.rows[intWeek].cells[intDay];
		    var montemp=(newCal.getMonth()+1)<10?("0"+(newCal.getMonth()+1)):(newCal.getMonth()+1);         
		    if ((intDay == startDay)  &&  (0 == daily)){ daily = 1;}
		    var daytemp=daily<10?("0"+daily):(daily);
		    var d="<"+newCal.getFullYear()+"-"+montemp+"-"+daytemp+">";
		    if(day==daily) cell.className="DayNow";
		    else if(intDay==6) cell.className = "DaySat";
		    else if (intDay==0) cell.className ="DaySun";
		    else cell.className="Day";
		    if ((daily > 0)  &&  (daily <= intDaysInMonth))
		    {
		     cell.innerText = daily;
		     daily++;
		    } else
		    {
		     cell.className="CalendarTD";
		     cell.innerText = "";
		    }
		  }
		  document.all.year.value=year;
		  document.all.month.value=month+1;
		 }
		
		 function subMonth()
		 {
		  if ((month-1)<0)
		  {
		   month=11;
		   year=year-1;
		  } else
		  {
		   month=month-1;
		  }
		  Calendar();
		 }
		
		 function addMonth()
		 {
		  if((month+1)>11)
		  {
		   month=0;
		   year=year+1;
		  } else
		  {
		   month=month+1;
		  }
		  Calendar();
		 }
		
		 function setDate() 
		 {
		  if (document.all.month.value<1||document.all.month.value>12)
		  {
		   alert("月的有效范围在1-12之间!");
		   return;
		  }
		  year=Math.ceil(document.all.year.value);
		  month=Math.ceil(document.all.month.value-1);
		  Calendar();
		 }
</script>

<script>
		function buttonOver()
		{
		 var obj = window.event.srcElement;
		 obj.runtimeStyle.cssText = "background-color:#FFFFFF";
		// obj.className="Hover";
		}
		
		function buttonOut()
		{
		 var obj = window.event.srcElement;
		 window.setTimeout(function(){obj.runtimeStyle.cssText = "";},300);
		}
</script>	
<style>
//input {font-family: verdana;font-size: 9pt;text-decoration: none;background-color: #FFFFFF;height: 20px;border: 1px solid #666666;color:#000000;}

.Calendar {font-family: verdana;text-decoration: none;width: 170;background-color: #C0D0E8;font-size: 9pt;border:0px dotted #F6F4E4;}
.CalendarTD {font-family: verdana;font-size: 7pt;color: #000000;background-color:#f6f6f6;height: 20px;width:11%;text-align: center;}

.Title {font-family: verdana;font-size: 11pt;font-weight: normal;height: 24px;text-align: center;color: #333333;text-decoration: none;background-color: #E8AD90;border-top-width: 1px;border-right-width: 1px;border-bottom-width: 1px;border-left-width: 1px;border-bottom-style:1px;border-top-color: #999999;border-right-color: #999999;border-bottom-color: #999999;border-left-color: #999999;}

.Day {font-family: verdana;font-size: 7pt;color:#243F65;background-color: #F6F4E4;height: 20px;width:11%;text-align: center;}
.DaySat {font-family: verdana;font-size: 7pt;color:#FF0000;text-decoration: none;background-color:#F6F4E4;text-align: center;height: 18px;width: 12%;}
.DaySun {font-family: verdana;font-size: 7pt;color: #FF0000;text-decoration: none;background-color:#F6F4E4;text-align: center;height: 18px;width: 12%;}
.DayNow {font-family: verdana;font-size: 7pt;font-weight: bold;color: #000000;background-color: #FFFFFF;height: 20px;text-align: center;}

.DayTitle {font-family: verdana;font-size: 9pt;color: #000000;background-color: #E8C1B3;height: 20px;width:11%;text-align: center;}
.DaySatTitle {font-family: verdana;font-size: 9pt;color:#FF0000;text-decoration: none;background-color:#E8C1B3;text-align: center;height: 20px;width: 12%;}
.DaySunTitle {font-family: verdana;font-size: 9pt;color: #FF0000;text-decoration: none;background-color: #E8C1B3;text-align: center;height: 20px;width: 12%;}

.DayButton {font-family: Webdings;font-size: 9pt;font-weight: bold;color: #243F65;cursor:hand;text-decoration: none;}

</style>
</head>
<body>	
   <div id="mainPan1">	  
	   <div class="left">
	    <div id="leftPan">
	    <ul>
					<li class="home">首页</li>
					<li><a href="#">产品介绍</a></li>
					<li><a href="#">后台管理</a></li>
					<li><a href="#">企业用户</a></li>
					<li><a href="#">银行用户</a></li>
					<li><a href="#">帮助</a></li>
					<li class="contact"><a href="#">联系我们</a></li>
					
		</ul>
	<br /><br /><br /><br />
		<div style="padding-left: 7%;">
		<table border="0" cellpadding="0" cellspacing="1" class="Calendar" id="caltable" ">
<thead>
     <tr align="center" valign="middle"> 
  		<td colspan="7" class="Title">
  		 <a href="javaScript:subMonth();" title="上一月" Class="DayButton">3</a> 
   <input name="year" type="text" size="4" maxlength="4" onkeydown="if (event.keyCode==13){setDate()}" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')"onpaste="this.value=this.value.replace(/[^0-9]/g,'')"/>
    年 
   <input name="month" type="text" size="1" maxlength="2" onkeydown="if (event.keyCode==13){setDate()}" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')"  onpaste="this.value=this.value.replace(/[^0-9]/g,'')"/> 
  
   月 <a href="JavaScript:addMonth();" title="下一月" Class="DayButton">4</a>
  </td>
 </tr>
 <tr align="center" valign="middle"> 
  <script language="JavaScript">  
   document.write("<TD class=DaySunTitle id=diary >" + days[0] + "</TD>"); 
   for (var intLoop = 1; intLoop < days.length-1;intLoop++) 
    document.write("<TD class=DayTitle id=diary>" + days[intLoop] + "</TD>"); 
    document.write("<TD class=DaySatTitle id=diary>" + days[intLoop] + "</TD>"); 
  </script>
 </tr> 
</thead>
<tbody border=1 cellspacing="0" cellpadding="0" ID="calendar" ALIGN=CENTER ONCLICK="getDiary()">
 <Script LANGUAGE="JavaScript">
  for (var intWeeks = 0; intWeeks < 6; intWeeks++)
  {
   document.write("<TR style='cursor:hand'>");
   for (var intDays = 0; intDays < days.length;intDays++) document.write("<TD class=CalendarTD onMouseover='buttonOver();' onMouseOut='buttonOut();'></TD>");
   document.write("</TR>");
  } 
 </Script>
</tbody>
</TABLE>
</div>
		
		
		</div>
	</div>
		
<Script  LANGUAGE="JavaScript">
 Calendar();
</Script>
  </div>
</body>
</html>