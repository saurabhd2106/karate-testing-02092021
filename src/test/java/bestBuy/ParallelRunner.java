package bestBuy;

import static org.junit.jupiter.api.Assertions.*;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

public class ParallelRunner {
	
	Results results;

	@Test
	public void executeKarateTests() {

		results = Runner.path("classpath:bestBuy/product")
				.outputCucumberJson(true)
				.outputHtmlReport(true)
				.outputHtmlReport(true)
				.parallel(5);

		
		
		assertEquals(0, results.getFailCount(), results.getErrorMessages());
		
		
	}
	
	@AfterEach
	public void generatingCucumberReport() {
		generateCucumberReport(results.getReportDir());
		
	}
	
	private void generateCucumberReport(String reportPath) {
		
		reportPath = reportPath.trim();
		
		File reportDir = new File(reportPath);
		
		Collection<File> allJsonFiles = FileUtils.listFiles(reportDir, new String[] {"json"}, true);
		
		List<String> jsonFiles = new ArrayList<String>();
		
		allJsonFiles.forEach(File -> jsonFiles.add(File.getAbsolutePath()));
		
		Configuration configuration = new Configuration(reportDir, "Karate Framework - Best Buy Report");
		
		ReportBuilder reportBuilder = new ReportBuilder(jsonFiles, configuration);
		
		reportBuilder.generateReports();
	}

}
