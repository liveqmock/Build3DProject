package xjtu.citi.dao;

import java.util.Collection;

import xjtu.citi.entity.SMEassessment;


public interface ISMEassessmentDao {
	//�����ҳ�����ҵ(����Ҫ�õĲ��������Լ�����)
	public Collection findCoreComp();
	//�������Ӧ��С��ҵ�ķ�ֵ(����Ҫ�õĲ��������Լ�����)
	public Collection calSMEassess();
	//������ҵid��ѯ�����и���ҵ��sme��Ϣ
	public Collection <SMEassessment>findByCompanyId(int id);
	public Collection<SMEassessment> getSMEassess();

}