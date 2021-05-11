package com.repAppPho.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.hibernate.Session;
import org.hibernate.query.Query;

import com.repAppDet.model.RepAppDetVO;
import com.repAppPho.model.RepAppPhoVO;

import hibernate.util.HibernateUtil;

public class RepAppPhoDAO implements RepAppPhoDAO_interface {

	private static final String GET_BY_FK = "from RepAppPhoVO where rad_no = ?0 order by rap_no";
	
	public void insert(RepAppPhoVO repAppPhoVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(repAppPhoVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	public void update(RepAppPhoVO repAppPhoVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(repAppPhoVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	public void delete(Integer rap_no) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			RepAppPhoVO repAppPhoVO = new RepAppPhoVO();
			repAppPhoVO.setRap_no(rap_no);
			session.delete(repAppPhoVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	public RepAppPhoVO getByPK(Integer rap_no) {
		RepAppPhoVO repAppPhoVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			repAppPhoVO = (RepAppPhoVO)session.get(RepAppPhoVO.class, rap_no);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return repAppPhoVO;
	}

	public List<RepAppPhoVO> getByFK(Integer rad_no) {
		List<RepAppPhoVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query<RepAppPhoVO> query = session.createQuery(GET_BY_FK, RepAppPhoVO.class);
			list = query.getResultList();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

}
