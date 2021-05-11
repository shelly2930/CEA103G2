package com.repApp.model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.Query;

import com.repApp.model.RepAppVO;
import com.repAppDet.model.RepAppDetVO;
import com.repAppPho.model.RepAppPhoVO;

import hibernate.util.HibernateUtil;

public class RepAppDAO implements RepAppDAO_interface {
	
	private static final String GET_ALL = "from RepAppVO order by ra_no";
	
	public void insert(RepAppVO repAppVO, List<RepAppDetVO> list_RepAppDetVO, List<RepAppPhoVO> list_RepAppPhoVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(repAppVO);
			for(RepAppDetVO repAppDetVO : list_RepAppDetVO)
				session.saveOrUpdate(repAppDetVO);
			for(RepAppPhoVO repAppPhoVO : list_RepAppPhoVO)
				session.saveOrUpdate(repAppPhoVO);
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
	
	public List<RepAppDetVO> getDetsByPK(Integer ra_no) {
		return getByPK(ra_no).getList_RepAppDetVO();
	}
	
}
