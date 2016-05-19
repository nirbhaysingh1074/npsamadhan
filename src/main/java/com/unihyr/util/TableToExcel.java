package com.unihyr.util;

import java.io.FileOutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.unihyr.constraints.GeneralConfig;
import com.unihyr.domain.GlobalRating;
import com.unihyr.domain.PostConsultant;

public class TableToExcel
{
	public static void generateExcel(List<GlobalRating> globalRating){
		try
		{
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
			Date date = new Date();
			String filename =GeneralConfig.UploadPath+dateFormat.format(date)+ "Write.xls";
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet("FirstSheet");
			HSSFRow rowhead = sheet.createRow((short) 0);
			rowhead.createCell((short) 0).setCellValue("SNo.");
			rowhead.createCell((short) 1).setCellValue("Rating Param");
			rowhead.createCell((short) 1).setCellValue("Value");
			rowhead.createCell((short) 3).setCellValue("Industry Id");
			rowhead.createCell((short) 4).setCellValue("Consultant Name");
			int i = 1;
			for (GlobalRating rating : globalRating)
			{
				HSSFRow row = sheet.createRow(i);
				row.createCell((short) 0).setCellValue(i);
				row.createCell((short) 1).setCellValue(rating.getRatingParameter().getName());
				row.createCell((short) 2).setCellValue(rating.getRatingParamValue());
				row.createCell((short) 3).setCellValue(rating.getIndustryId());
				row.createCell((short) 4).setCellValue(rating.getRegistration().getConsultName());
				i++;
			}
			FileOutputStream fileOut = new FileOutputStream(filename);
			workbook.write(fileOut);
			fileOut.close();
		} catch ( Exception ex ) {
	    System.out.println(ex);
	}}
		public static void generateExcelwhenread(List<PostConsultant> postconsultant){
			try
			{
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
				Date date = new Date();
				System.out.println(dateFormat.format(date));
				String filename = GeneralConfig.UploadPath+dateFormat.format(date)+"Read.xls";
				HSSFWorkbook workbook = new HSSFWorkbook();
				HSSFSheet sheet = workbook.createSheet("FirstSheet");
				HSSFRow rowhead = sheet.createRow((short) 0);
				rowhead.createCell((short) 0).setCellValue("SNo.");
				rowhead.createCell((short) 1).setCellValue("turnaround time");
				rowhead.createCell((short) 2).setCellValue("tr percentile");
				rowhead.createCell((short) 3).setCellValue("shortlistRatio");
				rowhead.createCell((short) 4).setCellValue("shortlistPercentile");
				rowhead.createCell((short) 5).setCellValue("closure");
				rowhead.createCell((short) 6).setCellValue("closure Percentile");
				rowhead.createCell((short) 7).setCellValue("offerdrop");
				rowhead.createCell((short) 8).setCellValue("od Percentile");
				rowhead.createCell((short) 9).setCellValue("industry coverage");
				rowhead.createCell((short) 10).setCellValue("ic percentile");
				rowhead.createCell((short) 11).setCellValue("Consultant Name");
				rowhead.createCell((short) 12).setCellValue("Post Name");
				rowhead.createCell((short) 13).setCellValue("total percentile");
				int i = 1;
				for (PostConsultant rating : postconsultant)
				{
					HSSFRow row = sheet.createRow(i);
					row.createCell((short) 0).setCellValue(i);
					row.createCell((short) 1).setCellValue(rating.getTurnAround());
					row.createCell((short) 2).setCellValue(rating.getPercentileTr());
					row.createCell((short) 3).setCellValue(rating.getShortlistRatio());
					row.createCell((short) 4).setCellValue(rating.getPercentileSh());
					row.createCell((short) 5).setCellValue(rating.getClosureRatio());
					row.createCell((short) 6).setCellValue(rating.getPercentileCl());
					row.createCell((short) 7).setCellValue(rating.getOfferdrop());
					row.createCell((short) 8).setCellValue(rating.getPercentileOd());
					row.createCell((short) 9).setCellValue(rating.getIndustrycoverage());
					row.createCell((short) 10).setCellValue(rating.getPercentileInC());
					row.createCell((short) 11).setCellValue(rating.getConsultant().getConsultName());
					row.createCell((short) 12).setCellValue(rating.getPost().getTitle());
					row.createCell((short) 13).setCellValue(rating.getPercentile());
					i++;
				}
				FileOutputStream fileOut = new FileOutputStream(filename);
				workbook.write(fileOut);
				fileOut.close();
			} catch ( Exception ex ) {
		    System.out.println(ex);
		}
}
	
}
