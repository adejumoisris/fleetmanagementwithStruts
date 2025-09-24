package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.MaintenanceDAO;
import model.MaintenanceRecord;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MaintainanceReport extends ActionSupport {
    private InputStream inputStream ;

    public InputStream getInputStream() {
        return inputStream;
    }

    public String execute(){

        MaintenanceDAO dao = new MaintenanceDAO();
        List<MaintenanceRecord> records = dao.findAll();

        try {
            Map<String, Object> parmas = new HashMap<>();
            InputStream jrxmlStream = getClass().getResourceAsStream("/reports/maintenance_report.jrxml");
            JasperReport jasperReport = JasperCompileManager.compileReport(jrxmlStream);
            JRBeanCollectionDataSource datasource = new JRBeanCollectionDataSource(records);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parmas, datasource);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            JasperExportManager.exportReportToPdfStream(jasperPrint, baos);
            inputStream = new ByteArrayInputStream(baos.toByteArray());
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
        return SUCCESS;
    }
}
