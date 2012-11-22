package xjtu.citi.chart;

import java.awt.Color; 
import java.awt.Font; 
import java.io.IOException; 
import java.io.PrintWriter; 
import java.text.NumberFormat; 
import java.text.SimpleDateFormat; 
import java.util.Iterator;

import javax.servlet.http.HttpSession; 
import org.jfree.chart.ChartFactory; 
import org.jfree.chart.ChartRenderingInfo; 
import org.jfree.chart.ChartUtilities; 
import org.jfree.chart.JFreeChart; 
import org.jfree.chart.axis.DateAxis; 
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.NumberTickUnit;
import org.jfree.chart.entity.StandardEntityCollection; 
import org.jfree.chart.plot.XYPlot; 
import org.jfree.chart.renderer.xy.XYItemRenderer; 
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer; 
import org.jfree.chart.labels.*;
import org.jfree.chart.servlet.ServletUtilities; 
import org.jfree.chart.title.LegendTitle;
import org.jfree.chart.title.TextTitle; 
import org.jfree.data.time.Day; 
import org.jfree.data.time.TimeSeries; 
import org.jfree.data.time.TimeSeriesCollection; 
import org.jfree.data.xy.XYDataset; 
import org.jfree.ui.RectangleInsets; 

import xjtu.citi.dao.ISMEassessmentDao;
import xjtu.citi.impl.SMEassessmentDaoImpl;
import xjtu.citi.entity.SMEassessment;
import java.util.Collection;
/** 
* ����ͼ�Ļ��� 
*/ 
public class RiskLevelHistoryChart
{ 
/** 
* ��������ͼƬ���ļ��� 
* @param session 
* @param pw 
* @return ����ͼƬ���ļ��� 
*/ 
public String getRiskLevelChart(HttpSession session, PrintWriter pw ,int id) 
{ 
XYDataset dataset = this.createDateSet(id);//�������ݼ� 
String fileName = null; 
//����JFreeChart 
JFreeChart chart = ChartFactory.createTimeSeriesChart( 
"��ҵ��ʷ���յȼ�����", // title 
"����", // x-axis label 
"���յȼ�", // y-axis label 
dataset, // data 
true, // create legend?
true, // generate tooltips? 
false // generate URLs? 
); 

//����JFreeChart����ʾ����,��ͼ���ⲿ���ֽ��е��� 
chart.setBackgroundPaint(Color.WHITE);//��������ͼ����ɫ 

//���������С����״ 
Font font_title = new Font("����", Font.BOLD, 16); 
Font font_tig = new Font("����", Font.BOLD, 12); 
//����
TextTitle title = new TextTitle("��ҵ��ʷ���յȼ�����", font_title); 
chart.setTitle(title); 

//������ 
/*TextTitle subtitle = 
new TextTitle("������", new Font("����", Font.BOLD, 12)); 
chart.addSubtitle(subtitle); 
chart.setTitle(title); //���� 
*/

//����ͼʾ�����ַ� 
LegendTitle legengTitle = chart.getLegend(); 
legengTitle.setItemFont(font_tig); 

XYPlot plot = (XYPlot) chart.getPlot();//��ȡͼ�εĻ��� 
plot.setBackgroundPaint(Color.lightGray);//�������񱳾�ɫ 
plot.setDomainGridlinePaint(Color.white);//������������(Domain��)��ɫ 
plot.setRangeGridlinePaint(Color.white);//�������������ɫ 
plot.setAxisOffset(new RectangleInsets(5.0, 5.0, 5.0, 5.0));//��������ͼ��xy��ľ��� 
plot.setDomainCrosshairVisible(true); 
plot.setRangeCrosshairVisible(true); 
XYItemRenderer r = plot.getRenderer(); 
if (r instanceof XYLineAndShapeRenderer) 
{ 
XYLineAndShapeRenderer renderer = (XYLineAndShapeRenderer) r; 
renderer.setBaseShapesVisible(true); 
renderer.setBaseShapesFilled(true);
renderer.setSeriesPaint(0, Color.blue);//����������ɫ
renderer.setBaseItemLabelGenerator(new StandardXYItemLabelGenerator());
renderer.setBaseItemLabelsVisible(true); //����������ֵ�Ƿ�ɼ�
} 
//����Y�� 
NumberAxis numAxis = (NumberAxis) plot.getRangeAxis(); 
NumberFormat numFormater = NumberFormat.getNumberInstance(); 
numAxis.setNumberFormatOverride(numFormater); 
numAxis.setTickLabelFont(font_tig);
numAxis.setLabelFont(font_title);
numAxis.setUpperMargin(0.15); //��ߵ�߾�
//numAxis.setInverted(true);//�����Ƿ���
numAxis.setAutoTickUnitSelection(false);
numAxis.setTickUnit(new NumberTickUnit(1) );//����������


//������ʾ��Ϣ 

//����X�ᣨ�����ᣩ 
DateAxis axis = (DateAxis) plot.getDomainAxis(); 
axis.setDateFormatOverride(new SimpleDateFormat("yy��MM��dd��")); 
axis.setLabelFont(font_title);//����x�����
axis.setTickLabelFont(font_tig);//����x�������ʽ
ChartRenderingInfo info = new ChartRenderingInfo( new StandardEntityCollection()); 
try 
{ 
fileName = ServletUtilities.saveChartAsPNG(chart, 500, 300, info, 
session);//����ͼƬ 
// Write the image map to the PrintWriter 
ChartUtilities.writeImageMap(pw, fileName, info, false); 
} 
catch (IOException e) 
{ 
e.printStackTrace(); 
} 
pw.flush(); 
return fileName;//��������ͼƬ���ļ��� 
} 
/** 
* ��������ͼ����������ݼ� 
* @return �������ݼ� 
*/ 
private XYDataset createDateSet(int id) 
{ 
TimeSeriesCollection dataset = new TimeSeriesCollection();//ʱ���������ݼ��� 
TimeSeries s1 = new TimeSeries("��ҵ��ʷ���յȼ�����",Day.class);//����ʱ������Դ��ÿһ��//TimeSeries��ͼ����һ������ 
ISMEassessmentDao dao = new SMEassessmentDaoImpl();
Collection<SMEassessment>list=null;
list=dao.findByCompanyId(id);
for (Iterator iterator = list.iterator(); iterator.hasNext();)
{
	SMEassessment sme = (SMEassessment) iterator.next();
	s1.add(new Day(sme.getTime()),(sme.getRisklevel().charAt(0)-'A'+1));
}
dataset.addSeries(s1); 
dataset.setDomainIsPointsInTime(true); 
return dataset; 
} 

} 