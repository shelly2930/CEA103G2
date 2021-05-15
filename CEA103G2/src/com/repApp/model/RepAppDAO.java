package com.repApp.model;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.query.Query;

import com.memTen.model.MemTenVO;
import com.renCon.model.RenConVO;
import com.repApp.model.RepAppVO;
import com.repAppDet.model.RepAppDetVO;
import com.repAppPho.model.RepAppPhoVO;

import hibernate.util.HibernateUtil;

public class RepAppDAO implements RepAppDAO_interface {
	
	private static final String GET_ALL = "from RepAppVO order by ra_no";
	
//	public void insert(RepAppVO repAppVO, List<RepAppDetVO> list_RepAppDetVO, List<RepAppPhoVO> list_RepAppPhoVO) {
	public void insert(RepAppVO repAppVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(repAppVO);
//			for(RepAppDetVO repAppDetVO : list_RepAppDetVO)
//				session.saveOrUpdate(repAppDetVO);
//			for(RepAppPhoVO repAppPhoVO : list_RepAppPhoVO)
//				session.saveOrUpdate(repAppPhoVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	public void update(RepAppVO repAppVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(repAppVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	public RepAppVO getByPK(Integer ra_no) {
		RepAppVO repAppVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			repAppVO = (RepAppVO) session.get(RepAppVO.class, ra_no);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return repAppVO;
	}

	public List<RepAppVO> getAll() {
		List<RepAppVO> list = null;
		System.out.println("1");
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		System.out.println("2");
		try {
			session.beginTransaction();
			Query<RepAppVO> query = session.createQuery(GET_ALL, RepAppVO.class);
			list = query.getResultList();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}
	
	public Set<RepAppDetVO> getDetsByPK(Integer ra_no) {
		return getByPK(ra_no).getSet_RepAppDetVO();
	}
	
public static void main(String[] args) {
		
		RepAppDAO repAppDAO = new RepAppDAO();
		RepAppVO repAppVO = new RepAppVO();
//		Set<RepAppDetVO> set_RepAppDetVO = new LinkedHashSet<RepAppDetVO>();
//		
//		RepAppDetVO repAppDetVO = new RepAppDetVO();
//		repAppDetVO.setRad_dmg("我");
//		repAppDetVO.setRad_dsc("壞掉了");
//		repAppDetVO.setRepAppVO(repAppVO);
//		
//		RepAppDetVO repAppDetVO2 = new RepAppDetVO();
//		repAppDetVO2.setRad_dmg("你");
//		repAppDetVO2.setRad_dsc("也壞了");
//		repAppDetVO2.setRepAppVO(repAppVO);
//		
//		set_RepAppDetVO.add(repAppDetVO);
//		set_RepAppDetVO.add(repAppDetVO2);
//		
		repAppVO.setMem_no(1);
		repAppVO.setRtct_no(3);
//		repAppVO.setRa_app_time(java.sql.Timestamp.valueOf("2021-01-15 10:10:10"));
		repAppVO.setRa_order_time(java.sql.Timestamp.valueOf("2021-01-16 10:10:10"));
//		repAppVO.setSet_RepAppDetVO(set_RepAppDetVO);
//		
//		repAppDAO.insert(repAppVO);
		
		repAppVO.setRa_no(6);
		repAppVO.setRa_status(new Byte("1"));
		repAppDAO.update(repAppVO);
		
	}
}
