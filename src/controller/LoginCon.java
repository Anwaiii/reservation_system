package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.reservationBean;
import model.reservationDao;

/**
 * Servlet implementation class LoginCon
 */
public class LoginCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginCon() {
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



		String userID = request.getParameter("userID");
		String password = request.getParameter("password");
		reservationDao reservationDao = new reservationDao();
		reservationBean user = new reservationBean();


		HttpSession session = request.getSession();
		 user = reservationDao.login(userID, password);

		if(user == null) {
			request.setAttribute("message", 0);
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/Login.jsp");
			dispatcher.forward(request, response);
		}else {

			session.setAttribute("user", user);
			session.setAttribute("userID", userID);
			session.setAttribute("role", user.getRole());

			if(user.getRole() == 0) {
				//	roleが0の場合は管理者
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/AdminCalendarCon");
			dispatcher.forward(request, response);

			}else if(user.getRole() == 1) {
				//	roleが1の場合は一般ユーザー
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/UserCalendarCon");
			dispatcher.forward(request, response);
			}
		}
	}

	}
