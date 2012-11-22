<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<%@ page import="xjtu.citi.chart.ScoreHistoryChart"%>
	<%@ page import="xjtu.citi.chart.IndustryRankHistoryChart"%>
	<%@ page import="xjtu.citi.chart.RankHistoryChart"%>
	<%@ page import="xjtu.citi.chart.RiskLevelHistoryChart"%>
	<%@ page import ="java.io.PrintWriter"%>
	<% ScoreHistoryChart scoreChart=new ScoreHistoryChart(); 
	String fileName_score=scoreChart.getScoreChart(session,new PrintWriter(out),Integer.parseInt(request.getSession().getAttribute("companyinfoId").toString())); 
	String graphURL_score = request.getContextPath() + "/servlet/DisplayChart?filename=" + fileName_score; %> 
	<% IndustryRankHistoryChart inRankChart=new  IndustryRankHistoryChart();
	String fileName_inRank=inRankChart.getInRankChart(session,new PrintWriter(out),Integer.parseInt(request.getSession().getAttribute("companyinfoId").toString()));
	String graphURL_inRank = request.getContextPath() + "/servlet/DisplayChart?filename=" + fileName_inRank; %>
	<% RankHistoryChart RankChart=new  RankHistoryChart();
	String fileName_Rank=RankChart.getRankChart(session,new PrintWriter(out),Integer.parseInt(request.getSession().getAttribute("companyinfoId").toString()));
	String graphURL_Rank = request.getContextPath() + "/servlet/DisplayChart?filename=" + fileName_Rank; %>
	<% RiskLevelHistoryChart RiskChart=new  RiskLevelHistoryChart();
	String fileName_Risk=RiskChart.getRiskLevelChart(session,new PrintWriter(out),Integer.parseInt(request.getSession().getAttribute("companyinfoId").toString()));
	String graphURL_Risk = request.getContextPath() + "/servlet/DisplayChart?filename=" + fileName_Risk; %>
<head>

	<title>XJTU-ME</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	<%@ page contentType="text/html; charset=GBK"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<script type="text/javascript" src="js/wz_jsgraphics.js"></script>
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/DWRSMEAccess.js"></script>
	<script language="JavaScript" type="text/javascript" src="js/wysiwyg.js"></script> 
	<script language="JavaScript" type="text/javascript" src="js/wysiwyg-settings.js"></script> 
	<script type="text/javascript">
    // attach the editor to all textareas of your page.
   	WYSIWYG.attach('textarea3', small);
    // attach the editor to the textarea with the identifier 'textarea1'.
	</script> 
	<script language="javascript">
			function check_null(caller)
			{				
				if(caller.value.length == 0)
				{
					alert("�����Ϊ��");										
				}
			}
		</script>
	<script language="JavaScript" type="text/javascript" src="js/jquery.min.js"></script> 
	<script type="text/javascript"> 
		$(function(){
			// Ԥ����ʾ��һ�� Tab
			var _showTab = 0;
			$('.abgne_tab').each(function(){
				// Ŀǰ��ҳǩ����
				var $tab = $(this);
	 
				$('ul.tabs li', $tab).eq(_showTab).addClass('active');
				$('.tab_content', $tab).hide().eq(_showTab).show();
				
				
				$('ul.tabs li', $tab).click(function() {
				
					var $this = $(this),
						_clickTab = $this.find('a').attr('href');
					
					$this.addClass('active').siblings('.active').removeClass('active');
					
					$(_clickTab).stop(false, true).fadeIn().siblings().hide();
	 
					return false;
				}).find('a').focus(function(){
					this.blur();
				});
			});
		});
	</script> 
</head>
<body>
<div id="mainPan">
	<div class="header">
		<jsp:include page="header.jsp"></jsp:include>
	</div>
	<div class="left">
		<jsp:include page="left.jsp"></jsp:include>
	</div>
	<div class="middle">
	<div id="middlePan">
	<div align="right">
	<a href="${pageContext.request.contextPath}/getback.do">����</a>
	 </div>
	  <br />
	  <div class="abgne_tab"> 
		<ul class="tabs"> 
			<li><a href="#tab1">��Ϣ����</a></li> 
			<li><a href="#tab2">���ݲ�ѯ</a></li> 
		</ul>
		<table></table>
		<div class="tab_container"> 
			<div id="tab1" class="tab_content"> 
				
				<form name="form1" style="padding-left: 5%;" action="${pageContext.request.contextPath}/feedback2.do" method="post">
				<br /><br /><h4>���԰�</h4><br /><br />
				<table width="400">
				<c:forEach items="${feedbacks}" var="feedback"
								varStatus="varStatus">
					<tr width="400">
						<p>��${varStatus.count}�� &nbsp;&nbsp;&nbsp;&nbsp; ${feedback.time}&nbsp;&nbsp;&nbsp;&nbsp;
						<c:if test="${feedback.reviewer == 0}">
							${feedback.companyInfo.name}
						</c:if>
						<c:if test="${feedback.reviewer == 1}">
							��������
						</c:if>
						</p>
					</tr>
					<tr>
					<p>${feedback.description}</p>
				</tr>
				<tr>
				<p>-----------------------------------------------------------------------</p>
				</tr>
				</c:forEach>
			</table>
			<div>
				<textarea id="textarea3" name="description"rows="3" cols="50" value="description"></textarea>
			</div>
			<br />
		      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="submit" value="�ύ" style="margin-right:100px;"/>
											&nbsp;
				<input type="reset" value="ȡ��" />
			</form>
			
		</div> 
			
			<div id="tab2" class="tab_content"> 
				 <div class="abgne_tab"> 
				 <br /><h4>��Ϣ��ѯ</h4><br />
		<ul class="tabs"> 
			<li><a href="#tab4">��ֵ</a></li> 
			<li><a href="#tab5">���յȼ�</a></li> 
			<li><a href="#tab6">��ҵ����</a></li> 
			<li><a href="#tab7">������</a></li> 
			<li><a href="#tab9">����ͼ</a></li> 
			<li><a href="#tab8">����</a></li> 
		</ul> 
		<table></table>
		<div class="tab_container"> 
			<div id="tab4" class="tab_content"> 
			<table>
				<tr>
					<td><span>��ҵ���ƣ�</span></td>
					<td><span>${companyinfo.name}</span></td>
				</tr>
			</table>
			  
				<img src="<%= graphURL_score %>" width=500 height=300 border=0 usemap="<%= fileName_score %>"></img>
			</div> 
			
			<div id="tab5" class="tab_content"> 
				<table>
				<tr>
					<td><span>��ҵ���ƣ�</span></td>
					<td><span>${companyinfo.name}</span></td>					
				</tr>
				
				</table >
				
			  		<img src="<%= graphURL_Risk %>" width=500 height=300 border=0 usemap="<%= fileName_Risk %>"></img>
			  	</div>
			  <div id="tab6" class="tab_content"> 
			  	<table>
				<tr>
					<td><span>��ҵ���ƣ�</span></td>
					<td><span>${companyinfo.name}</span></td>
				</tr>
				</table>
				
			  		<img src="<%= graphURL_inRank %>" width=500 height=300 border=0 usemap="<%= fileName_inRank %>"></img>
			  	</div>
			  	
			  	<div id="tab7" class="tab_content"> 
			  		<table>
					<tr>
						<td><span>��ҵ���ƣ�</span></td>
						<td><span>${companyinfo.name}</span></td>
					</tr>
					</table>	<img src="<%= graphURL_Rank %>" width=500 height=300 border=0 usemap="<%= fileName_Rank %>"></img>  
			  	</div>
			   <div id="tab9" class="tab_content"> 
			   <form>
				  	<div id="myCanvas" style="position:relative;height:0px;width:100%;color:lightblue;">
<script>
var jg = new jsGraphics("myCanvas");
function myDrawFunction(data)
{ 
	var  s_width,s_height;//��Ļ���Ⱥ͸߶�
    s_width =500;
    s_height =600;
    var  s_x,s_y;//����ʵ�������
    s_x=(s_width*38)/100;
    s_y=(s_height*23)/100;
	var entity_center=30;//����ʵ��Բ�����о��α߳�
	var radius_x=s_x+entity_center/2;
	var radius_y=s_y+entity_center/2;//����ʵ��Բ��Բ������
	var center_name=data.name;
	var score=data.score;
	//����ʵ��Ļ���
	jg.setColor("#DD2222");
	jg.drawString("��ֵ��"+score, s_x, s_y-(entity_center*7)/10 ); 
	jg.drawString(center_name, s_x, s_y+entity_center ); 
	
	jg.fillEllipse( s_x,s_y,entity_center,entity_center);//��ʵ��Բ
	jg.paint();
	
	var num_total=16;//�ܱ�ʵ����ܸ���
	entity_center=20;//�ܱ�ʵ���Բ�����о��α߳�
	center_name="��Χʵ��" ;
	var radius=s_height/3;//�ֲ��뾶

}
function myDrawFunction2(data2)
{ 
	var  s_width,s_height;//��Ļ���Ⱥ͸߶�
    s_width =500;
    //alert(s_width);
    s_height =600;
    var  s_x,s_y;//����ʵ�������
    s_x=(s_width*38)/100;
    s_y=(s_height*23)/100;
	var entity_center=35;//����ʵ��Բ�����о��α߳�
	var radius_x=s_x+entity_center/2;
	var radius_y=s_y+entity_center/2;//����ʵ��Բ��Բ������
	var center_name="����ʵ��";
	var score=88;
	//����ʵ��Ļ���
	
	
	var num_total=data2.length; //�ܱ�ʵ����ܸ���
	var entity_center2=25;//�ܱ�ʵ���Բ�����о��α߳�

	var radius=(s_height*22)/100;//�ֲ��뾶
	for(var i=1;i<=num_total;i++)
	{
		center_name = data2[i-1].name;
		var score= data2[i-1].score;
		s_x=radius_x+radius*(Math.cos(2*i*Math.PI/num_total));
		s_y=radius_y+radius*(Math.sin(2*i*Math.PI/num_total));
		
		if(score>0)
		{
			jg.drawString(center_name, s_x, s_y+entity_center2 ); 
			jg.drawString("��ֵ��"+score, s_x, s_y-(entity_center2*7)/10 ); 
			jg.setColor("#DD2222");
			jg.fillEllipse( s_x,s_y,entity_center2,entity_center2);//��ʵ��Բ
			jg.drawLine(radius_x,radius_y,s_x+entity_center2/2,s_y+entity_center2/2);
			jg.paint();
		}
		else{
			jg.drawString(center_name, s_x, s_y+entity_center ); 
		  	jg.drawString("core", s_x, s_y-(entity_center*5)/10 );
		  	jg.setColor("#DD2222");
			jg.fillEllipse( s_x,s_y,entity_center,entity_center);//��ʵ��Բ
			jg.drawLine(radius_x,radius_y,s_x+entity_center/2,s_y+entity_center/2);
			jg.paint();
		}
		
	}
}

function findcenter()
{
	var id="<%=session.getAttribute("companyinfoId")%>";
	DWRSMEAccess.findById(id,myDrawFunction);
}

function findaround()
{
	var id="<%=session.getAttribute("companyinfoId")%>";
	DWRSMEAccess.findBySME(id,myDrawFunction2)
}
findcenter();
findaround();
myDrawFunction(data);
myDrawFunction2(data2)
</script>
</div>
<div id="myCanvas" style="position:relative;height:0px;width:100%;color:lightblue;">

</div>
</form>
			  	</div>	
			 
			 <div id="tab8" class="tab_content"> 
			  	<form name="form1" style="padding-left: 3%;" action="${pageContext.request.contextPath}/companysearch2.do" method="post">
			  		<table>
						<tr>
							<td>
								��ѯ���ڣ�&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								<input type="text"  name="lo" value="" size="12"/>
									---
								<input type="text"  name="mo" value="" size="12"/>
							</td>
							<td>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="����" style="margin-right:100px;"/>
							</td>
						</tr>
			  		</table>
				</form>
				
				<div class="details">
			  		<table class="history_talbe">
							<tr align="center">
								<td align="center" width="80">
									ʱ��
								</td>
								<td width="80">
									���յȼ�
								</td>
								<td width="80">
									��ҵ����
								</td>
								<td width="80">
									��ֵ
								</td>
								<td width="80">
									������
								</td>
							</tr>
							<c:forEach items="${sm}" var="sminfo"
								varStatus="varStatus">
								<tr align="center">
									 <td>
										${sminfo.time}
									</td>
								
									<td>
										${sminfo.risklevel}
									</td>
									<td>
										${sminfo.industryrank}
									</td>
									<td>
										${sminfo.score}
									</td>
									<td>
										${sminfo.rank}
									</td>
									
								</tr>
							</c:forEach>
						</table>
			  		</div>
			</div> 
		</div> 
	</div>
	
			</div> 
		</div> 
	</div>
	</div> 
		</div>
		<div class="right">
		<jsp:include page="right.jsp"></jsp:include>
		</div>
		
		<div class="footer">
		<jsp:include page="footer.jsp"></jsp:include>
		</div>
</div>
</body>
</html>