package cn.mldn.util.split;
import javax.servlet.http.HttpServletRequest;
public class ActionSplitPageUtil {
	private long currentPage = 1;
	private int lineSize = 5;
	private String column;
	private String keyWord;
	private HttpServletRequest request;
	public ActionSplitPageUtil(HttpServletRequest request, String columnData,
			String url) {
		request.setAttribute("columnData", columnData);
		request.setAttribute("url", url);
		this.request = request;
		this.handleParameter();
	}
	private void handleParameter() { // 针对于所有的分页参数进行处理
		try {
			this.currentPage = Long.parseLong(this.request.getParameter("cp"));
		} catch (Exception e) {
		} // 分页的参数不正确，就出错
		try {
			this.lineSize = Integer.parseInt(this.request.getParameter("ls"));
		} catch (Exception e) {
		}
		this.column = this.request.getParameter("col");
		this.keyWord = this.request.getParameter("kw");
		this.request.setAttribute("currentPage", this.currentPage);
		this.request.setAttribute("lineSize", this.lineSize);
		this.request.setAttribute("column", this.column);
		this.request.setAttribute("keyWord", this.keyWord);
	}
	public long getCurrentPage() {
		return currentPage;
	}
	public String getColumn() {
		return column;
	}
	public String getKeyWord() {
		return keyWord;
	}
	public int getLineSize() {
		return lineSize;
	}
}
