package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.reservationDao;

/**
 * Servlet implementation class UserPasswordChangeCon
 */
public class UserPasswordChangeCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserPasswordChangeCon() {
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
		System.out.println("UserPasswordChangeCon:post()");

		reservationDao reservationDao = new reservationDao();
		String userID= request.getParameter("userID");
		String currentPassword = request.getParameter("currentPassword");
		String newPassword = request.getParameter("newPassword");
		String newPasswordConfirm = request.getParameter("newPasswordConfirm");
		int num=0;

		if(!newPassword.equals(newPasswordConfirm)) {
			// 新しいパスワードと新しいパスワード（再確認）が不一致
			num=-1;
		}else {
			num = reservationDao.changePassword(userID, currentPassword, newPassword);
		}



			request.setAttribute("message",num);
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/userPasswordChange.jsp");
			dispatcher.forward(request, response);


	}

}