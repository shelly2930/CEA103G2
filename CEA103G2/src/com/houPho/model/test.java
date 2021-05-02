package com.houPho.model;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/test")
public class test extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HouPhoDAO a = new HouPhoDAO();
		HouPhoVO pic = new HouPhoVO();
		pic.setHos_no(3);
		pic.setHos_pic_no(5);
		
		System.out.println(a.findByPrimaryKey(1).getHos_no());
		File f = new File("C:/TestPic/005.jpg");
		if(!f.exists()) {
			System.out.println("§ä¤£¨ì");
		}else {
			InputStream is = new FileInputStream(f);
			byte[] buf = new byte[is.available()];
			is.read(buf);
			for(int i =0;i<buf.length;i++) {
				System.out.println(buf[i]);
			}
			pic.setHos_pic(buf);
			a.insert(pic);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
