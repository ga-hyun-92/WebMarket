package filter;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class LogFilter implements Filter{
	private PrintWriter writer;
	
	@Override
	public void destroy() {
		System.out.println("LogFilter Down");
		
		writer.close();
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("LogFilter Start Up");
		
		String filename=filterConfig.getInitParameter("filename");
		if(filename==null) throw new ServletException("로그 파일의 이름을 찾을 수 없음");
		
		try {
			writer=new PrintWriter(new FileWriter(filename,true),true);
			
		} catch (Exception e) {
			throw new ServletException("로그 파일 열 수 없음");
		}
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		long start=System.currentTimeMillis();//필터가 시행된 시간.
		
		String clientIP=request.getRemoteAddr();
		String url=getURLPath(request);
		String startTime=getCurrentTime();
		
		chain.doFilter(request, response);
		
		//필터가 response응답받은 시간
		long end=System.currentTimeMillis();
		
		String endTime=getCurrentTime();
		long duration=end-start;
		
		System.out.println("클라이언트 IP: "+clientIP);
		System.out.println("URL : "+url);
		System.out.println("요청 처리 시작:" + startTime);
		System.out.println("요청 처리 완료:" + endTime);
		System.out.println("요청 처리 소요 시간:" + duration+"ms");
		System.out.println("========== ========== =========");
		
		writer.println("클라이언트 IP: "+clientIP);
		writer.println("URL : "+url);
		writer.println("요청 처리 시작:" + startTime);
		writer.println("요청 처리 완료:" + endTime);
		writer.println("요청 처리 소요 시간:" + duration+"ms");
		writer.println("========== ========== =========");
	}
	
	private String getURLPath(ServletRequest request) {
		HttpServletRequest req;
		
		String currentPath="";
		String queryString="";
		
		if (request instanceof HttpServletRequest) {
			req=(HttpServletRequest)request;
			currentPath=req.getRequestURI();//사용자가 요청한 경로
			queryString=req.getQueryString();//getParameter 사용해서 요청 파라미터 전달하면 ?로 뒤에 전달한다고 했죠 get방식으로 보낸 요청파라미터 가져온거
			queryString= queryString==null?"":"?"+queryString;
		
		}
		
		return currentPath+queryString;
	}
	
	private String getCurrentTime() {
		DateFormat formatter=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Calendar calendar=Calendar.getInstance();
		calendar.setTimeInMillis(System.currentTimeMillis());
		return formatter.format(calendar.getTime());
	}

}
