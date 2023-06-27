package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.reservationDao;



/**
 * Servlet implementation class DeleteCon
 */
public class DeleteCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteCon() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession sessionCheck = request.getSession(false);
		if (sessionCheck == null || sessionCheck.getAttribute("userID") == null
				|| (Integer)sessionCheck.getAttribute("role") != 0) {
			response.sendRedirect("Login.jsp");
			return;
		}
		System.out.println("DeleteCon:get()");

		reservationDao reservationDao = new reservationDao();
		String userID = request.getParameter("userID");
		int num = 0;

		num = reservationDao.deleteUser(userID);

		// num = 1は削除成功
		request.setAttribute("message",num);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/adminUpdateUser.jsp");
		dispatcher.forward(request, response);
	}


}
