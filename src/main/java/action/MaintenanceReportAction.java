package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.MaintenanceDAO;
import model.MaintenanceRecord;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.List;

public class MaintenanceReportAction extends ActionSupport {
    @Override
    public String execute() throws Exception {
        MaintenanceDAO dao = new MaintenanceDAO();
        List<MaintenanceRecord> records = dao.findAll();

        String reportPath = ServletActionContext.getServletContext()
                .getRealPath("/reports/maintenance_report.jasper");

        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(records);
        JasperPrint jasperPrint = JasperFillManager.fillReport(reportPath, null, dataSource);

        HttpServletResponse response = ServletActionContext.getResponse();
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=maintenance_report.pdf");

        OutputStream out = response.getOutputStream();
        JasperExportManager.exportReportToPdfStream(jasperPrint, out);
        out.flush();
        out.close();

        return null; // streaming response
    }
}
