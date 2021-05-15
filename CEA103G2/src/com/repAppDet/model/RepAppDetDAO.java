package com.repAppDet.model;

import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.query.Query;

import com.repAppPho.model.RepAppPhoVO;

import hibernate.util.HibernateUtil;

public class RepAppDetDAO implements RepAppDetDAO_interface {
	
	public static final String GET_BY_FK = "from RepAppDetVO where ra_no=?0 order by rad_no";
	public static final String GET_ALL = "from RepAppDetVO order by rad_no";
	
	public void insert(RepAppDetVO repAppDetVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(repAppDetVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	public void update(RepAppDetVO repAppDetVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(repAppDetVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	public RepAppDetVO getByPK(Integer rad_no) {
		RepAppDetVO repAppDetVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			repAppDetVO = (RepAppDetVO)session.get(RepAppDetVO.class, rad_no);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return repAppDetVO;
	}

	public List<RepAppDetVO> getByFK(Integer ra_no) {
		List<RepAppDetVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query<RepAppDetVO> query = session.createQuery(GET_BY_FK, RepAppDetVO.class);
			list = query.getResultList();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	public List<RepAppDetVO> getAll() {
		List<RepAppDetVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query<RepAppDetVO> query = session.createQuery(GET_ALL, RepAppDetVO.class);
			list = query.getResultList();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}
	
	public Set<RepAppPhoVO> getPhosByPK(Integer rad_no) {
		return getByPK(rad_no).getSet_RepAppPhoVO();
	}

}
