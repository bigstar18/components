package gnnt.MEBS.common.front.statictools.filetools;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import gnnt.MEBS.common.front.statictools.Tools;

public class POIExcelUtil {
	private int totalRows = 0;
	private int totalCells = 0;

	public List<ArrayList<String>> read(FileInputStream fileInputStream, String fileName) {
		List<ArrayList<String>> dataLst = new ArrayList();
		if ((fileName == null) || (!fileName.matches("^.+\\.(?i)((xls)|(xlsx))$"))) {
			return dataLst;
		}
		boolean isExcel2003 = true;
		if (fileName.matches("^.+\\.(?i)(xlsx)$")) {
			isExcel2003 = false;
		}
		if (fileInputStream == null) {
			File file = new File(fileName);
			if ((file == null) || (!file.exists())) {
				return dataLst;
			}
			try {
				dataLst = read(new FileInputStream(file), isExcel2003);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} else {
			try {
				dataLst = read(fileInputStream, isExcel2003);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return dataLst;
	}

	public List<ArrayList<String>> read(InputStream inputStream, boolean isExcel2003) {
		List<ArrayList<String>> dataLst = null;
		try {
			Workbook wb = isExcel2003 ? new HSSFWorkbook(inputStream) : new XSSFWorkbook(inputStream);
			dataLst = read(wb);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return dataLst;
	}

	public int getTotalRows() {
		return this.totalRows;
	}

	public int getTotalCells() {
		return this.totalCells;
	}

	private List<ArrayList<String>> read(Workbook wb) {
		List<ArrayList<String>> dataLst = new ArrayList();

		Sheet sheet = wb.getSheetAt(0);
		this.totalRows = sheet.getPhysicalNumberOfRows();
		if ((this.totalRows >= 1) && (sheet.getRow(0) != null)) {
			this.totalCells = sheet.getRow(0).getPhysicalNumberOfCells();
		}
		for (int r = 0; r < this.totalRows; r++) {
			Row row = sheet.getRow(r);
			if (row != null) {
				ArrayList<String> rowLst = new ArrayList();
				for (short c = 0; c < getTotalCells(); c = (short) (c + 1)) {
					Cell cell = row.getCell(c);
					String cellValue = "";
					if (cell == null) {
						rowLst.add(cellValue);
					} else {
						if (cell.getCellType() == 0) {
							if (HSSFDateUtil.isCellDateFormatted(cell)) {
								cellValue = Tools.fmtDate(cell.getDateCellValue());
							} else {
								cellValue = getRightStr(cell.getNumericCellValue() + "");
							}
						} else if (1 == cell.getCellType()) {
							cellValue = cell.getStringCellValue();
						} else if (4 == cell.getCellType()) {
							cellValue = cell.getBooleanCellValue() + "";
						} else {
							cellValue = cell.toString();
						}
						rowLst.add(cellValue);
					}
				}
				dataLst.add(rowLst);
			}
		}
		return dataLst;
	}

	private String getRightStr(String sNum) {
		DecimalFormat decimalFormat = new DecimalFormat("#.000000");
		String resultStr = decimalFormat.format(new Double(sNum));
		if (resultStr.matches("^[-+]?\\d+\\.[0]+$")) {
			resultStr = resultStr.substring(0, resultStr.indexOf("."));
		}
		return resultStr;
	}

	public static void main(String[] args) throws Exception {
		for (int i = 0; i < 20; i++) {
			List<ArrayList<String>> dataLst = new POIExcelUtil().read(null, "E://我的平台页面计划xlsx.xlsx");
			for (ArrayList<String> innerLst : dataLst) {
				StringBuffer rowData = new StringBuffer();
				for (String dataStr : innerLst) {
					rowData.append(",").append(dataStr);
				}
				if (rowData.length() > 0) {
					System.out.println(rowData.deleteCharAt(0).toString());
				}
			}
		}
		Thread.sleep(100000L);
	}
}
